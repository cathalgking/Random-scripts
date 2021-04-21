

genes = readLines("/home/cathal_king/Downloads/hk.txt")
# dataset
df <- read.csv("/home/cathal_king/Downloads/full.csv", header = T)
#
df$HK<-"Nonhk"
#annotate house keeping genes ad housekeeping
df$HK[df$GENE %in% genes]<-"hk"

##arrange housekeeping genes to the bootom
df<-arrange(df,desc(HK))

df_m<-melt(df)


df%>%group_by(HK)%>%summarise(n())

df1<-filter(df,HK=="Nonhk")
df2<-filter(df,HK=="hk")
#melt split dataframes
df1_m<-melt(df1)
#Check for missing values and omit missing values
df1_m[!complete.cases(df1_m),]
dff1<-na.omit(df1_m)
#Meltdf2
df2_m<-melt(df2)
#Check for missing values and omit missing values
df2_m[!complete.cases(df2_m),]
dff2<-na.omit(df2_m)
ggplot(dff1, aes(x=variable, y=value, color="grey"))+
  geom_line(aes(group=GENE)) + 
  geom_line(data =dff2, aes(x=variable, y=value,group=GENE, color="red"))+theme_bw()+
  labs(title = "Average Plot - loess", color="Genetype") + 
  theme(axis.text.x=element_text(angle=90, vjust = 0.5, size = 5.8)) +
  scale_color_manual(values = c("grey", "red"), labels = c("NonHK", "HK"))




#Convert tissue to number
dff1$var2<-dff1$variable
dff1$var2<-as.numeric(dff1$var2)
#Stackoverflow code
dens<-MASS::kde2d(dff1$var2, dff1$value, n = 200)
dens_df <- data.frame(with(dens, expand_grid( y, x)), z = as.vector(dens$z))
fit <- loess(z ~ y * x, data = dens_df, span = 0.02)
dff1$z <- predict(fit, with(dff1, data.frame(x=var2, y=value)))


nonh.k<-ggplot(dff1, aes(variable, value, group = GENE, color = z)) +
  geom_line(size = 0.05) +
  theme_minimal() +
  scale_color_gradientn(colors = c("blue", "yellow", "red"))+theme_bw()+labs(title = "nonHK")



#Convert tissue to number
dff2$var2<-dff2$variable
dff2$var2<-as.numeric(dff2$var2)
#Stackoverflow code
dens<-MASS::kde2d(dff2$var2, dff2$value, n = 200)
dens_df <- data.frame(with(dens, expand_grid( y, x)), z = as.vector(dens$z))
fit <- loess(z ~ y * x, data = dens_df, span = 0.02)
dff2$z <- predict(fit, with(dff2, data.frame(x=var2, y=value)))


h.k<-ggplot(dff2, aes(variable, value, group = GENE, color = z)) +
  geom_line(size = 0.05) +
  theme_minimal() +
  scale_color_gradientn(colors = c("blue", "yellow", "red"))+theme_bw()+labs(title = "HK")



ggarrange(nonh.k,h.k,common.legend = T )
