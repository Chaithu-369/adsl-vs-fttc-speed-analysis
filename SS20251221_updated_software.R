# Clear workspace
rm(list = ls())

# Load required libraries
library(readxl)
library(dplyr)
library(ggplot2)

# Read Excel dataset from the given path
data <- read_excel("-17.csv.xlsx")

# View structure (logged in R console)
str(data)

# ----------------------------------------------------------
# Data preparation
# ----------------------------------------------------------

# Select required columns ONLY
data_clean <- data %>%
  select(
    Technology,
    DownloadSpeed = t24hr
  )

# Remove missing values
data_clean <- data_clean %>%
  filter(!is.na(Technology), !is.na(DownloadSpeed))

# Keep only ADSL and FTTC
data_clean <- data_clean %>%
  filter(Technology %in% c("ADSL", "FTTC"))

# Convert Technology to factor
data_clean$Technology <- factor(data_clean$Technology,
                                levels = c("ADSL", "FTTC"))

# Ensure download speed is numeric
data_clean$DownloadSpeed <- as.numeric(data_clean$DownloadSpeed)

# ----------------------------------------------------------
# Descriptive statistics
# ----------------------------------------------------------

descriptive_stats <- data_clean %>%
  group_by(Technology) %>%
  summarise(
    Sample_Size = n(),
    Mean_Download_Speed = mean(DownloadSpeed),
    SD_Download_Speed = sd(DownloadSpeed)
  )

print(descriptive_stats)

# ----------------------------------------------------------
# Visualisation
# ----------------------------------------------------------

# Histogram (required supplementary graphic)
ggplot(data_clean, aes(x = DownloadSpeed)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  facet_wrap(~Technology) +
  labs(
    title = "Distribution of 24-hour Download Speeds by Broadband Technology",
    x = "24-hour Average Download Speed (Mbps)",
    y = "Frequency"
  ) +
  theme_minimal()

# Boxplot (main comparison plot)
ggplot(data_clean, aes(x = Technology, y = DownloadSpeed, fill = Technology)) +
  geom_boxplot() +
  labs(
    title = "Comparison of 24-hour Download Speeds: FTTC vs ADSL",
    x = "Broadband Technology",
    y = "24-hour Average Download Speed (Mbps)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")
# ----------------------------------------------------------
# Statistical Analysis – Independent Samples t-test
# ----------------------------------------------------------

t_test_result <- t.test(
  DownloadSpeed ~ Technology,
  data = data_clean,
  alternative = "two.sided",
  var.equal = FALSE
)

print(t_test_result)
# ----------------------------------------------------------
# Hypothesis decision based on p-value
# ----------------------------------------------------------

alpha <- 0.05

if (t_test_result$p.value < alpha) {
  cat("Decision: Reject the null hypothesis (H0).\n")
  cat("There is a statistically significant difference in mean 24-hour\n")
  cat("download speeds between FTTC and ADSL broadband connections in the UK.\n")
} else {
  cat("Decision: Fail to reject the null hypothesis (H0).\n")
  cat("There is no statistically significant difference in mean 24-hour\n")
  cat("download speeds between FTTC and ADSL broadband connections in the UK.\n")
}
