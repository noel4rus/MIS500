dbConnect(RPostgres::Postgres(),dbname='MIS500',
host='localhost',
port=5432,
user='postgres',
password='Safe4Now')

query_res <- dbGetQuery(con, qry)
my_df <- as.data.frame(query_res)

typeof(my_df)
summary(my_df)

union_df1<-my_df[which(my_df$union_wrk==1),]
head(union_df1)

union_df1<-my_df[which(my_df$union_wrk==1),-3]
head(union_df1)

my_data <-data.frame(
   group<=rep(c("uion","non-union"), 
   ins_coverage=c(union_df1$ins_coverage,non_union$ins_coverage)
)

res<-ttest(ins_converage ~ group, data=my_data, var.equal=true)

u1<-nrow(union_df1[union_df1$ins_coverage==1 & union_df1$year=="2013",])
u2<-nrow(union_df1[union_df1$ins_coverage==0 & union_df1$year=="2013",])
u3<-nrow(union_df1[union_df1$ins_coverage==1 & union_df1$year=="2008",])
u4<-nrow(union_df1[union_df1$ins_coverage==0 & union_df1$year=="2008",])
u5<-nrow(union_df1[union_df1$ins_coverage==1 & union_df1$year=="2001",])
u6<-nrow(union_df1[union_df1$ins_coverage==0 & union_df1$year=="2001",])
nu1<-nrow(non_union_df1[non_union_df1$ins_coverage==1 & non_union_df1$year=="2013",])
nu2<-nrow(non_union_df1[non_union_df1$ins_coverage==0 & non_union_df1$year=="2013",])
nu3<-nrow(non_union_df1[non_union_df1$ins_coverage==1 & non_union_df1$year=="2005",])
nu4<-nrow(non_union_df1[non_union_df1$ins_coverage==0 & non_union_df1$year=="2005",])
nu5<-nrow(non_union_df1[non_union_df1$ins_coverage==1 & non_union_df1$year=="2001",])
nu6<-nrow(non_union_df1[non_union_df1$ins_coverage==0 & non_union_df1$year=="2001",])
Values=matrix(c(u5,u6,u3,u4,u1,u2,nu5,nu6,nu3,nu4,nu1,nu2),nrow=2,ncol=3)

barplot(Values,main="Insurance Coverage Years 2001,2008,2013",names.arg=c("2001 Union","2001 Non-Union","2008 Union","2008 Non-Union","2013 Union","2013 Non-Union"),ylab="Number Employees",col=c("Green","Red"),font.lab=1,cex.names=0.8,las=2,cex.axis=0.8)
legend("topright",c("With","Without"),lty=1:1,cex=0.8,lwd=c(1.0,1.0),col=c("green","red"),text.font = 1)