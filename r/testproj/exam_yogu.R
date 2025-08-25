

if (!require(moments)) install.packages("moments")
library(moments)


yogu <- read.table("yaourts.txt", header = TRUE, sep = "\t")

gluc <- yogu$glucides_g
prot <- yogu$proteines_g
gras <- yogu$matiere_grasse_g
mark <- yogu$marque


yogu_filt <- yogu[yogu$glucides_g < 30, ] # & yogu$proteines_g < 7

gluc_filt <- yogu_filt$glucides_g
prot_filt <- yogu_filt$proteines_g
gras_filt <- yogu_filt$matiere_grasse_g
mark_filt <- yogu_filt$marque


nrow(yogu_filt) # Количество записей
print(colSums(is.na(yogu_filt))) # Analyse des valeurs manquantes Анализ пропущенных значений


barplot(table(mark_filt))
barplot(table(mark_filt) / sum(table(mark_filt)))

hist(gluc_filt, 15)
hist(prot_filt, 15)
hist(gras_filt, 15)
hist(mark_filt, 15)


mark_fact <- factor(yogu_filt$marque) 

plot(gluc_filt, prot_filt, col=as.integer(mark_fact), pch=as.integer(mark_fact))
legend(x="bottomright", col=1:nlevels(mark_fact), pch=1:nlevels(mark_fact), levels(mark_fact))

plot(gluc_filt, gras_filt, col=as.integer(mark_fact), pch=as.integer(mark_fact))
legend(x="bottomright", col=1:nlevels(mark_fact), pch=1:nlevels(mark_fact), levels(mark_fact))

plot(prot_filt, gras_filt, col=as.integer(mark_fact), pch=as.integer(mark_fact))
legend(x="bottomright", col=1:nlevels(mark_fact), pch=1:nlevels(mark_fact), levels(mark_fact))


prop_gluc_filt <- prop.table(table(gluc_filt)) * 100
prop_gluc_filt

percent_variation <- (max(gluc_filt) - min(gluc_filt)) / min(gluc_filt) * 100
percent_variation 



# 2.2.3 Кумулированные частоты и кумулятивная кривая - Effectifs cumulés et courbe cumulative


data_cum <- gluc_filt

effectifs_cumules <- cumsum(table(sort(data_cum)))
plot(effectifs_cumules, type="s")

freq_cumulee <- cumsum(table(sort(data_cum))) / length(data_cum)
plot(freq_cumulee, type="s")



# 2.3 Непрерывные переменные - Variables quantitatives continues

# 2.3.2 Гистограмма - Histogramme

data_class <- gluc_filt

classes = c(0, 5, 10, 15, 20)
classes_p <- pretty(data_class, n=10)

breaks <- classes_p

hist(data_class, breaks=breaks)


# 2.3.4 Огива кумулятивных частот - Ogive des fréquences cumulées

data_ogive <- gluc_filt

classes <- c(0, 5, 10, 15, 20)
classes_p <- pretty(data_ogive, n=10)

breaks <- classes_p

groups <- cut(data_class, breaks=breaks)

effectifs_cumules <- c(0, cumsum(table(groups)))

plot(breaks, effectifs_cumules, type="s")

plot(breaks[-length(breaks)], table(groups), type="b")



# 3. Сокращение данных - Réduction des données

data <- yogu_filt

boxplot(gluc_filt)
boxplot(prot_filt)
boxplot(gras_filt)

for (var in c("glucides_g", "proteines_g", "matiere_grasse_g")) {
  
  cat(paste0("\n--- Paramètres pour ", var, " ---\n"))
  cat("\n")
  
  cat("Résumé :\n")
  print(summary(data[[var]]))
  cat("\n")
  
  cat("Moyenne :", mean(data[[var]]), "\n")
  cat("Médiane :", median(data[[var]]), "\n")
  cat("Mode :", names(which.max(table(data[[var]]))), "\n")
  cat("\n")
  
  cat("Quantiles (0, 25, 50, 75, 100%) :\n")
  print(quantile(data[[var]], probs = c(0, 0.25, 0.5, 0.75, 1)))
  cat("\n")
  
  cat("Déciles :\n")
  print(quantile(data[[var]], probs=seq(0,1,0.1)))
  cat("\n")
  
  cat("Centiles (extraits) :\n")
  print(quantile(data[[var]], probs=seq(0,1,0.01))[c(1,25,50,75,100)])
  cat("\n")
  
  cat("Étendue :", diff(range(data[[var]])), "\n")
  cat("Variance n-1 :", var(data[[var]]), "\n")
  cat("Écart-type n-1 :", sd(data[[var]]), "\n")
  
  var_n <- var(data[[var]]) * (length(data[[var]]) - 1) / length(data[[var]])
  cat("Variance n :", var_n, "\n")
  sd_n <- sqrt(var_n)
  cat("Écart-type n :", sqrt(var_n), "\n")
  
  
  cat("Écart interquartile (EIQ) :", IQR(data[[var]]), "\n")
  cat("Coefficient de variation n - 1 :", round(sd(data[[var]]) / mean(data[[var]]) * 100, 2), "%\n")
  cat("Coefficient de variation n :", round(sd_n / mean(data[[var]]) * 100, 2), "%\n")
  
  boxplot(data[[var]], main=paste("Boîte à moustaches de", var), ylab=var)
  
  cat("Asymétrie (skewness) :", round(skewness(data[[var]]),2), "\n")
  cat("Aplatissement (kurtosis) :", round(kurtosis(data[[var]]),2), "\n")
  cat("Valeurs extrêmes (outliers) :", paste(boxplot.stats(data[[var]])$out, collapse=", "), "\n")
}


