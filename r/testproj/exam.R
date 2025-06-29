# Chargement des données iris
data <- iris
attach(data)


# Installer moments si nécessaire (pour aplatissement et assymétrie)
if (!require(moments)) install.packages("moments")
library(moments)

cat("Population : 150 iris\n")
cat("Variables : Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species\n")
cat("Nombre d'observations : ", nrow(data), "\n")

# Pourcentages, taux, proportions et pourcentages de variation
cat("\n--- Pourcentages et proportions par espèce ---\n")
prop_species <- prop.table(table(Species)) * 100
print(round(prop_species, 2))

cat("\n--- Pourcentage de variation de Sepal.Length ---\n")
perc_var <- (max(Sepal.Length) - min(Sepal.Length)) / min(Sepal.Length) * 100
cat(round(perc_var, 2), "%\n")

# Analyse des valeurs manquantes
cat("\n--- Valeurs manquantes par variable ---\n")
print(colSums(is.na(data)))

# Variables qualitatives
cat("\n--- Tableau des effectifs (Species) ---\n")
table_species <- table(Species)
print(table_species)
barplot(table_species, main="Répartition des espèces", xlab="Espèce", ylab="Effectif")
pie(table_species, main="Répartition des espèces")

# Variables quantitatives
for (var in c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")) {
  cat(paste0("\n--- Variable : ", var, " ---\n"))
  freq <- table(data[[var]])
  if (length(freq) < 15) {
    print(freq)
    barplot(freq, main=paste("Distribution de", var), xlab=var, ylab="Effectif")
  } else {
    hist(data[[var]], main=paste("Histogramme de", var), xlab=var)
  }
}

# Effectifs cumulés et courbe cumulative pour Sepal.Length
cat("\n--- Effectifs cumulés et courbe cumulative pour Sepal.Length ---\n")
sepal_length_sorted <- sort(Sepal.Length)
effectifs_cumules <- cumsum(table(sepal_length_sorted))
plot(names(effectifs_cumules), effectifs_cumules, type="s", main="Effectifs cumulés de Sepal.Length", xlab="Valeur", ylab="Effectif cumulé")
freq_cumulee <- cumsum(table(sepal_length_sorted)) / length(sepal_length_sorted)
plot(names(freq_cumulee), freq_cumulee, type="s", main="Fréquence cumulée de Sepal.Length", xlab="Valeur", ylab="Fréquence cumulée")

# Groupement des données continues, polygone, ogive
breaks <- pretty(Sepal.Length, n=5)
groups <- cut(Sepal.Length, breaks=breaks, include.lowest=TRUE, right=FALSE)
table_groups <- table(groups)
hist(Sepal.Length, breaks=breaks, main="Histogramme groupé de Sepal.Length", xlab="Classe")

# Ogive des effectifs cumulés (courbe cumulative) - CORRECTION
effectifs_cumules <- c(0, cumsum(table_groups))
plot(breaks, effectifs_cumules, type="s", col="blue", main="Ogive des effectifs cumulés",
     xlab="Borne de classe", ylab="Effectif cumulé")

# Polygone des effectifs (reste inchangé)
plot(breaks[-length(breaks)], table_groups, type="b", main="Polygone des effectifs", xlab="Classe", ylab="Effectif")

