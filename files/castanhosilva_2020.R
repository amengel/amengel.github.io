# Load Packages -----------------------------------------------------------
### Uncomment (remove the #) to install packages if not already downloaded
# install.packages("psych")
# install.packages("lavaan")

library(psych)
library(lavaan)

# Load cs_dat ---------------------------------------------------------------
# Replication cs_dat from Castanho Silva et al 2020
# apply function read.csv to URL, pulling in web-hosted CSV file
# store as cs_dat frame object
cs_dat <- read.csv("https://amengelhardt.com/files/castanhosilva_replication.csv")

# Notes on items:
# Gewill17. Politicians should always listen closely to the problems of the people.*
# Gewill3. The will of the people should be the highest principle in this country’s politics*
# simple8. Politicians don’t have to spend time among ordinary people to do a good job*
# Antiel21. Quite a few of the people running the government are crooked.*
# Antiel23. The government is pretty much run by a few big interests looking out for themselves.*
# Rwpop8. Government officials use their power to try to improve people's lives.*
# manich1. Politics is a struggle between good and evil.*
# Manich13. The people I disagree with politically are not evil.*
# Manich14. The people I disagree with politically are just misinformed.*
# Manich15. You can tell if a person is good or bad if you know their politics.*

# Calculate Reliabilities ---------------------------------------------------
# Anti-elites
v <- c("antiel23", "rwpop8", "antiel21") # vector of variable names in data set
# apply alpha() function to data with selected variables
alpha(x = cs_dat[, v], # specify the variables to look at.
      check.keys = TRUE # automatically re-score any reverse-worded items before estimating alpha
      )

# Peoples will
v <- c("gewill17", "simple8", "gewill3")
alpha(x = cs_dat[, v],
      check.keys = TRUE)

# Manicheanism
v <- c("manich15", "manich13")
alpha(x = cs_dat[, v],
      check.keys = TRUE)



# Estimate a CFA ----------------------------------------------------------
# Define the measurement model. We store an object as a set of text
cfa_cast_3f <- ' 
# define factors. each line is a separate factor.
# factor_name =~ observed_var1 + observed_var2 + observed_var3 + ....

# Anti-elites
antiel =~ antiel23 + rwpop8 + antiel21
# Peoples will
people =~ gewill17 + simple8 + gewill3
# Manicheanism
manich =~ manich15 + manich13 
'
m_3f <- cfa(data = cs_dat, # specify appropriate data set
         model = cfa_cast_3f # specify the above model
         )
summary(m_3f, # model results we want to summarize
        fit.measures = T # print measures of model fit
        )

# Reverse score the reversed items.
cs_dat$simple8.r <- (cs_dat$simple8* -1 + 8)
cs_dat$rwpop8.r <- (cs_dat$rwpop8* -1 + 8)
cs_dat$manich13.r <- (cs_dat$manich13* -1 + 8)

# We have to modify the model with our reversed variables
cfa_cast3f_rev <- '
antiel =~ antiel23 + rwpop8.r + antiel21
people =~ gewill17 + simple8.r + gewill3
manich =~ manich15 + manich13.r
'
m_3f_rev <- cfa(data = cs_dat,
                model = cfa_cast3f_rev)
summary(m_3f_rev,
        fit.measures = T)

# But what about those identification constraints I mentioned?
# Pull up help file and look at defaults
?cfa() 

m_3f_std <- cfa(data = cs_dat,
                model = cfa_cast3f_rev,
                std.lv = TRUE # standardize the latent variable
                )
summary(m_3f_std, 
        fit.measures = T, 
        standardized = T # report completely standardized solution
        )
# Complete standardized solution gives us the std.lv and std.all columns. Std.all standardizes inputs as well, not just the latent variable
# Take antiel23--square the number under std.all, then add it to the corresponding number under "variances." Totals 1--ish, right?
# Std.all^2 is the amount of variation in the variable explain by the latent variable. Variance is the residual variance in the item


# Comparing Dimensional Structure -----------------------------------------
# The authors propose a 3 factor model for their concept. But what if we thought 1 factor sufficient?
cfa_cast1f <- '
pop =~ antiel23 + rwpop8.r + antiel21 + gewill17 + simple8.r + gewill3 + manich15 + manich13.r
'
m_1f_std <- cfa(data = cs_dat,
                model = cfa_cast1f,
                std.lv = TRUE)
summary(m_1f_std,
        fit.measures = T, 
        standardized = T)

# use fitMeasures() function to extract desired information to compare
# [] says, look only at elements printed by the function sharing these names
fitMeasures(m_3f_std)[c("chisq", "df", "cfi", "srmr", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper")]
fitMeasures(m_1f_std)[c("chisq", "df", "cfi", "srmr", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper")]

# Pesky Response Sets -----------------------------------------------------
# Keep the same substantive 3 factor set but add a method factor to capture acquiesence bias
cfa_cast3_method <- '
antiel =~ antiel23 + rwpop8.r + antiel21
people =~ gewill17 + simple8.r + gewill3
manich =~ manich15 + manich13.r 

# Specify a method factor
# 1*observed_var says we are going to fix the factor loading to 1. Doing so assumes all variables are equally affected by acquiesence
method =~ 1*gewill3 + 1*antiel23 +  1*antiel21 + 1*gewill17 + 1*manich15 
# This says we want to restrict correlations between latent variables and method factor to 0
# ~~ is the symbol for (co)variance.
method ~~ 0*antiel + 0*people + 0*manich

# This says we want to estimate the variance of this method factor rather than fix it to 1
method ~~ NA*method
'

m_3f_std_method <- cfa(data = cs_dat,
                       model = cfa_cast3_method,
                       std.lv = TRUE # standardize the latent variable
                       )
summary(m_3f_std_method, fit.measures = T, standardized = T)

# compared parameter estimates to model without method factor 
summary(m_3f_std, standardized = T)

# Compare model fit
fitMeasures(m_3f_std)[c("chisq", "df", "cfi", "srmr", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper")]
fitMeasures(m_3f_std_method)[c("chisq", "df", "cfi", "srmr", "rmsea", "rmsea.ci.lower", "rmsea.ci.upper")]
