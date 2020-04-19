options(max.print=999999)
library(epanetReader)
library(stringr)
library(gtools)
library(plyr)
library(dplyr)
# Read
Case_Observations = read.table("Final_Case.csv",sep = ",", fill = TRUE , header = TRUE)
#Select Only Males and Females from the list
Case_Observations = Case_Observations[((Case_Observations$Gender == "Male") |(Case_Observations$Gender == "Female")),]
# Remove Race which are not specified and Have Nulls
Case_Observations = Case_Observations[!((Case_Observations$Race == "Unknown")|(Case_Observations$Race == "NULL")|(Case_Observations$Race == "Null")
                                     |(Case_Observations$Race == "Not Mapped")),]

#Drop Levels From Output
Case_Observations = droplevels(Case_Observations)
# Case is the data which are diagnosed with Diabetes. Hence we add a column Diabetes_Active 1
Case_Observations['Diabetes_Active'] = 1
# Write to CSV Cleaned DF
write.csv(Case_Observations, file = "Final_Case_Cleaned.csv", row.names = FALSE)

#Read
Control_Observations = read.table("Final_Control.csv",sep = ",", fill = TRUE , header = TRUE)
#Select Only Males and Females from the list
Control_Observations = Control_Observations[((Control_Observations$Gender == "Male") |(Control_Observations$Gender == "Female")),]
# Remove Race which are not specified and Have Nulls
Control_Observations = Control_Observations[!((Control_Observations$Race == "Unknown")|(Control_Observations$Race == "NULL")|(Control_Observations$Race == "Null")|
                                                (Control_Observations$Race == "Not Mapped")),]
#Remove Age having NA's
Control_Observations = Control_Observations[!(Control_Observations$Age == 'NA'),]
#Drop Levels from output
Control_Observations = droplevels(Control_Observations)
# Control is the data which are not diagnosed with Diabetes. Hence we add a column Diabetes_Active 0
Control_Observations['Diabetes_Active'] = 0
# Write to CSV Cleaned DF
write.csv(Control_Observations, file = "Final_Control_Cleaned.csv", row.names = FALSE)

unique(Control_Observations$Age)
unique(Case_Observations$Age)

#plot(Case_Observations$Gender)
#Plot for Gender
barplot(table(Case_Observations$Gender))
barplot(table(Control_Observations$Gender))
#Plot for Race
barplot(table(Case_Observations$Race))
barplot(table(Control_Observations$Race))

#Summary Descriptive Statistics for variables
summary(Case_Observations)
summary(Control_Observations)

pca_Case = Case_Observations[,sapply(Case_Observations,is.numeric)]
pca_Control = Control_Observations[,sapply(Control_Observations,is.numeric)]

pca_Case=na.replace(pca_Case,0)
pca_Control=na.replace(pca_Control,0)

#Correlation
cor(pca_Case)
cor(pca_Control)

#PCA
Case_PCA = princomp(pca_Case,cor=TRUE,scale = TRUE)		#save PCA model with loadings
Case_PCA$sdev^2 
plot(Case_PCA, main="Screeplot")
  str(pca_Case)
  
Control_PCA = princomp(pca_Control,cor=TRUE,scale = TRUE)		#save PCA model with loadings
Control_PCA$sdev^2 
plot(Control_PCA, main="Screeplot")
  str(pca_Case)
  




