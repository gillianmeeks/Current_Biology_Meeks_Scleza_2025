# Load Libraries
library(optparse)
library(ggplot2)
library(dplyr)
library(tidyr)
library(cowplot)

# Command Line Arguments
option_list <- list(
	make_option(c("-f", "--file1"), type = "character", help = "Input CSV file 1"),
	make_option(c("-v", "--file2"), type = "character", help = "Input CSV file 2"),
	make_option(c("--median1"), type = "double", help = "Genome-wide median IBD for subset 1; Himba Random Unrelated Dataset Median = 0.0309948"),
	make_option(c("--median2"), type = "double", help = "Genome-wide median IBD for subset 2; Himba Subset Individuals Dataset Median = 0.0277666"),
	make_option(c("--sd1"), type = "double", help = "SD for subset 1; Himba Random Unrelated Dataset Standard Deviation = 0.0111911"),
	make_option(c("--sd2"), type = "double", help = "SD for subset 2; Himba Subset Dataset Standard Deviation = 0.0118936"),
	make_option(c("-o", "--output"), type = "character", default = "output_plot.png", help = "Output PNG filename [default = %default]")
)

opt_parser <- OptionParser(
	usage =  "Usage: %prog [options]",
	option_list = option_list)
opt <- parse_args(opt_parser)

# Check for required options
required <- c("file1", "file2", "median1", "median2", "sd1", "sd2")
missing <- required[!required %in% names(opt) | sapply(opt[required], is.null)]
if (length(missing) > 0) {
	stop(paste("Missing required options:", paste(missing, collapse = ", ")),
	paste("Required Format: -f <file1.csv> -v <file2.csv> --median1 <genome-wide median of first file> --median <genome-wide median of second file> --sd1 <standard deviation of first file> --sd2 <standard deviation of second file> --output [OPTIONAL - output file name]"))
}

process_data <- function(file_path) {
    data <- read.csv(file_path, sep = ",", header = TRUE, stringsAsFactors = FALSE, fill = TRUE, check.names = FALSE, quote = "\"")
    
    binned_data <- data %>%
        mutate(bin = floor(base_pair /  1000) * 1000) %>%
        select(bin, frequency) %>%
        group_by(bin) %>%
        summarize(across(everything(), \(x) mean(x, na.rm = TRUE))) %>%
        pivot_longer(cols = -bin, names_to = "relationship", values_to = "average_frequency") %>%
        mutate(relationship = "Pairs")
    
    return(binned_data)
}

# Read and process each dataset
binned_data_subset1 <- process_data(opt$file1)
binned_data_subset2 <- process_data(opt$file2)

# Define genome-wide median IBD values for each dataset
thresholds <- list(
    subset1 = opt$median1,
    subset2 = opt$median2
)

# Define the highlighted region in megabases
highlight_region <- data.frame(
    xmin = 28.48,  
    xmax = 33.45,  
    ymin = -Inf,  
    ymax = Inf  
)

# Define SD regions
sd_subset1 <- data.frame(
	xmin = 0,
	xmax = Inf,
	ymin = opt$median1 - (2 * opt$sd1),
	ymax = opt$median1 + (2 * opt$sd1)
)

sd_subset2 <- data.frame(
        xmin = 0,
        xmax = Inf,
        ymin = opt$median2 - (2 * opt$sd2),
        ymax = opt$median2 + (2 * opt$sd2) 
)

sds <- list(
    subset1 =  sd_subset1,
    subset2 = sd_subset2
)

# Function to create a plot for each dataset
create_plot <- function(binned_data, title_text, threshold, sd_data) {
    ggplot(binned_data, aes(x = bin / 1e6, y = average_frequency, group = 1)) +
        geom_line(color = "purple", linewidth = 0.8) +
        geom_hline(yintercept = threshold, linetype = "dashed", color = "black", linewidth = 0.8) +
        scale_linetype_manual(values = c("Genome-Wide Median IBD" = "dashed")) +
        scale_color_manual(values = c("Pairs" = "purple")) +
        scale_x_continuous(
            breaks = seq(0, max(binned_data$bin / 1e6, na.rm = TRUE), by = 10),
            labels = scales::comma_format(scale = 1)
        ) +
        labs(
            title = title_text,
            x = "Location (Mb)",
            y = "IBD Frequency"
        ) +
        theme_minimal(base_size = 14) +
	theme(legend.position = "none") +
        geom_rect(data = highlight_region, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
                  fill = "gray", alpha = 0.2, inherit.aes = FALSE) +
	geom_rect(data = sd_data, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = "purple", alpha = 0.2, inherit.aes = FALSE)
}

# Create plots with specific median and standard deviation IBD values
plot_randoms <- create_plot(binned_data_subset1, "Subset 1 Pairs", thresholds$subset1, sd_subset1)
plot_subset <- create_plot(binned_data_subset2, "Subset 2 Pairs", thresholds$subset2, sd_subset2)

legend_data <- data.frame(
	x = c(1, 2),
	y = c(1, 2),
	group = c("Average IBD per 1000 bases", "Genome-Wide Median IBD")
)

legend_plot <- ggplot(legend_data, aes(x, y, color = group, linetype = group)) +
	geom_line(linewidth = 1) +
	scale_color_manual(values = c("Average IBD per 1000 bases" = "purple", "Genome-Wide Median IBD" = "black")) + 
	scale_linetype_manual(values = c("Genome-Wide Median IBD" = "dashed", "Average IBD per 1000 bases" = "solid")) +
	theme_void() +
	theme(legend.position = "bottom") +
	guides(color = guide_legend(title = NULL), linetype = guide_legend(title = NULL))

legend <- get_legend(legend_plot)

# Arrange plots: 
final_plot <- plot_grid(
    plot_grid(plot_randoms, plot_subset, ncol = 1, labels = c("A", "B"), label_size = 14, label_y = 1.02),
    ncol = 1
)

final_plot_with_legend <- plot_grid(final_plot, legend, ncol = 1, rel_heights = c(1, 0.1))

# Save the final figure
ggsave(opt$output, plot = final_plot_with_legend, width = 16, height = 12, dpi = 300)
