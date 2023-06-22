# Load Packages -----------------------------------------------------------
### Uncomment (remove the #) to install packages if not already downloaded
# install.packages("psych")

library(psych) # needed for fa() function
# library(nFactors)

# Load Data ---------------------------------------------------------------
# 1992-1996 American National Election Study Panel
# apply function read.csv to URL, pulling in web-hosted CSV file
# store as data frame object
anes9296 <- read.csv("https://amengelhardt.com/files/anes_19921996_ansolabehereetal2008.csv")

# collect variables
# economic issues
# use regular expression to pull all elements beginning with "econ_" from the vector of variable names
econ_vars <- grep("econ_", names(anes9296), value = T)
# store only the 1992 econ variables
econ_vars92 <- grep("_92", econ_vars, value = T)
# store only the 1996 econ variables
econ_vars96 <- grep("_96", econ_vars, value = T)

# now create vectores of econ variables that are common across years
# find and replace any string ending in "_92" with "" (deletion)
# but only do this for variables, after deleting the year suffix, that can be found in both 1992 and 1996
econ_vars_comm <- gsub("_92", "", gsub("econ_", "", econ_vars92))[which(gsub("_92", "", gsub("econ_", "", econ_vars92)) %in% gsub("_96", "", gsub("econ_", "", econ_vars96)))] 
# re-create the variable names among only the common elements for 1992
# combine together the text "econ", with each variable name, and "92", seperating these elements with "_"
econCom_vars92 <- paste("econ", econ_vars_comm, "92", sep = "_")
# combine together the text "econ", with each variable name, and "96", seperating these elements with "_"
econCom_vars96 <- paste("econ", econ_vars_comm, "96", sep = "_")

# moral issues
moral_vars <- grep("moral_", names(anes9296), value = T)
moral_vars92 <- grep("_92", moral_vars, value = T)
moral_vars96 <- grep("_96", moral_vars, value = T)

# find common items
moral_vars_comm <- gsub("_92", "", gsub("moral_", "", moral_vars92))[which(gsub("_92", "", gsub("moral_", "", moral_vars92)) %in% gsub("_96", "", gsub("moral_", "", moral_vars96)))] 
moralCom_vars92 <- paste("moral", moral_vars_comm, "92", sep = "_")
moralCom_vars96 <- paste("moral", moral_vars_comm, "96", sep = "_")

# Table A1 ----------------------------------------------------------------
# estimate 1 dimension EFAs on desired item subsets
# conduct a 1 dimension exploratory factor analysis of the 1992 economy items only for items in common across wvaes
# estimate the model using maximum likelihood
fEcon_92 <- fa(anes9296[, econCom_vars92], fm = "ml")
fEcon_96 <- fa(anes9296[, econCom_vars96], fm = "ml")
fMoral_92 <- fa(anes9296[, moralCom_vars92], fm = "ml")
fMoral_96 <- fa(anes9296[, moralCom_vars96], fm = "ml")
fPID_92 <- fa(anes9296[, c("pid7_92", "ft_reps_92", "ft_dems_92")], fm = "ml")
fPID_96 <- fa(anes9296[, c("pid7_96", "ft_reps_96", "ft_dems_96")], fm = "ml")
fIDEO_92 <- fa(anes9296[, c("ideo7_92", "ft_cons_92", "ft_libs_92")], fm = "ml")
fIDEO_96 <- fa(anes9296[, c("ideo7_96", "ft_cons_96", "ft_libs_96")], fm = "ml")

# Store scale stores from factor analyses
# the factor analysis object has several elements, one of which is a vector of factor scores
# we can assign it to a column in our existing data set
anes9296$econ92 <- fEcon_92$scores
anes9296$econ96 <- fEcon_96$scores
anes9296$moral92 <- fMoral_92$scores
anes9296$moral96 <- fMoral_96$scores
anes9296$PID92 <- fPID_92$scores
anes9296$PID96 <- fPID_96$scores
anes9296$IDEO92 <- fIDEO_92$scores
anes9296$IDEO96 <- fIDEO_96$scores


