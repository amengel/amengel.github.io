# Load Packages -----------------------------------------------------------
### Uncomment (remove the #) to install packages if not already downloaded
# install.packages("psych")
# install.packages("lavaan")

library(psych)
library(lavaan)


# Load Data ---------------------------------------------------------------
# 1986 American National Election Study, non-Hispanic white respondents
# apply function read.csv to URL, pulling in web-hosted CSV file
# store as data frame object
anes86w <- read.csv("https://amengelhardt.com/files/anes_1986_tarman&sears2005.csv")

# Calculate Means ---------------------------------------------------------
# specify an object -- v -- with elements names for variables
v <- c("sr_generations", "sr_realchange", 
       "sr_tryhard", "sr_workway", "sr_welfare", 
       "sr_deserveless", "sr_complaint", 
       "sr_crspeed")
# looking only at these variables, calculate, for each column, the 
apply(anes86w[, v], 2, function(x){x01 <- (x-1)/max(x-1, na.rm = T); round(mean(x01, na.rm = T), 2)})

# Calculate Reliabilities ---------------------------------------------------
# pg 737
# full scale.
v <- c("sr_tryhard", "sr_generations", "sr_crspeed", "sr_welfare",   
       "sr_deserveless", "sr_complaint", "sr_workway", "sr_realchange")
# apply alpha() function to data with selected variables
alpha(x = anes86w[, v])

# dominant ideology
v <- c("sr_generations", "sr_realchange", "sr_tryhard", "sr_workway", "sr_welfare")
alpha(anes86w[, v])

# political resentment
v <- c("sr_crspeed", "sr_deserveless", "sr_complaint")
alpha(anes86w[, v])

# purged
v <- c("sr_tryhard", "sr_generations", "sr_crspeed", "sr_realchange")
alpha(anes86w[, v])

# OFR
v <- c("ofr_divineplan", "ofr_lessable")
alpha(anes86w[, v])


# CFAs ---------------------------------------------------------------------
# Figure 1: 1986 ANES -----------------------------------------------------
# * Single SR Factor ------------------------------------------------------
# specify factor model
m_1sr <- '
# define factors
sr =~ sr_welfare + sr_workway + sr_tryhard + sr_realchange + sr_generations + sr_deserveless + sr_complaint + sr_crspeed
'
# estimate CFA using specified model and robust ML estimator. store results
out_1sr <- cfa(model = m_1sr, data = anes86w, estimator = "MLR")
# print results including model fit stats and the standardized solution
summary(out_1sr, fit.measures = T, standardized = T)
# extract the additional AGFI fit measure reported in the text
fitmeasures(out_1sr)["agfi"]

# * Dominant/Political ----------------------------------------------------
m_dp <- '
# define factors
dominant =~ sr_welfare + sr_workway + sr_tryhard + sr_realchange + sr_generations
political =~ sr_deserveless + sr_complaint + sr_crspeed

# second order
sr =~ NA*dominant + a*dominant + a*political

# fix global factor variances to 1
sr ~~ 1*sr
'
out_dp <- cfa(m_dp, anes86w, estimator = "MLR")
summary(out_dp, fit.measures = T, standardized = T)

# * Structural/Individual -------------------------------------------------
m_si <- '
# define factors
structural =~ sr_generations + sr_realchange + sr_deserveless + sr_complaint + sr_crspeed
individual =~ sr_welfare + sr_workway + sr_tryhard

# second order
sr =~ NA*structural + a*structural + a*individual

# fix global factor variances to 1
sr ~~ 1*sr
'
out_si <- cfa(m_si, anes86w, estimator = "MLR")
summary(out_si, fit.measures = T, standardized = T)

# Figure 3: 1986 ANES ----------------------------------------------------
# * SR Theory --------------------------------------------------------------
m_srTheory <- '
# define factors
# symbolic racism
sr =~ NA*sr_generations + sr_deserveless + sr_crspeed + sr_tryhard + sr_workway + sr_welfare
# old-fashioned racism
ofr =~ NA*ofr_divineplan + ofr_lessable
# partisan attitudes
pidAtt =~ NA*pid + ideo 
# individualism
indiv =~ NA*indiv_hwSuccess + indiv_failsame + indiv_willwork
# anti-egalitarianism
antiegal =~ NA*egal_ensureEO + egal_probnoequal + egal_lessproblem

# fix factor variances to 1
sr ~~ 1*sr
ofr ~~ 1*ofr
pidAtt ~~ 1*pidAtt
indiv ~~ 1*indiv
antiegal ~~ 1*antiegal
'
out_srTheory <- cfa(m_srTheory, anes86w, estimator = "MLR")
summary(out_srTheory, fit.measures = T, standardized = T)

