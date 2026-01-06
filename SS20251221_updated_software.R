library(readxl)
library(dplyr)

data <- read_excel("-17.csv.xlsx")
names(data) <- trimws(names(data))

str(data)

data_clean <- data %>%
  select(Technology, DownloadSpeed = t24hr) %>%
  filter(!is.na(Technology), !is.na(DownloadSpeed)) %>%
  filter(Technology %in% c("ADSL","FTTC"))

data_clean$Technology <- factor(data_clean$Technology,
                                levels=c("ADSL","FTTC"))

data_clean$DownloadSpeed <- as.numeric(data_clean$DownloadSpeed)

print(table(data_clean$Technology))

descriptive_stats <- data_clean %>%
  group_by(Technology) %>%
  summarise(
    n = n(),
    mean = mean(DownloadSpeed),
    sd = sd(DownloadSpeed),
    .groups="drop"
  )

print(descriptive_stats)

library(ggplot2)

ggplot(data_clean, aes(x=DownloadSpeed)) +
  geom_histogram(binwidth=5, color="black") +
  facet_wrap(~Technology) +
  theme_minimal()

ggplot(data_clean, aes(x=Technology, y=DownloadSpeed)) +
  geom_boxplot(color="black") +
  theme_minimal()

t_test_result <- t.test(
  DownloadSpeed ~ Technology,
  data = data_clean,
  alternative="two.sided",
  var.equal=FALSE
)

print(t_test_result)

alpha <- 0.05

if (t_test_result$p.value < alpha) {
  cat("Decision: Reject H0 — significant difference in speeds.\n")
} else {
  cat("Decision: Fail to reject H0.\n")
}

