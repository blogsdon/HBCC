require(synapseClient)
library(dplyr)
library(utilityFunctions)
library(bit64)
synapseLogin()

covariatesObj <- synGet('syn5570075')
residualExpressionObj <- synGet('syn5570061')

library(data.table)

hbccCovariates <- fread(covariatesObj@filePath,data.table=F,stringsAsFactors=F)
hbccExpression <- fread(residualExpressionObj@filePath,data.table=F,stringsAsFactors=F)

hbccExpression2 <- t(hbccExpression[,-c(1)])
colnames(hbccExpression2) <- hbccExpression$GeneFeature
#hbccCovariates <- hbccCovariates[,-136]

#Bipolar
#BipolarCov <- dplyr::filter(hbccCovariates,Dx=='AFF')

hbccExpression2[dplyr::filter(hbccCovariates,Dx=='BP')$Subject_ID,] %>%
  apply(2,utilityFunctions::winsorize) %>%
  scale %>%
  write.csv(file='hbccBipolarRNAseq.csv',quote=F)

#MCI
hbccExpression2[dplyr::filter(hbccCovariates,Dx=='SCZ')$`Subject_ID`,] %>%
  apply(2,utilityFunctions::winsorize) %>%
  scale %>%
  write.csv(file='hbccSchizophreniaRNAseq.csv',quote=F)

#AD
hbccExpression2[dplyr::filter(hbccCovariates,Dx=='Control')$`Subject_ID`,] %>%
  apply(2,utilityFunctions::winsorize) %>%
  scale %>%
  write.csv(file='hbccControlRNAseq.csv',quote=F)

hbccExpression2[dplyr::filter(hbccCovariates,Dx=='MDD')$`Subject_ID`,] %>%
  apply(2,utilityFunctions::winsorize) %>%
  scale %>%
  write.csv(file='hbccMDDRNAseq.csv',quote=F)

hbccExpression2 <- apply(hbccExpression2,2,utilityFunctions::winsorize)
hbccExpression2 <- scale(hbccExpression2)

write.csv(hbccExpression2,file='hbccRNAseq.csv',quote=F)