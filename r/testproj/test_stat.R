



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


# test 5

set.seed(189)

x1<-cars$speed
y1<-cars$dist

x2<-sample(rep(c(1, 2, 3, 4), c(5, 10, 8, 6)))
y2<-sample(rep(c(10, 11, 12), c(11, 13, 5)))

tab<-table(x2, y2)
tab

x1[x1 <= 15]
y1[y1 <= 40]

x1_cut <- cut(x1, breaks = c(0, 15, 25), labels = c("[0,15]", "[15,25]"))
x1[x1 <= 15]
x1_cut

x1_cut

# Разбиваем y1 на интервалы [0,40], [40,80], [80,120]
y1_cut <- cut(y1, breaks = c(0, 40, 80, 120), labels = c("[0,40]", "[40,80]", "[80,120]"))
y1[y1 <= 40]
y1_cut
table(y1_cut, x1_cut)

x1_cut
y1_cut

contingency_table["[0,40]", "[0,15]"]

x2_if_y2_10<-x2[y2 == 10]
x2_if_y2_10
sum(x2_if_y2_10)


cor(x1, y1)
cor(x1[-23], y1[-23]) 

plot(x1, y1)
identify(x1, y1)


x<-c(0,0,0,0,0, 0,0,0,0, 1,1,1,1,1,1, 1,1,1,1,1,1,1, 2,2,2, 2,2,2,2,2,2,2,2,2)
y<-c(0,0,0,0,0, 1,1,1,1, 0,0,0,0,0,0, 1,1,1,1,1,1,1, 0,0,0, 1,1,1,1,1,1,1,1,1)

tab<-table(x, y)
tab
cov(x, y)





data <- read.table("car-data.txt", header = TRUE, sep = "")

price <- data$Price
diff(range(price))
max(price) - min(price)


two_doors_cars <- data[data$Doors == "two", ]
two_doors_cars_prices <- two_doors_cars$Price

four_doors_cars <- data[data$Doors == "four", ]
four_doors_cars_prices <- four_doors_cars$Price


median(two_doors_cars_prices)
median(four_doors_cars_prices)


quantile(two_doors_cars_prices, 0.50)



four_doors_cars_powers <- four_doors_cars$Horsepower
sd(four_doors_cars_powers) * sqrt((112 / 113))


four_doors_cars_powers






