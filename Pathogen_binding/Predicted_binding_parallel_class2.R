#########class 2########
library(future)
library(future.apply)
load("class2_binding_dfs.RData")
load("child_genos.RData")
print(head(binding_subset))

binding_subset <- binding_subset[1:10, 1:6]


#binding_subset <- head(binding_subset)
look_up <- function(genotypes, restricted_df){
    subset_ <- restricted_df
    i <- 1
    bound_list <- c()
    while(i <= 64){
        print(head(subset_))
        bound_ <- rbind(subset_[subset_$V2 %in% c(genotypes[[1]][[i]]),  ],
        subset_[subset_$V2 %in% c(genotypes[[1]][[i+1]]),  ],
        subset_[subset_$V2 %in% c(genotypes[[1]][[i+2]]),  ],
        subset_[subset_$V2 %in% c(genotypes[[1]][[i+3]]),  ])
        bound <- list(length(unique(bound_$V3)))
        bound_list <- c(bound_list, bound)
        i <- i + 4
        }
    return(bound_list)

    }
                                                 
plan(multisession)  # or plan(multicore) on Linux

# Create a function to encapsulate the variable creation logic
create_binding_variable <- function(binding_df, genotypes_column, restricted_df) {
  return(look_up(genotypes = binding_df[[genotypes_column]], restricted_df = restricted_df))
}

# List of binding variables and their corresponding restricted dataframes
binding_variables <- list(
  all_SB_DP = all_SB_DP,
  all_SB_DQ = all_SB_DQ,
  all_WSB_DP = all_WSB_DP,
  all_WSB_DQ = all_WSB_DQ,
  int_SB_DP = int_SB_DP,
  int_SB_DQ = int_SB_DQ,
  int_WSB_DP = int_WSB_DP,
  int_WSB_DQ = int_WSB_DQ,
  ex_SB_DP = ex_SB_DP,
  ex_SB_DQ = ex_SB_DQ,
  ex_WSB_DP = ex_WSB_DP,
  ex_WSB_DQ = ex_WSB_DQ,
  int_ex_SB_DP = int_ex_SB_DP,
  int_ex_SB_DQ = int_ex_SB_DQ,
  int_ex_WSB_DP = int_ex_WSB_DP,
  int_ex_WSB_DQ = int_ex_WSB_DQ
)

# Create new variables in parallel
for (var_name in names(binding_variables)) {
  restricted_df <- binding_variables[[var_name]]
  
  # The column index corresponds to the original column names
  column_index <- switch(var_name,
                         all_SB_DP = 7,
                         all_SB_DQ = 8,
                         all_WSB_DP = 7,
                         all_WSB_DQ = 8,
                         int_SB_DP = 7,
                         int_SB_DQ = 8,
                         int_WSB_DP = 7,
                         int_WSB_DQ = 8,
                         ex_SB_DP = 7,
                         ex_SB_DQ = 8,
                         ex_WSB_DP = 7,
                         ex_WSB_DQ = 8,
                         int_ex_SB_DP = 7,
                         int_ex_SB_DQ = 8,
                         int_ex_WSB_DP = 7,
                         int_ex_WSB_DQ = 8)

  # Run the look_up function in parallel for each new variable
  binding_subset[[var_name]] <- future_lapply(1:nrow(binding_subset), function(i) {
    look_up(genotypes = binding_subset[i, column_index], restricted_df = restricted_df)
  })
}

# Cleanup: Reset future plan
plan(sequential)
save(binding_subset, file="DP_DQ_binding.RData")

#########class 2########
load("class2_binding_dfs.RData")
load("child_genos.RData")
print(binding_subset)
print(nrow(binding_subset))
look_up_DR <- function(genotypes, restricted_df){
    subset_ <- restricted_df
    i <- 1
    bound_list <- c()
    while(i <= 8){
        bound_ <- rbind(subset_[subset_$V2 %in% c(genotypes[[1]][[i]]),], subset_[subset_$V2 %in% c(genotypes[[1]][[i+1]]),])
        bound <- list(length(unique(bound_$V3)))
        bound_list <- c(bound_list, bound)
        i <- i + 2
        }
    return(bound_list)

    }                                                   
plan(multisession)  # or plan(multicore) on Linux

# Create a function to encapsulate the variable creation logic
create_binding_variable <- function(binding_df, genotypes_column, restricted_df) {
  return(look_up(genotypes = binding_df[[genotypes_column]], restricted_df = restricted_df))
}

# List of binding variables and their corresponding restricted dataframes
binding_variables <- list(
  all_SB_DRB1 = all_SB_DRB1,
  all_WSB_DRB1 = all_WSB_DRB1,
  int_SB_DRB1 = int_SB_DRB1,
  int_WSB_DRB1 = int_WSB_DRB1,
  ex_SB_DRB1 = ex_SB_DRB1,
  ex_WSB_DRB1 = ex_WSB_DRB1,
  int_ex_SB_DRB1 = int_ex_SB_DRB1,
  int_ex_WSB_DRB1 = int_ex_WSB_DRB1
)

# Create new variables in parallel
for (var_name in names(binding_variables)) {
  restricted_df <- binding_variables[[var_name]]
  
  # The column index corresponds to the original column names
  column_index <- switch(var_name,
                         all_SB_DRB1 = 9,
                         all_WSB_DRB1 = 9,
                         int_SB_DRB1 = 9,
                         int_WSB_DRB1 = 9,
                         ex_SB_DRB1 = 9,
                         ex_WSB_DRB1 = 9,
                         int_ex_SB_DRB1 = 9,
                         int_ex_WSB_DRB1 = 9)

  # Run the look_up function in parallel for each new variable
  binding_subset[[var_name]] <- future_lapply(1:nrow(binding_subset), function(i) {
    look_up_DR(genotypes = binding_subset[i, column_index], restricted_df = restricted_df)
  })
}

# Cleanup: Reset future plan
plan(sequential)

save(binding_subset, file="DRB1_binding.RData")