# ggplot2 average plot

library(ggplot2)
library(reshape2)
library(dplyr)

# read in write out
#df2 <- read.csv(file = "/home/cathal_king/Desktop/test2avplot.csv", header = TRUE)
#write.table(df, file = "/home/cathal_king/Desktop/CycLoess-normalized_ECM_comma.csv", row.names = FALSE, sep = ',', quote = FALSE)

genes = readLines("/home/cathal_king/Downloads/HK_genes_only.txt")
#df<-read.table("/home/cathal_king/Documents/testplotly.csv", header = T)
#df<-read.csv("/home/cathal_king/Desktop/test2avplot.csv", header = T)
# df<-read.csv("/home/cathal_king/Downloads/avrg go and gr for_profile plot.csv", header = T)

# raw averaged data
# df8 <- read.table("/home/cathal_king/Downloads/submitted_rawdata averaged.txt", header = T)


df <- read.csv("/home/cathal_king/Desktop/avrgGoandGrforProfilePlot2.csv", header = T)


#Define new variable housekeeping
#define every row as non house keeping
df$HK<-"Nonhk"

#annotate house keeping genes ad housekeeping
df$HK[df$GENE %in% genes]<-"hk"

##arrange housekeeping genes to the bootom
df<-arrange(df,desc(HK))

df_m<-melt(df)

#ggplot(df_m, aes(x=variable, y=value)) + 
#  geom_line(aes(group=GENE,color=ifelse(GENE %in% genes , "HK", "NHK"))) + 
#  theme_bw()+theme(axis.text.x=element_text(angle=90, vjust = 0.5)) + 
#  labs(x="Sample", y="Expression", color="Gene Type", title="Average plot", caption = "average plot") + 
#  scale_color_manual(values=c("red", "grey")) + facet_wrap(~HK)

df%>%group_by(HK)%>%summarise(n())

df1<-filter(df,HK=="Nonhk")
df2<-filter(df,HK=="hk")
#melt split dataframes
df1_m<-melt(df1)
df2_m<-melt(df2)
ggplot(df1_m, aes(x=variable, y=value, color="grey"))+
  geom_line(aes(group=GENE)) + 
  geom_line(data =df2_m, aes(x=variable, y=value,group=GENE, color="red"))+theme_bw()+
  labs(title = "Average Plot - loess", color="Genetype") + 
  theme(axis.text.x=element_text(angle=90, vjust = 0.5, size = 5.8)) +
  scale_color_manual(values = c("grey", "red"), labels = c("NonHK", "HK"))
