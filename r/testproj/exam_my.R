
data <- iris
attach(data)
data

virginica <- data[Species == "virginica", ]
virginica
set <- data[Species == "setosa", ]
table(virginica)

sort(virginica$Sepal.Length)
sum(virginica$Sepal.Length)
cls = c(4.5, 6.0, 6.3, 6.5, 6.7, 6.9, 7.5, 8.0)
hist(virginica$Sepal.Length, breaks=cls, main="", xlab="Cls")
mean(virginica$Sepal.Length)

mean( c(4.9, 5.6, 5.7, 5.8, 5.8, 5.8, 5.9, 6.0, 6.0))
mean( c(6.1, 6.1 ,6.2, 6.2, 6.3 ,6.3 ,6.3, 6.3, 6.3, 6.3))
mean( c(6.4 ,6.4 ,6.4, 6.4 ,6.4, 6.5 ,6.5 ,6.5, 6.5))
mean( c(6.7 ,6.7 ,6.7, 6.7, 6.7))
mean( c(6.8, 6.8, 6.9 ,6.9 ,6.9))
mean( c(7.1 ,7.2 ,7.2 ,7.2 ,7.3, 7.4))
mean(c(7.6 ,7.7 ,7.7 ,7.7, 7.7 ,7.9))


boxplot(Sepal.Length ~ Species, data=data, main="Sepal.Length par espèce", ylab="Sepal.Length")
boxplot(Sepal.Width ~ Species, data=data, main="Sepal.Length par espèce", ylab="Sepal.Length")
boxplot(Petal.Length ~ Species, data=data, main="Sepal.Length par espèce", ylab="Sepal.Length")
boxplot(Petal.Width ~ Species, data=data, main="Sepal.Length par espèce", ylab="Sepal.Length")

pairs(data[,1:4], main="Nuage de points des variables quantitatives")

lm_model <- lm(Petal.Length ~ Sepal.Length, data=data)
print(summary(lm_model))
plot(data$Sepal.Length, data$Petal.Length, main="Régression linéaire", xlab="S.Length", ylab="P.Length")
abline(lm_model, col="red")


plot(set$Sepal.Length, set$Petal.Length, main="Régression linéaire", xlab="S.Length", ylab="P.Length")

