##CSV1
fileUrl= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/amm_comm_survey.csv", method = "curl")
list.files("./data/")

library(readr)
amm_comm_survey <- read_csv("data/amm_comm_survey.csv")
str(amm_comm_survey)
amm_comm_survey[amm_comm_survey$VAL==24, ]
subset(amm_comm_survey, VAL == "24")
unique(amm_comm_survey[c("FES")]) 

##XLSX
fileUrl= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/nat_gas.xlsx", method = "curl")
list.files("./data/")

install.packages("xlsx")
library(xlsx)
col_Index <- 7:15
row_Index <- 18:23
dat_xlsx<-read.xlsx("./data/nat_gas.xlsx",sheetIndex=1,colIndex=col_Index,rowIndex=row_Index)
sum(dat_xlsx$Zip*dat_xlsx$Ext,na.rm=T)

##XML
fileUrl= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/balt_rest.xml", method = "curl")
list.files("./data/")

install.packages("XML")
library(XML)
xml_path<-"./data/balt_rest.xml"
xml_dat<-xmlTreeParse(xml_path,useInternal=TRUE)
rootNode<-xmlRoot(xml_dat)
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]][[1]]

a<-xpathSApply(rootNode,"//zipcode",xmlValue)
head(a)
length(a[grepl("^21231", a)])

##CSV2
fileUrl= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/amm_comm_survey.csv", method = "curl")
list.files("./data/")

install.packages("data.table")
library(data.table)
DT <- fread("data/amm_comm_survey.csv", sep=",")
head(DT)

## user system elapsed
system.time(DT[,mean(wgtp15),by=SEX])
## ?
system.time(mean(DT$wgtp15,by=DT$SEX))
## 0.000   0.000   0.001
system.time(mean(DT[DT$SEX==1,]$wgtp15))
system.time(mean(DT[DT$SEX==2,]$wgtp15))
## 0.020   0.018   0.038  
## 0.004   0.001   0.005 
system.time(tapply(DT$wgtp15,DT$SEX,mean))
## 
system.time(rowMeans(DT)[DT$SEX==1]) 
system.time(rowMeans(DT)[DT$SEX==2])
## 
system.time(sapply(split(DT$wgtp15,DT$SEX),mean))
## 
