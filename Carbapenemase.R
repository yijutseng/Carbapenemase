### Confusion matrix preprocess
CleanCM<-function(oriData){
  FinalCM<-NULL
  tbl1<-data.frame(ID=oriData$...1,
                   MPCR=oriData$MPCR...2,
                   CARBA5=oriData$`CARBA 5...3`,
                   GENE=oriData$GENE...4,
                   SPECIES=oriData$SPECIES...5)
  tbl2<-data.frame(ID=oriData$...7,
                   MPCR=oriData$MPCR...8,
                   CARBA5=oriData$`CARBA 5...9`,
                   GENE=oriData$GENE...10,
                   SPECIES=oriData$SPECIES...11)
  tbl3<-data.frame(ID=oriData$...13,
                   MPCR=oriData$MPCR...14,
                   CARBA5=oriData$`CARBA 5...15`,
                   GENE=oriData$GENE...16,
                   SPECIES=oriData$SPECIES...17)
  tbl4<-data.frame(ID=oriData$...19,
                   MPCR=oriData$MPCR...20,
                   CARBA5=oriData$`CARBA 5...21`,
                   GENE=oriData$GENE...22,
                   SPECIES=oriData$SPECIES...23)
  tbl5<-data.frame(ID=oriData$...25,
                   MPCR=oriData$MPCR...26,
                   CARBA5=oriData$`CARBA 5...27`,
                   GENE=oriData$GENE...28,
                   SPECIES=oriData$SPECIES...29)
  FinalCM<-rbind(tbl1,tbl2,tbl3,tbl4,tbl5)
  return(FinalCM)
}

library(readxl)
KP_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                 sheet = "KP", skip = 1)
EC_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                     sheet = "EC", skip = 2)
ECc_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                     sheet = "Enterobacter cloacae complex", skip = 2)
CFc_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                     sheet = "Citrobacter freundii complex", skip = 2)
CK_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                     sheet = "Citrobacter koseri", skip = 2)
KA_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                     sheet = "Klebsiella aerogenes", skip = 2)
KO_ori <- read_excel("CONFUSION MATRIX TABLE.xlsx", 
                     sheet = "Klebsiella oxytoca", skip = 2)
FinalCM<-
  rbind(
  CleanCM(KP_ori),
  CleanCM(EC_ori),
  CleanCM(ECc_ori),
  CleanCM(CFc_ori),
  CleanCM(CK_ori),
  CleanCM(KA_ori),
  CleanCM(KO_ori)
)
FinalCM$ID<-as.character(FinalCM$ID)

