rm(list = ls())
dev.off()
########################################
#lib
########################################
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyverse)
library(readxl)
library(caret)
library(googlesheets4)
########################################
#load data
########################################
df.bd = read_excel("20221115_CPO_BD_KP.xlsx",sheet = "Raw")[,1:10]
df.w = read_excel("20221116_CPO_WANG_KP.xlsx",sheet = "KP")
########################################
#pre-processing
########################################
df.bd$ID = df.bd$ID %>% 
  str_sub(start = 5,end = 12)

df.bd = df.bd %>% 
  filter(BAC %in% c("Klebsiella pneumoniae"))

df.w$ID=df.w$ID %>% as.character()
########################################
#merge
########################################
df.merge = left_join(df.bd,df.w,by = "ID")
df.merge$mCIM.y = df.merge$mCIM.y %>% 
  str_replace(pattern = "\\+", 
              replacement = "1") %>% 
  str_replace( pattern = "\\-", 
              replacement = "0")
########################################
#stats
########################################
mat=cbind(df.merge$mCIM.x,df.merge$mCIM.y) %>% as.data.frame()
colnames(mat) = c("mCIM.Old","mCIM.New")
mat=mat %>% 
  filter(mCIM.Old %in% c(0,1)) %>% 
  filter(mCIM.New %in% c(0,1))
#
mCIM.comp=table(mat$mCIM.Old,mat$mCIM.New) %>% print()
# write.csv(mCIM.comp,"mCIM.comp_KP.csv",row.names = TRUE)