# * PC Theory --------------------------------------------------------------
m_pcTheory <- '
# define factors
# symbolic racism
sr =~ NA*sr_generations + sr_deserveless + sr_crspeed + sr_tryhard + sr_workway + sr_welfare +
pid + ideo
# old-fashioned racism
ofr =~ NA*ofr_divineplan + ofr_lessable
# individualism
indiv =~ NA*indiv_hwSuccess + indiv_failsame + indiv_willwork
# anti-egalitarianism
antiegal =~ NA*egal_ensureEO + egal_probnoequal + egal_lessproblem

# fix factor variances to 1
sr ~~ 1*sr
ofr ~~ 1*ofr
indiv ~~ 1*indiv
antiegal ~~ 1*antiegal
'
out_pcTheory <- cfa(m_pcTheory, anes86w, estimator = "MLR")
summary(out_pcTheory, fit.measures = T, standardized = T)

# * One Racism Theory ------------------------------------------------------
m_oneRacismTheory <- '
# define factors
# racism
racism =~ NA*sr_generations + sr_deserveless + sr_crspeed + sr_tryhard + sr_workway + sr_welfare +
ofr_divineplan + ofr_lessable
# partisan attitudes
pidAtt =~ NA*pid + ideo 
# individualism
indiv =~ NA*indiv_hwSuccess + indiv_failsame + indiv_willwork
# anti-egalitarianism
antiegal =~ NA*egal_ensureEO + egal_probnoequal + egal_lessproblem

# fix factor variances to 1
racism ~~ 1*racism
pidAtt ~~ 1*pidAtt
indiv ~~ 1*indiv
antiegal ~~ 1*antiegal
'
out_oneRacismTheory <- cfa(m_oneRacismTheory, anes86w, estimator = "MLR")
summary(out_oneRacismTheory, fit.measures = T, standardized = T)
# * Structuralism/Individualism I -----------------------------------------
m_weakAttribTheory <- '
# define factors
# individualism
indiv =~ NA*indiv_hwSuccess + indiv_failsame + indiv_willwork + sr_crspeed + sr_tryhard + sr_workway + sr_welfare
# strcturalism
struct =~ NA*egal_ensureEO + egal_probnoequal + egal_lessproblem + sr_generations + sr_deserveless
# old-fashioned racism
ofr =~ NA*ofr_divineplan + ofr_lessable
# partisan attitudes
pidAtt =~ NA*pid + ideo 

# fix factor variances to 1
indiv ~~ 1*indiv
struct ~~ 1*struct
ofr ~~ 1*ofr
pidAtt ~~ 1*pidAtt
'
out_weakAttribTheory <- cfa(m_weakAttribTheory, anes86w, estimator = "MLR")
summary(out_weakAttribTheory, fit.measures = T, standardized = T)

# * Structuralism/Individualism II ----------------------------------------
m_strongAttribTheory <- '
# define factors
# individualism
indiv =~ NA*indiv_hwSuccess + indiv_failsame + indiv_willwork + 
sr_crspeed + sr_tryhard + sr_workway + sr_welfare +
ofr_divineplan + ofr_lessable
# strcturalism
struct =~ NA*egal_ensureEO + egal_probnoequal + egal_lessproblem + 
sr_generations + sr_deserveless
# partisan attitudes
pidAtt =~ NA*pid + ideo 

# fix factor variances to 1
indiv ~~ 1*indiv
struct ~~ 1*struct
pidAtt ~~ 1*pidAtt
'
out_strongAttribTheory <- cfa(m_strongAttribTheory, anes86w, estimator = "MLR")
summary(out_strongAttribTheory, fit.measures = T, standardized = T)
# * SR Theory w/Variants ----------------------------------------------------
m_srVariantsTheory <- '
# define factors
# symbolic racism
sr_struct =~ NA*sr_generations + sr_deserveless + sr_crspeed
sr_indiv =~ NA*sr_tryhard + sr_workway + sr_welfare
# old-fashioned racism
ofr =~ NA*ofr_divineplan + ofr_lessable
# partisan attitudes
pidAtt =~ NA*pid + ideo 
# individualism
indiv =~ NA*indiv_hwSuccess + indiv_failsame + indiv_willwork
# anti-egalitarianism
antiegal =~ NA*egal_ensureEO + egal_probnoequal + egal_lessproblem

# fix factor variances to 1
sr_struct ~~ 1*sr_struct
sr_indiv ~~ 1*sr_indiv
ofr ~~ 1*ofr
pidAtt ~~ 1*pidAtt
indiv ~~ 1*indiv
antiegal ~~ 1*antiegal
'
out_srVariantsTheory <- cfa(m_srVariantsTheory, anes86w, estimator = "MLR")
summary(out_srVariantsTheory, fit.measures = T, standardized = T)



