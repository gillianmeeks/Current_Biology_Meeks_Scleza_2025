###class 1####
library(future)
library(future.apply)
load("class1_binding_dfs.RData")
load("child_genos.RData")




###look up binding repertoire of genotypes
look_up <- function(genotypes, restricted_df){
    subset_ <- restricted_df
    i <- 1
    bound_list <- c()
    while(i <= 8){
        print(head(subset_))
        bound_ <- rbind(subset_[subset_$V2 %in% c(genotypes[[1]][[i]]),], subset_[subset_$V2 %in% c(genotypes[[1]][[i+1]]),])
        bound <- list(length(unique(bound_$V4)))
        bound_list <- c(bound_list, bound)
        i <- i + 2
        }
    return(bound_list)

    }
# Set up parallel processing plan (use all available cores)
plan(multisession)  # or plan(multicore) on Linux

# Create a function to encapsulate the variable creation logic
create_binding_variable <- function(binding_df, genotypes_column, restricted_df) {
  return(look_up(genotypes = binding_df[[genotypes_column]], restricted_df = restricted_df))
}

# List of binding variables and their corresponding restricted dataframes
binding_variables <- list(
  all_SB_A = all_SB_A,
  all_SB_B = all_SB_B,
  all_SB_C = all_SB_C,
  all_WSB_A = all_WSB_A,
  all_WSB_B = all_WSB_B,
  all_WSB_C = all_WSB_C,
  int_SB_A = int_SB_A,
  int_SB_B = int_SB_B,
  int_SB_C = int_SB_C,
  int_WSB_A = int_WSB_A,
  int_WSB_B = int_WSB_B,
  int_WSB_C = int_WSB_C,
  ex_SB_A = ex_SB_A,
  ex_SB_B = ex_SB_B,
  ex_SB_C = ex_SB_C,
  ex_WSB_A = ex_WSB_A,
  ex_WSB_B = ex_WSB_B,
  ex_WSB_C = ex_WSB_C,
  int_ex_SB_A = int_ex_SB_A,
  int_ex_SB_B = int_ex_SB_B,
  int_ex_SB_C = int_ex_SB_C,
  int_ex_WSB_A = int_ex_WSB_A,
  int_ex_WSB_B = int_ex_WSB_B,
  int_ex_WSB_C = int_ex_WSB_C
)

# Create new variables in parallel
for (var_name in names(binding_variables)) {
  restricted_df <- binding_variables[[var_name]]
  
  # The column index corresponds to the original column names
  column_index <- switch(var_name,
                         all_SB_A = 4,
                         all_SB_B = 5,
                         all_SB_C = 6,
                         all_WSB_A = 4,
                         all_WSB_B = 5,
                         all_WSB_C = 6,
                         int_SB_A = 4,
                         int_SB_B = 5,
                         int_SB_C = 6,
                         int_WSB_A = 4,
                         int_WSB_B = 5,
                         int_WSB_C = 6,
                         ex_SB_A = 4,
                         ex_SB_B = 5,
                         ex_SB_C = 6,
                         ex_WSB_A = 4,
                         ex_WSB_B = 5,
                         ex_WSB_C = 6,
                         int_ex_SB_A = 4,
                         int_ex_SB_B = 5,
                         int_ex_SB_C = 6,
                         int_ex_WSB_A = 4,
                         int_ex_WSB_B = 5,
                         int_ex_WSB_C = 6)

  # Run the look_up function in parallel for each new variable
  binding_subset[[var_name]] <- future_lapply(1:nrow(binding_subset), function(i) {
    look_up(genotypes = binding_subset[i, column_index], restricted_df = restricted_df)
  })
}

# Cleanup: Reset future plan
plan(sequential)  # Switch back to sequential processing when done


save(binding_subset, file="class1_binding.RData")