# ** Estimates by education and political information -------------------------------
# repeat the above, but by education and information subsets for the final analyses
# estimate a factor analysis if the 1992 economic variables, but only among low education folks
fEcon_educLow_92 <- fa(subset(anes9296, educ_low_92 == 1, select = econCom_vars92), fm = "ml")
fEcon_educLow_96 <- fa(subset(anes9296, educ_low_92 == 1, select = econCom_vars96), fm = "ml")
fMoral_educLow_92 <- fa(subset(anes9296, educ_low_92 == 1, select = moralCom_vars92), fm = "ml")
fMoral_educLow_96 <- fa(subset(anes9296, educ_low_92 == 1, select = moralCom_vars96), fm = "ml")

# repeat these models, but for folks with high education
fEcon_educHigh_92 <- fa(subset(anes9296, educ_high_92 == 1, select = econCom_vars92), fm = "ml")
fEcon_educHigh_96 <- fa(subset(anes9296, educ_high_92 == 1, select = econCom_vars96), fm = "ml")
fMoral_educHigh_92 <- fa(subset(anes9296, educ_high_92 == 1, select = moralCom_vars92), fm = "ml")
fMoral_educHigh_96 <- fa(subset(anes9296, educ_high_92 == 1, select = moralCom_vars96), fm = "ml")

# repeat these models, but for folks with low political knowledge
fEcon_polKnowLow_92 <- fa(subset(anes9296, int_polknow_low == 1, select = econCom_vars92), fm = "ml")
fEcon_polKnowLow_96 <- fa(subset(anes9296, int_polknow_low == 1, select = econCom_vars96), fm = "ml")
fMoral_polKnowLow_92 <- fa(subset(anes9296, int_polknow_low == 1, select = moralCom_vars92), fm = "ml")
fMoral_polKnowLow_96 <- fa(subset(anes9296, int_polknow_low == 1, select = moralCom_vars96), fm = "ml")

fEcon_polKnowHigh_92 <- fa(subset(anes9296, int_polknow_hi == 1, select = econCom_vars92), fm = "ml")
fEcon_polKnowHigh_96 <- fa(subset(anes9296, int_polknow_hi == 1, select = econCom_vars96), fm = "ml")
fMoral_polKnowHigh_92 <- fa(subset(anes9296, int_polknow_hi == 1, select = moralCom_vars92), fm = "ml")
fMoral_polKnowHigh_96 <- fa(subset(anes9296, int_polknow_hi == 1, select = moralCom_vars96), fm = "ml")

## Empty Vectors to store results
# since we're looking at data subsets, we have to create empty vectors first
# we need correspondence in the number of scores generated and available cells in our data set
anes9296$econ_educLow_92 <- NA
anes9296$econ_educLow_96 <- NA
anes9296$moral_educLow_92 <- NA
anes9296$moral_educLow_96 <- NA

# Store results
# store the low education 1992 economic issue scores as a variable
# scores assigned to only individuals low in education in 1992, otherwise they retain the missing code NA
anes9296$econ_educLow_92[which(anes9296$educ_low_92 == 1)] <- fEcon_educLow_92$scores
anes9296$econ_educLow_96[which(anes9296$educ_low_92 == 1)] <- fEcon_educLow_96$scores
anes9296$moral_educLow_92[which(anes9296$educ_low_92 == 1)] <- fMoral_educLow_92$scores
anes9296$moral_educLow_96[which(anes9296$educ_low_92 == 1)] <- fMoral_educLow_96$scores

## Empty Vectors to store results
anes9296$econ_educHigh_92 <- NA
anes9296$econ_educHigh_96 <- NA
anes9296$moral_educHigh_92 <- NA
anes9296$moral_educHigh_96 <- NA

# Store results
anes9296$econ_educHigh_92[which(anes9296$educ_high_92 == 1)] <- fEcon_educHigh_92$scores
anes9296$econ_educHigh_96[which(anes9296$educ_high_92 == 1)] <- fEcon_educHigh_96$scores
anes9296$moral_educHigh_92[which(anes9296$educ_high_92 == 1)] <- fMoral_educHigh_92$scores
anes9296$moral_educHigh_96[which(anes9296$educ_high_92 == 1)] <- fMoral_educHigh_96$scores

## Empty Vectors to store results
anes9296$econ_polKnowLow_92 <- NA
anes9296$econ_polKnowLow_96 <- NA
anes9296$moral_polKnowLow_92 <- NA
anes9296$moral_polKnowLow_96 <- NA

