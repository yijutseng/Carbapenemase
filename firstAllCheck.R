library(readxl)
library(readr)
library(dplyr)
library(tidyverse)
CPO_BD_final_KP <- read_excel("20230307_CPO_BD_final.xlsx",sheet="KP")
CPO_BD_final_Other <- read_excel("20230307_CPO_BD_final.xlsx",sheet="other")
CPO_BD_final_KP_8<-CPO_BD_final_KP[,1:8]
CPO_BD_final<-rbind(CPO_BD_final_KP_8,CPO_BD_final_Other)
df.w = read_excel("20221116_CPO_WANG_KP.xlsx",sheet = "KP")
CombineData_comp_conv_1 <- read_csv("CombineData_comp_conv_1.csv")
CPO_BD_final$ID<-gsub("CPO-","",CPO_BD_final$Accession)
CombineData_comp_conv_1$ID <- as.character(CombineData_comp_conv_1$ID)
df.w$ID <- as.character(df.w$ID)
CombineData_comp_conv_1$FirstAll_mCIM_All<-
  str_sub(CombineData_comp_conv_1$mCIMeCIM,5,7)

## First all KP
CPO_BD_final %>% 
  filter(Organism=="Klebsiella pneumoniae" & ID %in% CombineData_comp_conv_1$ID) %>%
  group_by(mCIM) %>%
  summarise(Count=n()) #144 (1)
MatchFirstAll <- 
  inner_join(CPO_BD_final,CombineData_comp_conv_1,by="ID")
MatchFirstAll$MatchKP<- (MatchFirstAll$Organism=="Klebsiella pneumoniae") &
  (MatchFirstAll$mCIM==1) & (MatchFirstAll$FirstAll_mCIM_All=="(+)")
sum(MatchFirstAll$MatchKP) #144 match

## Conventional
df.w %>% 
  filter(ID %in% CombineData_comp_conv_1$ID) %>%
  group_by(mCIM) %>%
  summarise(Count=n()) #172 (1)
MatchConv <- 
  inner_join(df.w,CombineData_comp_conv_1,by="ID")
MatchConv$Match<-
  (MatchConv$mCIM=="+") & (MatchConv$Conventional_mCIM=="(+)")
sum(MatchConv$Match) #172 match

## First all - all
CPO_BD_final %>% 
  filter(ID %in% CombineData_comp_conv_1$ID) %>%
  group_by(mCIM) %>%
  summarise(Count=n()) #242 (1) first all
MatchFirstAll$Match<-
  (MatchFirstAll$mCIM==1) & (MatchFirstAll$FirstAll_mCIM_All=="(+)")
sum(MatchFirstAll$Match) #242 match first all match

## confusion
CombineData_comp_conv_1 %>%
  group_by(Conventional_mCIM,FirstAll_mCIM_All) %>%
  summarise(Count=n())

## save new csv
write_csv(CombineData_comp_conv_1,"CombineData_comp_conv_2.csv")
