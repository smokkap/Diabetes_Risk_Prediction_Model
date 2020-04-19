#install.packages("epanetReader")
library(dplyr)
library(plyr)
library(NLP)

setwd("C:\\Users\\sridh\\Desktop\\Spring 2020\\Data_Science_Programming_II\\Project\\MSIS5223_Project")


control_enct = read.table("..\\control\\Encounter_Patient.csv",sep = ",", fill = TRUE ,
                       header = TRUE)[,c("ï..ENCOUNTER_ID","PATIENT_ID","PATIENT_SK","RACE","GENDER","AGE_IN_YEARS","AGE_IN_MONTHS","AGE_IN_WEEKS",
                                         "AGE_IN_DAYS","WEIGHT","ADMITTED_DT_TM","ADMITTED_TM_VALID_IND")]


control_cevnt = read.table("..\\control\\Clinical_Events.csv",sep = ",", fill = TRUE ,
                        header = TRUE)[,c("ï..ENCOUNTER_ID","EVENT_CODE_DESC","EVENT_CODE_GROUP","PERFORMED_DT_TM","RESULT_NORMALCY_FLG","RESULT_VALUE_NUM",
                                          "result_units_disp","result_units_desc","RESULT_VALUE_DT_TM")]


control_diag =  read.table("..\\control\\Diagnosis.csv" ,sep = ",", fill = TRUE ,
                        header = TRUE)[,c("ï..ENCOUNTER_ID","DIAGNOSIS_DESCRIPTION","DIAGNOSIS_TYPE_DISPLAY" )]


control_lab =   read.table("..\\control\\Lab.csv"  ,sep = ",", fill = TRUE ,
                        header = TRUE)[,c("ï..ENCOUNTER_ID","LAB_PROCEDURE_GROUP" ,"RESULT_INDICATOR_ID","RESULT_INDICATOR_DESC",
                                          "NUMERIC_RESULT","UNIT_DISPLAY","UNIT_DESC","NORMAL_RANGE_LOW","NORMAL_RANGE_HIGH","LAB_PERFORMED_DT_TM")]


#control_med =   read.table("..\\control\\Medical.csv"  ,sep = ",", fill = TRUE , header = TRUE)
#control_proc =  read.table("..\\control\\Procedural.csv" ,sep = ",", fill = TRUE , header = TRUE)

list_groups_cevnt= c("Blood Pressure","BMI BSA","Alcohol","Smoke/Tobacco","Heart Rate")
control_cevnt = control_cevnt[control_cevnt$`EVENT_CODE_GROUP` %in% list_groups_cevnt,]
#unique(control_cevnt$EVENT_CODE_GROUP)
list_groups_lab= c("Cholesterol Test","Glucose Test")
control_lab = control_lab[control_lab$LAB_PROCEDURE_GROUP %in% list_groups_lab,]