# Paramètres de position, dispersion, forme
for (var in c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")) {
  cat(paste0("\n--- Paramètres pour ", var, " ---\n"))
  cat("Résumé :\n")
  print(summary(data[[var]]))
  cat("Moyenne :", mean(data[[var]]), "\n")
  cat("Médiane :", median(data[[var]]), "\n")
  cat("Mode :", names(which.max(table(data[[var]]))), "\n")
  cat("Quantiles (0, 25, 50, 75, 100%) :\n")
  print(quantile(data[[var]], probs = c(0, 0.25, 0.5, 0.75, 1)))
  cat("Déciles :\n")
  print(quantile(data[[var]], probs=seq(0,1,0.1)))
  cat("Centiles (extraits) :\n")
  print(quantile(data[[var]], probs=seq(0,1,0.01))[c(1,25,50,75,100)])
  cat("Étendue :", diff(range(data[[var]])), "\n")
  cat("Variance :", var(data[[var]]), "\n")
  cat("Écart-type :", sd(data[[var]]), "\n")
  cat("Écart interquartile (IQR) :", IQR(data[[var]]), "\n")
  cat("Coefficient de variation :", round(sd(data[[var]])/mean(data[[var]])*100,2), "%\n")
  boxplot(data[[var]], main=paste("Boîte à moustaches de", var), ylab=var)
  cat("Asymétrie (skewness) :", round(skewness(data[[var]]),2), "\n")
  cat("Aplatissement (kurtosis) :", round(kurtosis(data[[var]]),2), "\n")
  cat("Valeurs extrêmes (outliers) :", paste(boxplot.stats(data[[var]])$out, collapse=", "), "\n")
  
}

# Statistiques descriptives par espèce
cat("\n--- Statistiques descriptives par espèce ---\n")
for (var in c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")) {
  cat(paste0("\nVariable : ", var, "\n"))
  print(aggregate(data[[var]], by=list(Espèce=data$Species), summary))
}

# Boxplots et histogrammes par espèce
boxplot(Sepal.Length ~ Species, data=data, main="Sepal.Length par espèce", ylab="Sepal.Length")
hist_by_species <- function(var) {
  for (sp in unique(data$Species)) {
    hist(data[data$Species==sp, var], main=paste(var, "pour", sp), xlab=var)
  }
}
hist_by_species("Sepal.Length")

# Tableaux croisés pour variables quantitatives discrétisées
cat("\n--- Tableau croisé : Sepal.Length (en classes) x Petal.Length (en classes) ---\n")
sepal_classes <- cut(data$Sepal.Length, breaks=4)
petal_classes <- cut(data$Petal.Length, breaks=4)
print(table(sepal_classes, petal_classes))

# Tableau de contingence (qualitative x qualitative)
cat("\n--- Tableau de contingence Species x groupes de Sepal.Length ---\n")
print(table(Species, groups))

# Distributions marginales et conditionnelles
cat("\n--- Distribution marginale de Sepal.Length ---\n")
print(table(Sepal.Length))
cat("\n--- Résumés de Sepal.Length selon Species ---\n")
print(tapply(Sepal.Length, Species, summary))

# Covariance et corrélation
cat("\n--- Matrice de corrélation entre variables quantitatives ---\n")
cor_matrix <- cor(data[,1:4])
print(cor_matrix)
cat("\n--- Matrice de covariance ---\n")
cov_matrix <- cov(data[,1:4])
print(cov_matrix)
pairs(data[,1:4], main="Nuage de points des variables quantitatives")

# Régression linéaire simple et analyse des résidus
cat("\n--- Régression linéaire Sepal.Length ~ Petal.Length ---\n")
lm_model <- lm(Sepal.Length ~ Petal.Length, data=data)
print(summary(lm_model))
plot(data$Petal.Length, data$Sepal.Length, main="Régression linéaire", xlab="Petal.Length", ylab="Sepal.Length")
abline(lm_model, col="red")
res <- resid(lm_model)
plot(res, main="Résidus de la régression", ylab="Résidu", xlab="Observation")
abline(h=0, lty=2)

# Robustesse : valeurs extrêmes
cat("\n--- Valeurs extrêmes (outliers) pour Sepal.Length ---\n")
print(boxplot.stats(Sepal.Length)$out)

# Moyenne de Sepal.Length par espèce
cat("\n--- Moyenne de Sepal.Length par espèce ---\n")
print(aggregate(Sepal.Length ~ Species, data=data, FUN=mean))

detach(data)

