



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
summary(data1)
quantile(data1, 0.2)
quantile(data1, seq(0.1, 0.9, 0.1))