#x = ddply(control_enct,.(PATIENT_SK),nrow)  # encounter per each patient
x =NULL
enct_lab = data.frame()
enct_cenvt =data.frame()
Cholestrol = data.frame()
Glucose = data.frame()
Cholesterol =data.frame()
Final_Data_Frame_Control =data.frame()
encounters_patient = data.frame()
control_enct$AGE_IN_YEARS = as.numeric(as.character(control_enct$AGE_IN_YEARS))
i=NULL
sk= as.character(unique(control_enct$PATIENT_SK))
for (i in sk){
  temp_Data_Frame=data.frame()
  #i=112902884
  Patient_SK = i
  Alcohol_Habit = NULL
  Blood_Pressure =NULL
  BMI_BSA = NULL
  Cholestral_Mean = NULL
  Cholesterol =NULL
  Diabetes =NULL
  Race=NULL
  Race=as.vector(tail(control_enct[control_enct$PATIENT_SK == i,]$RACE,1))
  Patient_ID =NULL
  Patient_ID=as.character(unique(control_enct[control_enct$PATIENT_SK == i,]$PATIENT_ID))
  Age =NULL
  Age=max(control_enct[control_enct$PATIENT_SK == i,]$AGE_IN_YEARS)
  Gender =NULL
  Gender = as.vector(tail(control_enct[control_enct$PATIENT_SK == i,]$GENDER,1))
  Diastolic_Mean =NULL
  Systolic_Mean =NULL
  Glucose_Mean = NULL
  Heart_Rate = NULL
  Smoke_Habit =NULL
  
  print(i)
  encounters_patient = control_enct[control_enct$PATIENT_SK == i,]
  
  enct_cenvt = join(encounters_patient, control_cevnt, by = c("ï..ENCOUNTER_ID" = "ï..ENCOUNTER_ID"),type= "inner")
  write.csv(enct_cenvt, file = "..\\control\\enct_cenvt_merged.csv", row.names = FALSE)
  enct_lab = join(encounters_patient, control_lab, by = c("ï..ENCOUNTER_ID" = "ï..ENCOUNTER_ID"),type= "inner")
  
  
  #unique(enct_cenvt$EVENT_CODE_GROUP)
  
  enct_cenvt$RESULT_VALUE_NUM = as.numeric(as.character(enct_cenvt$RESULT_VALUE_NUM))
  
  Diastolic_Mean = mean(na.omit(enct_cenvt[enct_cenvt$EVENT_CODE_DESC == "Blood Pressure Diastolic",])$RESULT_VALUE_NUM)
  Systolic_Mean = mean(na.omit(enct_cenvt[enct_cenvt$EVENT_CODE_DESC == "Blood Pressure Systolic",])$RESULT_VALUE_NUM)
  #Diastolic_Mean = 90
  #Systolic_Mean = 140
  if(!is.na(Systolic_Mean) && !(is.na(Diastolic_Mean))){
    if(Diastolic_Mean < 81 && (Systolic_Mean < 121)){
      Blood_Pressure = 0
    }else if( Diastolic_Mean <81 && (Systolic_Mean > 120 && Systolic_Mean < 130)){
      Blood_Pressure = 1
    }else if( (Diastolic_Mean >81 && Diastolic_Mean <90 ) || (Systolic_Mean > 130 && Systolic_Mean < 139)){
      Blood_Pressure = 2
    }else{
      Blood_Pressure=3
    }
  }else{
    Blood_Pressure= 4
  }
  Heart_Rate = mean(na.omit(enct_cenvt[enct_cenvt$EVENT_CODE_GROUP == "Heart Rate",])$RESULT_VALUE_NUM)
  BMI_BSA = mean(na.omit(enct_cenvt[enct_cenvt$EVENT_CODE_GROUP == "BMI BSA",])$RESULT_VALUE_NUM)
  Smoke_Habit = ifelse(nrow(enct_cenvt[enct_cenvt$EVENT_CODE_GROUP == "Smoke/Tobacco",])>0, 1, 0)
  Alcohol_Habit = ifelse(nrow(enct_cenvt[enct_cenvt$EVENT_CODE_GROUP == "Alcohol",])>0, 1, 0)
  
  enct_lab$NUMERIC_RESULT = as.numeric(as.character(enct_lab$NUMERIC_RESULT))
  Glucose = na.omit(enct_lab[enct_lab$LAB_PROCEDURE_GROUP == "Glucose Test",])
  Glucose_Mean = mean(na.omit(Glucose[Glucose$UNIT_DISPLAY == "mg/dL",])$NUMERIC_RESULT)
  #str(enct_lab)
  if(!is.na(Glucose_Mean)){
    if(Glucose_Mean < 110){
      Diabetes = 0
    }else if( Glucose_Mean > 110){
      Diabetes = 1
    }else{
      Diabetes = 2
    }
  }else{
    Diabetes = 2
  }
  Cholestrol = na.omit(enct_lab[enct_lab$LAB_PROCEDURE_GROUP == "Cholesterol Test",])
  Cholestral_Mean = mean(na.omit(Cholestrol[Cholestrol$UNIT_DISPLAY == "mg/dL",])$NUMERIC_RESULT)
  #str(enct_lab)
  
  if(!is.na(Cholestral_Mean)){
    if(Cholestral_Mean < 200){
      Cholesterol = 0
    }else if( Cholestral_Mean > 200){
      Cholesterol = 1
    }else{
      Cholesterol = 2
    }
  }else{
    Cholesterol = 2
  }
  
  temp_Data_Frame= data.frame(Patient_ID,Patient_SK,Race,Gender,Age,Alcohol_Habit,Blood_Pressure,BMI_BSA,Cholesterol,Cholestral_Mean,Diabetes,Glucose_Mean,Diastolic_Mean,Systolic_Mean,Heart_Rate,Smoke_Habit)
  Final_Data_Frame_Control = rbind(temp_Data_Frame,Final_Data_Frame_Control)
  #break
}
write.csv(Final_Data_Frame_Control, file = "Final_Control.csv", row.names = FALSE)



