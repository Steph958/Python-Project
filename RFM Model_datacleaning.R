
setwd('C:/Users/USER/Desktop/Github/R Project')
getwd()

#�ɮ׬�txt
df<-read.table(file="cdnow_master.txt", header=FALSE)
df
str(df)

#�ƥ����:
df_backup<-df
#df<-df_backup


#�D�X���n�ܼ�:
df<-df[,c(1,2,4)]
names(df)<-c("ID","Date","Amount")

str(df)
#�o�{�ثe����Oint����
df$Date<-as.Date(as.character(df$Date), format="%Y%m%d")
str(df)

dim(df)
#69659��������

UserID<-df[!duplicated(df$ID),]
dim(UserID)
#23570�ӥΤ�

df

#(df,file="RFM_table.csv",row.names=F)
#�ɮ׷|�g�J�P�@�Ӹ��|(�̪�}���ɮת��P�@�Ӹ�Ƨ�)

# �ϥ�Independent(�W�ߪk)�i��Bining(���c)
#����������ƫe�B�z:

startDate<-as.Date("19970101","%Y%m%d")
endDate<-as.Date("19980101","%Y%m%d")

# group by�p��R,F,M��:

library(dplyr)
library(magrittr)

new_df <- 
    df %>% 
    filter(Date >= startDate & Date <= endDate) %>% 
    group_by(ID) %>% 
    summarise(
        MaxTransDate = max(Date),
        Amount = sum(Amount),
        Recency = as.numeric(endDate - MaxTransDate),
        Frequency = n(),
        Monetary = Amount/Frequency
    ) %>% 
    ungroup() %>% 
    as.data.frame()

head(new_df,10)
tail(new_df,10)

write.csv(new_df,"RFM_Table.csv",row.names=F)
