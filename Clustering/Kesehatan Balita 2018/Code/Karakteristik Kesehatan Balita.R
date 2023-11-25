library(readxl)
library(car)
df <- read_excel("C:/Users/Windows 10/Downloads/data m3.xlsx", 
                 range = "A1:D35")
View(df)
df_mean=colMeans(df)
df_med= 
boxplot(df,
        col= c("#90EE90", "#FFA07A", "#FFB6C1","#D3D3D3"),
        ylab="Persentase", xlab="Variabel")
text(x = 1:ncol(df),y =df_mean + 12, 
     labels = paste("Mean =", round(df_mean, 1)), col = "black")
text(x = 1.2,
     y = boxplot.stats(df),
     labels = round(boxplot.stats(df),0),
     cex = 0.8,
     col ="#A11515")
text(x = col(df$stats) - .5, y = df$stats, labels = df$stats)
text(x = boxplot.stats(df)$stats, labels = boxplot.stats(df)$stats, y = 1.25)
x1 <- df$x1
x2 <- df$x2
x3 <- df$x3
x4 <- df$x4
x1_stats = boxplot.stats(x1)$stats
x2_stats = boxplot.stats(x2)$stats
x3_stats = boxplot.stats(x3)$stats
x4_stats = boxplot.stats(x4)$stats

bplot <- boxplot(x2,x3,x4,
                 col=c("#FFA07A", "#FFB6C1","#D3D3D3"),
                 ylab="Persentase", xlab="Variabel",
                 xlim=c(0,4.7),
                 at = c(0.4, 2, 3.6) ,
                 las=1)
axis(1, at = c(0.4, 2, 3.6),  c("Persentase\n balita obesitas" , "Prevalensi balita\n gizi kurang\n usia 0-23 bulan" , "Prevalensi balita\n gizi kurang\n usia 0-59 bulan"),
     line=1, lwd=0, cex.axis=0.8)
text(y=x2_stats,labels=paste(names = c("Min:" , "Q1:" , "Med:", "Q3:", "Max:"), c(round(x2_stats,2))), cex = 0.8 ,x=1.2)
text(y=x3_stats,labels=paste(names = c("Min:" , "Q1:" , "Med:", "Q3:", "Max:"), c(round(x3_stats,2))), cex = 0.8 ,x=2.8)
text(y=x4_stats,labels=paste(names = c("Min:" , "Q1:" , "Med:", "Q3:", "Max:"), c(round(x4_stats,2))), cex = 0.8 ,x=4.4)

bplot2 <- boxplot(x1, 
                 col="#90EE90" ,
                 ylab="Nilai" , 
                 xlim=c(0.8,1.42))
mtext("Indeks Khusus Penanganan Stunting", side=1, line=0.5)
text(y=x1_stats,labels=paste(names = c("Min:" , "Q1:" , "Med:", "Q3:", "Max:"), c(round(x1_stats,2))), cex = 1 ,x=1.33)
