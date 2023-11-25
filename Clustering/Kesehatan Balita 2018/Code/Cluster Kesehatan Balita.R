library(readxl)
data <- read_excel("Data kesehatan balita.xlsx", sheet = "Sheet2")
View(data)
runnum=data
datanum = data.frame(runnum$X1,runnum$X2,runnum$X3,runnum$X4)

# ===== DATA STANDARDIZATION =====
data1 = scale(datanum) 

# =========== AGGLOMERATIVE HIRARCHICAL CLUSTERING ===========
# ===== DISSMILARITY MATRIX =====
d = dist(data1, method = "euclidean") #NEAREST POINT

# =========== COMPLETE LINKAGE ===========
hcaverage = hclust(d, method = "average" )
win.graph()
plot(hcaverage, cex = 0.8, hang = -1)

# Cut tree into 4 groups================================
sub_grp4 = cutree(hcaverage, k = 4)
data.frame(sub_grp)

# Number of members in each cluster
library(dplyr)
table(sub_grp4)
datanum %>%
  mutate(cluster = sub_grp4) %>%
  head

#======== PSEUDO - F ========
datanum %>%
  mutate(cluster = sub_grp4) %>%
  group_by(cluster) %>%
  summarise_all("mean")

new_data = cbind(datanum,sub_grp4)

icdrate = function(new_data, nc, c)
{
  n = dim(new_data)[1]
  p = dim(new_data)[2]
  X = new_data[,1:(p-1)]
  Group = new_data [,p]
  p = dim(X)[2]
  Mean.X = matrix(ncol = p, nrow = (nc+1))
  for (i in 1:nc)
  {
    for (j in 1:p)
    {
      Mean.X[i,j] = mean(X[which(Group==i),j])
      Mean.X[(nc+1),j] = mean(X[,j])
    }
  }
  SST = matrix(ncol=p, nrow=n)
  for (i in 1:n)
  {
    for (j in 1:p)
    {
      SST[i,j] = (X[i,j] - Mean.X[(nc+1),j])^2
    }
  }
  SST = sum(sum(SST))
  SSE = matrix(ncol=p, nrow=n)
  for (i in 1:n)
  {
    for (j in 1:p)
    {
      for (k in 1:nc)
      {
        if (Group[i]==k)
        {
          SSE[i,j] = (X[i,j] - Mean.X[k,j])^2
        }
      }
    }
  }
  SSE = sum(sum(SSE))
  Rsq = (SST-SSE)/SST
  icdrate = 1-Rsq
  Pseudof = (Rsq/(c-1))/((icdrate)/(n-c))
  SSB=SST-SSE
  list(SST=SST, SSE=SSE, SSB=SSB, Rsq=Rsq, icdrate=icdrate, pseudof=Pseudof)
}

icdrate(new_data,length(new_data),4)
new_data

# Cut tree into 3 groups================================
sub_grp3 = cutree(hcaverage, k = 3)
data.frame(sub_grp)

# Number of members in each cluster
library(dplyr)
table(sub_grp3)
datanum %>%
  mutate(cluster = sub_grp3) %>%
  head

#======== PSEUDO - F ========
datanum %>%
  mutate(cluster = sub_grp3) %>%
  group_by(cluster) %>%
  summarise_all("mean")

new_data = cbind(datanum,sub_grp3)

icdrate(new_data,length(new_data),3)
new_data

# Cut tree into 2 groups================================
sub_grp2 = cutree(hcaverage, k = 2)
data.frame(sub_grp)

# Number of members in each cluster
library(dplyr)
table(sub_grp2)
datanum %>%
  mutate(cluster = sub_grp2) %>%
  head

#======== PSEUDO - F ========
datanum %>%
  mutate(cluster = sub_grp2) %>%
  group_by(cluster) %>%
  summarise_all("mean")

new_data = cbind(datanum,sub_grp2)

icdrate(new_data,length(new_data),2)
new_data


#plot group
win.graph()
plot(hcaverage, cex = 0.6, hang = -1)
rect.hclust(hcaverage, k = 4, border = 2:5)

#Cluster Map
library(factoextra)
win.graph()
fviz_cluster(list(data = datanum, cluster = sub_grp4))

#==================K-MEANS CLUSTER==========================
library(cluster)
#create plot of number of clusters vs total within sum of squares
win.graph()
fviz_nbclust(data1, kmeans, method = "wss")

#membentuk k means dengan k=2
km_fit = kmeans(data1,centers = 2,iter.max = 300 )
win.graph()
fviz_cluster(km_fit, data = data1)
new_data <- cbind(datanum,data.frame(km_fit$cluster))
#===== PSEUDO - F =====
icdrate(new_data,length(new_data),2)
new_data
