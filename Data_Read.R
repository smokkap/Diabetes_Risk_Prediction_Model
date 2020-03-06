library(epanetReader)
workingdirectory = "C:\\Users\\sridh\\Desktop\\Spring 2020\\Data_Science_Programming_II\\Project\\MSIS5223_Project"
setwd(workingdirectory)
rpt <- file.path( find.package("epanetReader"), "extdata","../case/cevnt.rpt") 
n1r <- read.rpt(rpt)
