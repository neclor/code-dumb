


yogu <- read.table("yaourts.txt", header = TRUE, sep = "\t")

gluc <- yogu$glucides_g
prot <- yogu$proteines_g
gras <- yogu$matiere_grasse_g
mark <- yogu$marque

sort(gluc)
barplot(table(gluc))
hist(gluc, 100)

table(mark)
barplot(table(mark))



yogu_filt <- yogu[yogu$glucides_g < 30, ]

gluc_filt <- yogu_filt$glucides_g
prot_filt <- yogu_filt$proteines_g
gras_filt <- yogu_filt$matiere_grasse_g
mark_filt <- yogu_filt$marque

mark_fact <- factor(yogu_filt$marque) 



# question c

#gluc
cat("---      gluc     ----- \n")
aggregate(gluc_filt, by=list(mark_filt), summary)
boxplot(gluc_filt ~ mark_filt)

#prot
cat("---      prot     ----- \n")
aggregate(prot_filt, by=list(mark_filt), summary)
boxplot(prot_filt ~ mark_filt)


#gluc
cat("---      gras     ----- \n")
aggregate(gras_filt, by=list(mark_filt), summary)
boxplot(gras_filt ~ mark_filt)



# 2 


data <- yogu_filt[yogu_filt$marque == "LactoDelice", ]
data_x <- data$glucides_g
data_y <- data$proteines_g

lm_model <- lm(data_y ~ data_x, data = data)
print(summary(lm_model))

plot(data_x, data_y, main="Régression linéaire LactoDelice", xlab="grass", ylab="glucide")
abline(lm_model, col="red")



data <- yogu_filt[yogu_filt$marque == "NatureCrémeux", ]
data_x <- data$glucides_g
data_y <- data$proteines_g

lm_model <- lm(data_y ~ data_x, data = data)
print(summary(lm_model))

plot(data_x, data_y, main="Régression linéaire NatureCrémeux", xlab="grass", ylab="glucide")
abline(lm_model, col="red")


data <- yogu_filt[yogu_filt$marque == "Yogusto", ]
data_x <- data$glucides_g
data_y <- data$proteines_g

lm_model <- lm(data_y ~ data_x, data = data)
print(summary(lm_model))

plot(data_x, data_y, main="Régression linéaire Yogusto", xlab="grass", ylab="glucide")
abline(lm_model, col="red")


data <- yogu_filt
data_x <- gras_filt
data_y <- gluc_filt

lm_model <- lm(data_y ~ data_x, data = data)
print(summary(lm_model))

plot(data_x, data_y, col=as.integer(mark_fact), pch=as.integer(mark_fact), main="Régression linéaire", xlab="grass", ylab="glucide")
legend(x="bottomright", col=1:nlevels(mark_fact), pch=1:nlevels(mark_fact), levels(mark_fact))
abline(lm_model, col="red")




















