# Brexit Effects
# Synthetic Control Modeling Effects of Brexit on GBR's GDP
## Overview
- This project applies a Synthetic Control Method (SCM) to estimate the counterfactual trajectory of U.K. per capita GDP had Brexit not occurred, using a weighted combination of similar OECD economies as the donor pool. The analysis isolates the economic effects of Brexit by comparing actual U.K. GDP to a synthetic U.K. built from the economic characteristics of peer countries.
- Tools Used: R, Synth, ggplot2
- Data Period: 2000–2023
- Treatment Year: 2016 (year of Brexit referendum)
- Donor Pool: France, Netherlands, Sweden, Germany, Canada

## Data & Preprocessing
- Outcome Variable: Real GDP per capita (rgdppc)
- Predictors: trade (Exports + imports as % of GDP), pop (Population), unrate (Unemployment rate)
- Source: OECD (compiled manually)
- Countries were assigned an index for the Synth package. GBR = 1

## Methodology
- Used dataprep() and synth() functions from the Synth package to construct a counterfactual U.K.
- The SCM was trained on the pre-treatment period from 2000–2015, using mean values of predictors.
- Fitted weights on donor countries were:
Netherlands (42.7%)
Canada (57.3%)
All others ≈ 0%
- Variable importance (solution.v):
unrate: 99.4%
trade: 0.6%
pop: ~0%

## Key Findings
- The synthetic U.K. closely tracks actual U.K. GDP before 2016, validating the model fit.
- After Brexit: Actual U.K. GDP per capita began to underperform the synthetic control starting around 2020, with the largest divergence in 2020–2021, during the COVID-19 pandemic.
- While COVID disrupted global economies, the synthetic control provides a benchmark showing that U.K.'s GDP underperformed relative to comparable economies, suggesting that Brexit may have compounded the pandemic’s impact.
- RMSPE (Root Mean Squared Prediction Error) ratio (post/pre): 1.14 -> This modest increase suggests a divergence post-treatment but not a dramatic structural break, possibly due to overlapping effects from COVID-19.

## Files
- brexitsynth.csv: Input dataset for Synth model
- brexit_model.R: R script to run the SCM
- brexit_plot.png: Visualization comparing actual and synthetic U.K. GDP

## Visualization
A plot of actual vs. synthetic GDP shows how the U.K. deviated from its synthetic counterpart post-Brexit. This gap is largest during the COVID period, indicating a possible interaction between Brexit and pandemic-induced shocks.
