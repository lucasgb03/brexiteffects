library(Synth)
#GDP per capita in GBR post brexit, and in counterfactual post Brexit time frame if Brexit did not occur
# Load data
df <- read_csv("brexitsynth.csv")
unique(df[,c('index','country')])

df <- as.data.frame(df)
df <- df[, 1:7]

#prep data
prep <- dataprep(
  foo = df,
  predictors.op = 'mean',
  predictors   = c('trade','pop','unrate'),
  dependent     = 'rgdppc',
  unit.variable = 'index',
  time.variable = 'year',
  treatment.identifier = 1,
  controls.identifier = unique(df$index)[-1],
  time.predictors.prior = 2000:2015,
  time.optimize.ssr = 2000:2015,
  unit.names.variable = 'country',
  time.plot = 2000:2023
)

#model
fit <- synth(prep)

#countries
countries <- df[match(unique(df$index)[-1], df$index), 'country']

#weights
wt <- data.frame(countries, fit$solution.w)
wt

#v
v <- fit$solution.v
v

#plot
path.plot(synth.res = fit,
          dataprep.res = prep,
          tr.intake = 2016,
          Ylab = 'Per capita GDP',
          Xlab = 'Year',
          Legend = c('GBR', 'Synthetic GBR'),
          Main = 'Brexit Effects')

#Compute
gbr <- prep$Y1plot
gdp <- prep$Y0plot
synth <- gdp %*% fit$solution.w
treatment <- gbr - synth
treatment

# Calculate pre-treatment RMSPE
pre_years <- which(2000:2023 < 2016)
rmspe_pre <- sqrt(mean((gbr[pre_years] - synth[pre_years])^2))

# post-treatment RMSPE
post_years <- which(2000:2023 >= 2016)
rmspe_post <- sqrt(mean((gbr[post_years] - synth[post_years])^2))

# Ratio of post- to pre-treatment RMSPE (placebo test indicator)
rmspe_ratio <- rmspe_post / rmspe_pre
rmspe_ratio

