options(max.print=999999)
library(epanetReader)
library(stringr)
library(gtools)
library(plyr); library(dplyr)
workingdirectory = "C:\\Users\\sridh\\Desktop\\Spring 2020\\Data_Science_Programming_II\\Project\\MSIS5223_Project"
setwd(workingdirectory)
case_cevnt = read.table("..\\case\\cevnt.rpt",sep = "\t", fill = TRUE , header = TRUE,nrows=2000000)
case_cevnt = read.table("..\\case\\cevnt.rpt",sep = "\t", fill = TRUE , header = TRUE)
case_diag =  read.table("..\\case\\diag.rpt" ,sep = "\t", fill = TRUE , header = TRUE,nrows=200)
case_diag =  read.table("..\\case\\diag.rpt" ,sep = "\t", fill = TRUE , header = TRUE)
case_enct =  read.table("..\\case\\enct.rpt" ,sep = "\t", fill = TRUE , header = TRUE,nrows=200)
case_enct =  read.table("..\\case\\enct.rpt" ,sep = "\t", fill = TRUE , header = TRUE)
case_diag = case_diag[,c("ï..ENCOUNTER_ID" , "DIAGNOSIS_DESCRIPTION")]
case_lab =   read.table("..\\case\\lab.rpt"  ,sep = "\t", fill = TRUE , header = TRUE,nrows=200000)
case_lab =   read.table("..\\case\\lab.rpt"  ,sep = "\t", fill = TRUE , header = TRUE)
case_med =   read.table("..\\case\\med.rpt"  ,sep = "\t", fill = TRUE , header = TRUE,nrows=200000)
case_med =   read.table("..\\case\\med.rpt"  ,sep = "\t", fill = TRUE , header = TRUE)
case_proc =  read.table("..\\case\\proc.rpt" ,sep = "\t", fill = TRUE , header = TRUE,nrows=200000)
case_proc =  read.table("..\\case\\proc.rpt" ,sep = "\t", fill = TRUE , header = TRUE)

#Merged_Df = merge(case_enct, case_diag, by.x="ï..ENCOUNTER_ID", by.y="ï..ENCOUNTER_ID", all.x = FALSE, all.y = FALSE)

Merged_Df = join(case_enct, case_diag, by = c("ï..ENCOUNTER_ID" = "ï..ENCOUNTER_ID"),type= "left")
Merged_Df_diab = Merged_Df[grepl("diabetes ",Merged_Df$DIAGNOSIS_DESCRIPTION, ignore.case = TRUE),]


nrow(Merged_Df) - nrow(case_diag_desc_diab)
head(Merged_Df_diab)
names(case_diag)
head(case_enct)
names(Merged_Df_diab)


x = na.replace(Merged_Df_diab,'0')

Merged_Df_diab = Merged_Df_diab[,c("ï..ENCOUNTER_ID" ,
                                      "PATIENT_ID",
                                      "PATIENT_SK" ,"RACE" ,"GENDER"  ,"MDC_CODE"         ,            
                                      "ADMISSION_SOURCE_ID"   ,    
                                      "ADMISSION_TYPE_ID"     ,   "AGE_IN_YEARS"  ,    "WEIGHT" ,"DIAGNOSIS_ID")]
Merged_Df_diab$ï..ENCOUNTER_ID = as.numeric(Merged_Df_diab$ï..ENCOUNTER_ID)
Merged_Df_diab$PATIENT_ID = as.numeric(Merged_Df_diab$PATIENT_ID)
Merged_Df_diab$AGE_IN_YEARS = as.numeric(Merged_Df_diab$AGE_IN_YEARS)
Merged_Df_diab$WEIGHT = as.numeric(Merged_Df_diab$WEIGHT)
Merged_Df_diab$RACE = as.numeric(Merged_Df_diab$RACE)
Merged_Df_diab$PATIENT_SK = as.numeric(Merged_Df_diab$PATIENT_SK)
Merged_Df_diab$GENDER = as.numeric(Merged_Df_diab$GENDER)
Merged_Df_diab=na.replace(Merged_Df_diab,'0')

#PCA
pcamodel_reduc = princomp(Merged_Df_diab,cor=TRUE)		#save PCA model with loadings
pcamodel_reduc$sdev^2 
plot(pcamodel_reduc, main="Screeplot")
str(Merged_Df_diab)

#FA

reduction_data.FA = factanal(~ï..ENCOUNTER_ID+PATIENT_ID+AGE_IN_YEARS+WEIGHT+RACE+PATIENT_SK+
                               GENDER+ DIAGNOSIS_ID + ADMISSION_TYPE_ID + ADMISSION_SOURCE_ID,
                             factors=6,
                             rotation="varimax",
                             scores="none",
                             data=Merged_Df_diab)

reduction_data.FA