# Store results
anes9296$econ_polKnowLow_92[which(anes9296$int_polknow_low == 1)] <- fEcon_polKnowLow_92$scores
anes9296$econ_polKnowLow_96[which(anes9296$int_polknow_low == 1)] <- fEcon_polKnowLow_96$scores
anes9296$moral_polKnowLow_92[which(anes9296$int_polknow_low == 1)] <- fMoral_polKnowLow_92$scores
anes9296$moral_polKnowLow_96[which(anes9296$int_polknow_low == 1)] <- fMoral_polKnowLow_96$scores

## Empty Vectors to store results
anes9296$econ_polKnowHigh_92 <- NA
anes9296$econ_polKnowHigh_96 <- NA
anes9296$moral_polKnowHigh_92 <- NA
anes9296$moral_polKnowHigh_96 <- NA

# Store results
anes9296$econ_polKnowHigh_92[which(anes9296$int_polknow_hi == 1)] <- fEcon_polKnowHigh_92$scores
anes9296$econ_polKnowHigh_96[which(anes9296$int_polknow_hi == 1)] <- fEcon_polKnowHigh_96$scores
anes9296$moral_polKnowHigh_92[which(anes9296$int_polknow_hi == 1)] <- fMoral_polKnowHigh_92$scores
anes9296$moral_polKnowHigh_96[which(anes9296$int_polknow_hi == 1)] <- fMoral_polKnowHigh_96$scores

# Table 1 -----------------------------------------------------------------
# Temporal Scale Correlations
# correlate 1992 economic positions with 1996, but only among observations with values on both
cor(anes9296$econ92, anes9296$econ96, use = "complete.obs")
cor(anes9296$moral92, anes9296$moral96, use = "complete.obs")

#### Calculate average temporal correlations
# empty vectors to store 
# repeat "NA," R's notation for missing values, for the number of variables in the common Econ string
item_corrs_econ <- rep(NA, length(econCom_vars92))
item_corrs_moral <- rep(NA, length(moralCom_vars92))

# loop over items and store correlations
for(i in 1:length(item_corrs_econ)){
  # i functions as an index for counting
  # we start at 1 and count until we hit the number of variables in item_corrs_econ
  item_corrs_econ[i] <- cor(anes9296[, econCom_vars92[i]], 
                            anes9296[, econCom_vars96[i]], 
                            use = "complete.obs")
}
for(i in 1:length(item_corrs_moral)){
  item_corrs_moral[i] <- cor(anes9296[, moralCom_vars92[i]], 
                             anes9296[, moralCom_vars96[i]], 
                             use = "complete.obs")
}

# create data frame with average correlations
# one variable is called econ, taking the mean of the economic item correlations
# another variable is called moral, taking the mean of the moral item correlations
avg_corrs <- data.frame(econ = mean(item_corrs_econ),
                        moral = mean(item_corrs_moral))

# print the data frame to show the average correlatinns
avg_corrs

# PID and IDEO
# correlate the partisanship scales
cor(anes9296$PID92, anes9296$PID96, use = "complete.obs")
# correlate the individual partisanship items
cor(anes9296$pid7_92, anes9296$pid7_96, use = "complete.obs")

cor(anes9296$IDEO92, anes9296$IDEO96, use = "complete.obs")
cor(anes9296$ideo7_92, anes9296$ideo7_96, use = "complete.obs")

# Table 2  ----------------------------------------------------------------
# specify empty vectors for number of iterations we want to do
iters <- 100 # change this number to alter how many Monte Carlo iterations we do
econ_half_corrs92 <- rep(NA, iters) # create an empty vector of the same length as the number of iterations
econ_half_corrs96 <- rep(NA, iters)
moral_half_corrs92 <- rep(NA, iters)
moral_half_corrs96 <- rep(NA, iters)


