# adsl-vs-fttc-speed-analysis

## Overview
This project performs a quantitative comparison of **24-hour average download speeds (Mbps)** between:

- **ADSL** — legacy copper-based broadband  
- **FTTC** — fibre-to-the-cabinet next-generation broadband  

using the measured Ofcom dataset provided in the Excel file.

## Files in Repository Root
- `README.md` — project documentation  
- `-17.csv.xlsx` — broadband performance dataset (Technology, t24hr)  
- `SS20251221_updated_software.R` — R script implementing:
  - data cleaning & preprocessing  
  - descriptive statistics  
  - histogram visualisation  
  - boxplot comparison  
  - Welch two-sample t-test  
- `SS20251221_updated_report.docx` — final academic report

## Research Question
**Do the mean 24-hour download speeds of ADSL and FTTC broadband connections in the UK differ statistically significantly?**

### Hypotheses
- **H₀:** No difference in mean speeds between ADSL and FTTC  
- **H₁:** Significant difference exists

## Requirements

### Software
- R (version 4.x recommended)  
- RStudio recommended

### Packages
Install in R:

```r
install.packages(c("readxl", "dplyr", "ggplot2"))
