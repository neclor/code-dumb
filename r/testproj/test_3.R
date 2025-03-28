



set.seed(150)
data1<-round(rnorm(20, 10, 3), 2)
data1

set.seed(164)
data2<-round(rexp(25, 5), 2)
data2

set.seed(148)
data3<-rpois(18, 2)
data3

set.seed(246)
data4<-15-round(rchisq(67, 3))
data4

mean(data1)
median(data1)
quantile(data1)
range(data1)
summary(data4)
quantile(data1, 0.2)
quantile(data1, seq(0.1, 0.9, 0.1))

mean(data3)
median(data3)




x<-iris$Petal.Length
type<-iris$Species

a<-(quantile(x, 0.75) + quantile(x, 0.25) - 2 * quantile(x, 0.50))
b<-(quantile(x, 0.75) - quantile(x, 0.25))
a
b
a/b

x

virg<-x[type=='virginica']
vers<-x[type=='versicolor']


var(virg)*49/50
var(vers)*49/50


s_i<-mean(virg)
s_e<-mean(vers)
s<-(s_i+s_e)*50 / 100
ss<-50*( (s_i-s)**2 + (s_e-s)**2 )
ss

mean(virg)
mean(vers)