# set seed for replicability
set.seed(1693)
for(i in 1:iters){
  # indicator for how long in our loop we're on
  print(i/iters)
  
  ### Econ Issues
  # sample from variables and store 
  indx <- sample(1:length(econ_vars92), length(econ_vars92)/2)
  # take the index as the first sample
  econ92_split1_vars <- econ_vars92[indx]
  # take all variables not in the index as the second sample
  econ92_split2_vars <- econ_vars92[-indx]
  # estimate factor model and store scores for split 1
  econ92_split1 <- fa(anes9296[, econ92_split1_vars], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  econ92_split2 <- fa(anes9296[, econ92_split2_vars], fm = "ml")$scores
  # estimate and store correlation
  econ_half_corrs92[i] <- cor(econ92_split1, econ92_split2, use = "complete.obs")
  
  # sample from variables and store 
  indx <- sample(1:length(econ_vars96), length(econ_vars96)/2)
  # take the index as the first sample
  econ96_split1_vars <- econ_vars96[indx]
  # take all variables not in the index as the second sample
  econ96_split2_vars <- econ_vars96[-indx]
  # estimate factor model and store scores for split 1
  econ96_split1 <- fa(anes9296[, econ96_split1_vars], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  econ96_split2 <- fa(anes9296[, econ96_split2_vars], fm = "ml")$scores
  # estimate and store correlation
  econ_half_corrs96[i] <- cor(econ96_split1, econ96_split2, use = "complete.obs")
  
  ### Moral Issues
  # sample from variables and store 
  indx <- sample(1:length(moral_vars92), length(moral_vars92)/2)
  # take the index as the first sample
  moral92_split1_vars <- moral_vars92[indx]
  # take all variables not in the index as the second sample
  moral92_split2_vars <- moral_vars92[-indx]
  # estimate factor model and store scores for split 1
  moral92_split1 <- fa(anes9296[, moral92_split1_vars], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  moral92_split2 <- fa(anes9296[, moral92_split2_vars], fm = "ml")$scores
  # estimate and store correlation
  moral_half_corrs92[i] <- cor(moral92_split1, moral92_split2, use = "complete.obs")
  
  # sample from variables and store 
  indx <- sample(1:length(moral_vars96), length(moral_vars96)/2)
  # take the index as the first sample
  moral96_split1_vars <- moral_vars96[indx]
  # take all variables not in the index as the second sample
  moral96_split2_vars <- moral_vars96[-indx]
  # estimate factor model and store scores for split 1
  moral96_split1 <- fa(anes9296[, moral96_split1_vars], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  moral96_split2 <- fa(anes9296[, moral96_split2_vars], fm = "ml")$scores
  # estimate and store correlation
  moral_half_corrs96[i] <- cor(moral96_split1, moral96_split2, use = "complete.obs")
}

### Item-pair correlations
# empty lists for storing results
# lists allow us to store data more flexibly than data frames
econ_pairs92 <- list()
econ_pairs96 <- list()
moral_pairs92 <- list()
moral_pairs96 <- list()

### Econ
# loop over 1992 variables
for(i in 1:length(econ_vars92)){
  # loop over other 1992 variables
  econ_pairs92[i] <- NA
  for(j in 1:length(econ_vars92)){
    # store correlation so for object in list is 1992 variable with elements other 1992 variable correlations
    # Only keep dissimilar variables
    if(econ_vars92[i] != econ_vars92[j]){
      # in the i-th element of the list, store its correlations with the j-th element
      econ_pairs92[[i]][[j]] <- cor(anes9296[, econ_vars92[i]], 
                                  anes9296[, econ_vars92[j]], 
                                  use = "complete.obs") 
    }
  }
}

# loop over 1996 variables
for(i in 1:length(econ_vars96)){
  # loop over other 1996 variables
  econ_pairs96[i] <- NA
  for(j in 1:length(econ_vars96)){
    # store correlation so for object in list is 1996 variable with elements other 1996 variable correlations
    # Only keep dissimilar variables
    if(econ_vars96[i] != econ_vars96[j]){
      # in the i-th element of the list, store its correlations with the j-th element
      econ_pairs96[[i]][[j]] <- cor(anes9296[, econ_vars96[i]], 
                                    anes9296[, econ_vars96[j]], 
                                    use = "complete.obs") 
    }
  }
}

### Moral
# loop over 1992 variables
for(i in 1:length(moral_vars92)){
  # loop over other 1992 variables
  moral_pairs92[i] <- NA
  for(j in 1:length(moral_vars92)){
    # store correlation so for object in list is 1992 variable with elements other 1992 variable correlations
    # Only keep dissimilar variables
    if(moral_vars92[i] != moral_vars92[j]){
      # in the i-th element of the list, store its correlations with the j-th element
      moral_pairs92[[i]][[j]] <- cor(anes9296[, moral_vars92[i]], 
                                    anes9296[, moral_vars92[j]], 
                                    use = "complete.obs") 
    }
  }
}

# loop over 1996 variables
for(i in 1:length(moral_vars96)){
  # loop over other 1996 variables
  moral_pairs96[i] <- NA
  for(j in 1:length(moral_vars96)){
    # store correlation so for object in list is 1996 variable with elements other 1996 variable correlations
    # Only keep dissimilar variables
    if(moral_vars96[i] != moral_vars96[j]){
      # in the i-th element of the list, store its correlations with the j-th element
      moral_pairs96[[i]][[j]] <- cor(anes9296[, moral_vars96[i]], 
                                    anes9296[, moral_vars96[j]], 
                                    use = "complete.obs") 
    }
  }
}

# calculate averages
avg_corrs_splithalfs <- data.frame(econ96_scale = mean(econ_half_corrs96),
                                   # some scale pairs are missing given correlating same items
                                   # need to include option to tell R to skip missing
                                   # unlist is a function telling R to turn the list into a simple vector
                                   econ96_pairs = mean(unlist(econ_pairs96), na.rm = T),
                                   moral96_scale = mean(moral_half_corrs96),
                                   moral96_piars = mean(unlist(moral_pairs96), na.rm = T),
                                   econ92_scale = mean(econ_half_corrs92),
                                   econ92_piars = mean(unlist(econ_pairs92), na.rm = T),
                                   moral92_scale = mean(moral_half_corrs92),
                                   moral92_piars = mean(unlist(moral_pairs92), na.rm = T))
# print
avg_corrs_splithalfs

# Figure 2 ----------------------------------------------------------------
# specify empty vectors for number of iterations we want to do for scales of size n
iters <- length(unlist(econ_pairs96)) # number of iterations as item pairs
scale_n1 <- unlist(econ_pairs96) # results constructed in prior section
scale_n2 <- rep(NA, iters)
scale_n3 <- rep(NA, iters)
scale_n4 <- rep(NA, iters)
scale_n5 <- rep(NA, iters)
scale_n6 <- rep(NA, iters)
scale_n7 <- rep(NA, iters)
scale_n8 <- rep(NA, iters)
scale_n9 <- rep(NA, iters)
scale_n10 <- rep(NA, iters)
scale_n11 <- rep(NA, iters)
scale_n12 <- rep(NA, iters)
scale_n13 <- rep(NA, iters)
scale_n14 <- rep(NA, iters)
scale_n15 <- rep(NA, iters)
scale_n16 <- rep(NA, iters)
scale_n17 <- rep(NA, iters)

# conduct k samples for each
# set seed for replication
set.seed(1693)
for(i in 1:iters){
  ## 2 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 4)
  # split in half at random to create scale 1
  indx1 <- sample(1:length(indx), length(indx)/2)
  # store second half of sampled items not used in first scale
  indx2 <- indx[-indx1]

  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n2[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 3 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 6)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n3[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 4 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 8)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n4[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 5 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 10)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n5[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 6 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 12)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n6[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 7 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 14)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n7[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 8 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 16)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n8[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 9 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 18)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n9[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 10 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 20)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n10[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 11 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 22)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n11[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 12 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 24)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n12[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 13 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 26)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n13[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 14 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 28)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n14[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 15 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 30)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n15[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 16 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 32)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n16[i] <- cor(split1, split2, use = "complete.obs")
  
  ## 17 item scales
  # sample total number of variables need from variables and store 
  indx <- sample(1:length(econ_vars96), 34)
  # split in half
  indx1 <- sample(1:length(indx), length(indx)/2)
  indx2 <- indx[-indx1]
  
  # estimate factor model and store scores for split 1
  split1 <- fa(anes9296[, econ_vars96[indx1]], fm = "ml")$scores
  # estimate factor model and store scores for split 2
  split2 <- fa(anes9296[, econ_vars96[indx2]], fm = "ml")$scores
  # estimate and store correlation
  scale_n17[i] <- cor(split1, split2, use = "complete.obs")
}

# combine the various sclaes into a data set to then plot
corrs <- data.frame(item1 = scale_n1,
                    item2 = scale_n2,
                    item3 = scale_n3,
                    item4 = scale_n4,
                    item5 = scale_n5,
                    item6 = scale_n6,
                    item7 = scale_n7,
                    item8 = scale_n8,
                    item9 = scale_n9,
                    item10 = scale_n10,
                    item11 = scale_n11,
                    item12 = scale_n12,
                    item13 = scale_n13,
                    item14 = scale_n14,
                    item15 = scale_n15,
                    item16 = scale_n16,
                    item17 = scale_n17)

# reshape the data set to plot from wide to long
corrs <- reshape::melt(corrs)

# plot the distribution of correlations "value" across scale size "variable" as pulled from the corrs data set
boxplot(value ~ variable, corrs)


# Table 4 -----------------------------------------------------------------
##### Education
# Compare loadings for low education and high education
# cbind pairs the elements in each vector into two columns
cbind(low = fEcon_educLow_92$loadings, fEcon_educHigh_92$loadings)
cbind(low = fMoral_educLow_92$loadings, fMoral_educHigh_92$loadings)

### Low Education
# Temporal Scale Correlations
cor(anes9296$econ_educLow_92, anes9296$econ_educLow_96, use = "complete.obs")
cor(anes9296$moral_educLow_92, anes9296$moral_educLow_96, use = "complete.obs")

## Calculate average temporal correlations (same as above, but we're doing this for subsets)
# empty vectors to store 
item_corrs_econ_lowEd <- rep(NA, length(econCom_vars92))
item_corrs_moral_lowEd <- rep(NA, length(moralCom_vars96))

# loop over items and store correlations
for(i in 1:length(econCom_vars92)){
  item_corrs_econ_lowEd[i] <- cor(subset(anes9296, educ_low_92 == 1, select = econCom_vars92[i]), 
                                  subset(anes9296, educ_low_92 == 1, select = econCom_vars96[i]), 
                            use = "complete.obs")
}
for(i in 1:length(moralCom_vars92)){
  item_corrs_moral_lowEd[i] <- cor(subset(anes9296, educ_low_92 == 1, select = moralCom_vars92[i]), 
                                   subset(anes9296, educ_low_92 == 1, select = moralCom_vars96[i]), 
                                   use = "complete.obs")
}
# create data frame with average correlations
avg_corrs_lowEd <- data.frame(econ = mean(item_corrs_econ_lowEd),
                              moral = mean(item_corrs_moral_lowEd))
# print
avg_corrs_lowEd

# PID and IDEO
cor(anes9296$pid7_92[which(anes9296$educ_low_92 == 1)], anes9296$pid7_96[which(anes9296$educ_low_92 == 1)], use = "complete.obs")
cor(anes9296$ideo7_92[which(anes9296$educ_low_92 == 1)], anes9296$ideo7_96[which(anes9296$educ_low_92 == 1)], use = "complete.obs")

### High Education
# Temporal Scale Correlations
cor(anes9296$econ_educHigh_92, anes9296$econ_educHigh_96, use = "complete.obs")
cor(anes9296$moral_educHigh_92, anes9296$moral_educHigh_96, use = "complete.obs")

## Calculate average temporal correlations
# empty vectors to store 
item_corrs_econ_hiEd <- rep(NA, length(econCom_vars92))
item_corrs_moral_hiEd <- rep(NA, length(moralCom_vars96))

# loop over items and store correlations
for(i in 1:length(econCom_vars92)){
  item_corrs_econ_hiEd[i] <- cor(subset(anes9296, educ_high_92 == 1, select = econCom_vars92[i]), 
                                  subset(anes9296, educ_high_92 == 1, select = econCom_vars96[i]), 
                                  use = "complete.obs")
}
for(i in 1:length(moralCom_vars92)){
  item_corrs_moral_hiEd[i] <- cor(subset(anes9296, educ_high_92 == 1, select = moralCom_vars92[i]), 
                                   subset(anes9296, educ_high_92 == 1, select = moralCom_vars96[i]), 
                                   use = "complete.obs")
}
# create data frame with average correlations
avg_corrs_hiEd <- data.frame(econ = mean(item_corrs_econ_hiEd),
                              moral = mean(item_corrs_moral_hiEd))
# print
avg_corrs_hiEd

# PID and IDEO
cor(anes9296$pid7_92[which(anes9296$educ_high_92 == 1)], anes9296$pid7_96[which(anes9296$educ_high_92 == 1)], use = "complete.obs")
cor(anes9296$ideo7_92[which(anes9296$educ_high_92 == 1)], anes9296$ideo7_96[which(anes9296$educ_high_92 == 1)], use = "complete.obs")


##### Political Knowledge
### Low
# Temporal Scale Correlations
cor(anes9296$econ_polKnowLow_92 , anes9296$econ_polKnowLow_96, use = "complete.obs")
cor(anes9296$moral_polKnowLow_92, anes9296$moral_polKnowLow_96, use = "complete.obs")

## Calculate average temporal correlations
# empty vectors to store 
item_corrs_econ_lowPK <- rep(NA, length(econCom_vars92))
item_corrs_moral_lowPK <- rep(NA, length(moralCom_vars96))

# loop over items and store correlations
for(i in 1:length(econCom_vars92)){
  item_corrs_econ_lowPK[i] <- cor(subset(anes9296, int_polknow_low == 1, select = econCom_vars92[i]), 
                                  subset(anes9296, int_polknow_low == 1, select = econCom_vars96[i]), 
                                  use = "complete.obs")
}
for(i in 1:length(moralCom_vars92)){
  item_corrs_moral_lowPK[i] <- cor(subset(anes9296, int_polknow_low == 1, select = moralCom_vars92[i]), 
                                   subset(anes9296, int_polknow_low == 1, select = moralCom_vars96[i]), 
                                   use = "complete.obs")
}
# create data frame with average correlations
avg_corrs_lowPK <- data.frame(econ = mean(item_corrs_econ_lowPK),
                              moral = mean(item_corrs_moral_lowPK))
# print
avg_corrs_lowPK

# PID and IDEO
cor(anes9296$pid7_92[which(anes9296$int_polknow_low == 1)], anes9296$pid7_96[which(anes9296$int_polknow_low == 1)], use = "complete.obs")
cor(anes9296$ideo7_92[which(anes9296$int_polknow_low == 1)], anes9296$ideo7_96[which(anes9296$int_polknow_low == 1)], use = "complete.obs")

### High
# Temporal Scale Correlations
cor(anes9296$econ_polKnowHigh_92 , anes9296$econ_polKnowHigh_96, use = "complete.obs")
cor(anes9296$moral_polKnowHigh_92, anes9296$moral_polKnowHigh_96, use = "complete.obs")

## Calculate average temporal correlations
# empty vectors to store 
item_corrs_econ_highPK <- rep(NA, length(econCom_vars92))
item_corrs_moral_highPK <- rep(NA, length(moralCom_vars96))

# loop over items and store correlations
for(i in 1:length(econCom_vars92)){
  item_corrs_econ_highPK[i] <- cor(subset(anes9296, int_polknow_hi == 1, select = econCom_vars92[i]), 
                                  subset(anes9296, int_polknow_hi == 1, select = econCom_vars96[i]), 
                                  use = "complete.obs")
}
for(i in 1:length(moralCom_vars92)){
  item_corrs_moral_highPK[i] <- cor(subset(anes9296, int_polknow_hi == 1, select = moralCom_vars92[i]), 
                                   subset(anes9296, int_polknow_hi == 1, select = moralCom_vars96[i]), 
                                   use = "complete.obs")
}
# create data frame with average correlations
avg_corrs_highPK <- data.frame(econ = mean(item_corrs_econ_highPK),
                              moral = mean(item_corrs_moral_highPK))
# print
avg_corrs_highPK

# PID and IDEO
cor(anes9296$pid7_92[which(anes9296$int_polknow_hi == 1)], anes9296$pid7_96[which(anes9296$int_polknow_hi == 1)], use = "complete.obs")
cor(anes9296$ideo7_92[which(anes9296$int_polknow_hi == 1)], anes9296$ideo7_96[which(anes9296$int_polknow_hi == 1)], use = "complete.obs")
