#ambil data
library(foreign)
Panel <- read.dta("http://dss.princeton.edu/training/Panel101.dta")
View(Panel)
str(Panel)

#Deskriptif perbedaan variabel Y antar entitas (country)
coplot(y ~ year|country, type="l", data=Panel) # Lines
coplot(y ~ year|country, type="b", data=Panel) # Points and lines

#Deskriptif: nilai Y semua entitas dalam satu gambar
library(car)
scatterplot(y~year|country, boxplots=FALSE, smooth=TRUE, reg.line=FALSE, data=Panel)

#Heterogeneity antar country
#selang kepercayaan 95% variabel Y tiap entitas
library(gplots)
plotmeans(y ~ country, main="Heterogeineity across countries", data=Panel)

#Heterogeneity antar tahun
#selang kepercayaan 95% variabel Y tiap entitas
plotmeans(y ~ year, main="Heterogeineity across years", data=Panel)

#Regresi OLS (pooling)
ols <-lm(y ~ x1, data=Panel)
summary(ols)
#scatter plot dan garis regresi OLS
plot(Panel$x1, Panel$y, pch=19, xlab = "x1", ylab = "y")
abline(ols)
abline(ols,lwd=3,col="red")

#Regresi fixed effect dengan LSDV (least square dummy variable)
fixed.dum <-lm(y ~ x1 + factor(country) - 1, data=Panel)
summary(fixed.dum)
#garis fixed effect LSDV dan regresi ols (pooling)
yhat <- fixed.dum$fitted
scatterplot (yhat~Panel$x1|Panel$country, boxplots=FALSE, xlab="x1", ylab="yhat",smooth=FALSE)
abline(lm(Panel$y~Panel$x1),lwd=3, col="red")
#perbandingan estimasi parameter OLS (pooling) dengan LSDV
library(stargazer)
setwd("C:/Users/DYNABOOK/Documents/FILE S2/StatBis")
stargazer(ols, fixed.dum, type = "text", digits = 2, out = "OLS&LSDV.htm")

#Regresi data panel menggunakan plm
library(plm)
fixed <- plm(y ~ x1, data=Panel, index=c("country", "year"), model="within")
summary(fixed)
#intersep tiap entitas
fixef(fixed)

#Regresi data panel menggunakan plm
library(plm)
fixed <- plm(y ~ x1, data=Panel, index=c("country", "year"), model="within")
summary(fixed)
#intersep tiap entitas
fixef(fixed)
###OLS atau FE?###

#menguji: OLS atau FE? (pilh FE jika sign)
pFtest(fixed, ols)
#Uji Chow
pool<-plm(y~x1, data = Panel, index = c("country","year"),model = "pooling")
pooltest(pool,fixed)

#Regresi data panel Random 
effectsrandom <- plm(y ~ x1, data=Panel, index=c("country", "year"), model="random")
summary(effectsrandom)

#Uji Haussman (FE atau RE, pilih FE jika sign)
phtest(fixed, effectsrandom)
###Melihat time fixed effects 
fixed.time <- plm(y ~ x1 + factor(year), data=Panel, index=c("country",                                                              "year"), model="within")
summary(fixed.time)

#uji time fixed effects
pFtest(fixed.time,fixed)plmtest(fixed,c("time"),type = ("bp"))

#Breusch Pagan LM (RE Vs CE), pilih RE jika signifikan
plmtest(pool,type = c("bp"))

#Uji homoskedastisitas (homos jika pvalue tdk sign)
library(lmtest)
bptest(y ~ x1 + factor(country), data = Panel, studentize=F)




