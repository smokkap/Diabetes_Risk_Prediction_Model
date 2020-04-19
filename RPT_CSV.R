
setwd("C:\\Users\\sridh\\Desktop\\Spring 2020\\Data_Science_Programming_II\\Project\\MSIS5223_Project")

case_enct = read.table("..\\case\\enct.rpt",sep = "\t", fill = TRUE , header = TRUE)
case_cevnt = read.table("..\\case\\cevnt.rpt",sep = "\t", fill = TRUE , header = TRUE)
case_diag =  read.table("..\\case\\diag.rpt" ,sep = "\t", fill = TRUE , header = TRUE)
case_lab =   read.table("..\\case\\lab.rpt"  ,sep = "\t", fill = TRUE , header = TRUE)
case_med =   read.table("..\\case\\med.rpt"  ,sep = "\t", fill = TRUE , header = TRUE)
case_proc =  read.table("..\\case\\proc.rpt" ,sep = "\t", fill = TRUE , header = TRUE)


write.csv(case_enct, file = "..\\case\\Encounter_Patient.csv", row.names = FALSE)
write.csv(case_cevnt, file = "..\\case\\Clinical_Events.csv", row.names = FALSE)
write.csv(case_diag, file = "..\\case\\Diagnosis.csv", row.names = FALSE)
write.csv(case_lab, file = "..\\case\\Lab.csv", row.names = FALSE)
write.csv(case_med, file = "..\\case\\Medical.csv", row.names = FALSE)
write.csv(case_proc, file = "..\\case\\Procedural.csv", row.names = FALSE)




control_cevnt = read.table("..\\control\\cevnt.rpt",sep = "\t", fill = TRUE , header = TRUE)
control_enct = read.table("..\\control\\enct.rpt",sep = "\t", fill = TRUE , header = TRUE)
control_diag = read.table("..\\control\\diag.rpt",sep = "\t", fill = TRUE , header = TRUE)
control_lab = read.table("..\\control\\lab.rpt",sep = "\t", fill = TRUE , header = TRUE)
control_med = read.table("..\\control\\med.rpt",sep = "\t", fill = TRUE , header = TRUE)
control_proc = read.table("..\\control\\proc.rpt",sep = "\t", fill = TRUE , header = TRUE)

write.csv(control_enct, file = "..\\control\\Encounter_Patient.csv", row.names = FALSE)
write.csv(control_cevnt, file = "..\\control\\Clinical_Events.csv", row.names = FALSE)
write.csv(control_diag, file = "..\\control\\Diagnosis.csv", row.names = FALSE)
write.csv(control_lab, file = "..\\control\\Lab.csv", row.names = FALSE)
write.csv(control_med, file = "..\\control\\Medical.csv", row.names = FALSE)
write.csv(control_proc, file = "..\\control\\Procedural.csv", row.names = FALSE)