for (var in c("glucides_g", "proteines_g", "matiere_grasse_g")) {
  
  cat(paste0("\nVariable : ", var, "\n"))
  
  print(aggregate(data[[var]], by=list(mark_filt), summary))
}


# Boxplots et histogrammes par type

data <- yogu_filt

boxplot(gluc_filt ~ mark_filt)

hist_by_type <- function(var) {
  for (sp in unique(data$marque)) {
    hist(data[data$marque==sp, var], main=paste(var, "pour", sp), xlab=var)
  }
}

hist_by_type("glucides_g")
hist_by_type("proteines_g")
hist_by_type("matiere_grasse_g")

marques <- unique(data$marque)
#moyennes/marques
subset <- data[data$marque == marques[1], ]
moyenne_glucide_yog<-mean(subset$glucides_g)
moyenne_protéines_yog<-mean(subset$proteines_g)
moyenne_mg_yog<-mean(subset$matiere_grasse_g)

subset <- data[data$marque == marques[2], ]
moyenne_glucide_nat<-mean(subset$glucides_g)
moyenne_protéines_nat<-mean(subset$proteines_g)
moyenne_mg_nat<-mean(subset$matiere_grasse_g)

subset <- data[data$marque == marques[3], ]
moyenne_glucide_lad<-mean(subset$glucides_g)
moyenne_protéines_lad<-mean(subset$proteines_g)
moyenne_mg_lad<-mean(subset$matiere_grasse_g)

#boxplot
boxplot(data$glucides_g ~ data$marque, main = "Glucides par marque", col = "lightblue")
boxplot(data$proteines_g ~ data$marque, main = "Protéines par marque", col = "lightgreen")
boxplot(data$matiere_grasse_g ~ data$marque, main = "Matières grasses par marque", col = "salmon")


# Tableaux croisés pour variables quantitatives discrétisées

data_1 <- gluc_filt
data_2 <- prot_filt

num_break <- 4

cat("\n--- Tableau croisé : glucides_g (en classes) x proteines_g (en classes) ---\n")

group_1 <- cut(data_1, breaks=num_break)
group_2 <- cut(data_2, breaks=num_break)
print(table(group_1, group_2))


# Tableau de contingence (qualitative x qualitative)

data <- gluc_filt

classes <- c(0, 5, 10, 15, 20)
classes_p <- pretty(data, n=5)

breaks <- classes_p

groups <- cut(data, breaks=breaks)

cat("\n--- Tableau de contingence type x groupes de  ---\n")

print(table(mark_filt, groups))



# Distributions marginales et conditionnelles
cat("\n--- Distribution marginale de  ---\n")
print(table(gluc_filt))
cat("\n--- Résumés de  selon type ---\n")
print(tapply(gluc_filt, mark_filt, summary))


# Covariance et corrélation

data <- yogu_filt

cat("\n--- Matrice de corrélation entre variables quantitatives ---\n")
cor_matrix <- cor(data[,1:3])
print(cor_matrix)

cat("\n--- Matrice de covariance ---\n")
cov_matrix <- cov(data[,1:3])
print(cov_matrix)
pairs(data[,1:3], main="Nuage de points des variables quantitatives")



# Régression linéaire simple et analyse des résidus

data <- yogu_filt
data_1 <- gluc_filt
data_2 <- prot_filt


cat("\n--- Régression linéaire  ---\n")

lm_model <- lm(data_1 ~ data_2, data = data)
print(summary(lm_model))

plot(data_2, data_1, main="Régression linéaire", xlab="", ylab="")
abline(lm_model, col="red")

res <- resid(lm_model)
plot(res, main="Résidus de la régression", ylab="Résidu", xlab="Observation")

abline(h=0, lty=2)


# Robustesse : valeurs extrêmes
cat("\n--- Valeurs extrêmes (outliers) pour gluc_filt ---\n")
print(boxplot.stats(gluc_filt)$out)


# Moyenne de Sepal.Length par espèce
cat("\n--- Moyenne de gluc_filt par espèce ---\n")
print(aggregate(gluc_filt ~ mark_filt, data=data, FUN=mean))








central_moment <- function(x, k) {
  m <- mean(x)
  mean((x - m)^k)
}

x <- c(1, 2, 3, 4, 5)

central_moment(x, 2) # дисперсия
central_moment(x, 3) # третий момент
central_moment(x, 4) # четвёртый момент





# Коэффициент Фишера–Пирсона (асимметрия / skewness)
skewness <- function(x) {
  m2 <- central_moment(x, 2)
  m3 <- central_moment(x, 3)
  m3 / (m2^(3/2))
}

skewness(x)



kurtosis <- function(x) {
  m2 <- central_moment(x, 2)
  m4 <- central_moment(x, 4)
  m4 / (m2^2) - 3
}

kurtosis(x)




yule_kendall <- function(x) {
  qs <- quantile(x, probs = c(0.25, 0.5, 0.75), type = 7)
  (qs[3] + qs[1] - 2*qs[2]) / (qs[3] - qs[1])
}

yule_kendall(x)




