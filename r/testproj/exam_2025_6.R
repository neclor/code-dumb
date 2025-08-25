

# 0
# Данные для Части 1 (длина чашелистиков Virginica)
virginica_sepal_length <- c(
  4.9,
  5.6, 5.7, 5.8, 5.8, 5.8, 5.9,
  6.0, 6.0, 6.1, 6.1, 6.2, 6.2, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.4, 6.4, 6.4, 6.4, 6.4,
  6.5, 6.5, 6.5, 6.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.8, 6.8, 6.9, 6.9, 6.9,
  7.1, 7.2, 7.2, 7.2, 7.3, 7.4,
  7.6, 7.7, 7.7, 7.7, 7.7, 7.9
)

# Данные для Части 2 (полный набор iris)
data(iris)


# 1
# Формула Стерджеса
n <- length(virginica_sepal_length)
k_sturges <- round(1 + 3.322 * log10(n)) # или log2(n)
print(paste("По Стерджесу рекомендуется классов:", k_sturges))

# Проверка предложенной группировки
breaks_custom <- c(4.5, 6, 6.3, 6.5, 6.7, 6.9, 7.5, 8)
class_intervals <- cut(virginica_sepal_length, breaks = breaks_custom, include.lowest = TRUE)
freq_table <- table(class_intervals)
print("Таблица частот для предложенной группировки:")
print(freq_table)
# Классов 7, как и рекомендует Стерджес. Распределение частот относительно равномерное.


# 2
# Создаем таблицу для построения
hist_data <- data.frame(
  Class = levels(class_intervals),
  Frequency = as.vector(freq_table),
  Freq_Relative = as.vector(freq_table) / n
)
hist_data$Width <- c(1.5, 0.3, 0.2, 0.2, 0.2, 0.6, 0.5) # Ширины классов
hist_data$Height <- hist_data$Freq_Relative / hist_data$Width # Высота = Отн.Частота / Ширина

# Строим гистограмму вручную, используя plot с type="n" и rect
plot(1, type = "n", xlab = "Длина чашелистиков (см)", ylab = "Плотность (Высота)",
     main = "Гистограмма единичной площади для Virginica Sepal.Length",
     xlim = c(4.5, 8), ylim = c(0, max(hist_data$Height) * 1.1))

# Рисуем прямоугольники для каждого класса
for(i in 1:nrow(hist_data)) {
  rect(xleft = breaks_custom[i], ybottom = 0,
       xright = breaks_custom[i+1], ytop = hist_data$Height[i],
       col = "lightblue", border = "black")
}



# 3
# Описательные статистики
summary_stats <- summary(virginica_sepal_length)
print(summary_stats)

# Расчет квартилей и коэффициента Yule-Kendall вручную
q1 <- quantile(virginica_sepal_length, 0.25)
median_val <- median(virginica_sepal_length)
q3 <- quantile(virginica_sepal_length, 0.75)

yule_kendall <- (q3 + q1 - 2 * median_val) / (q3 - q1)
print(paste("Q1:", q1))
print(paste("Медиана:", median_val))
print(paste("Q3:", q3))
print(paste("Коэффициент асимметрии Yule-Kendall:", round(yule_kendall, 3)))
# Положительное значение (~0.143) подтверждает слабый правый скос.


# 4
# Истинное среднее
true_mean <- mean(virginica_sepal_length)
print(paste("Истинное среднее:", round(true_mean, 3)))

# Среднее по классам (используем центры классов)
class_centers <- c(5.25, 6.15, 6.4, 6.6, 6.8, 7.2, 7.75)
estimated_mean <- sum(hist_data$Frequency * class_centers) / n
print(paste("Оценка среднего по классам:", round(estimated_mean, 3)))
print(paste("Разница:", round(true_mean - estimated_mean, 3)))
# Разница (6.588 - 6.461 = 0.127) существует, оценка занижена.





# 5
# Строим гистограмму с помощью hist (для основы)
hist_info <- hist(virginica_sepal_length, breaks = breaks_custom, plot = FALSE)
# Пересчитываем высоты для единичной площади
hist_info$density <- hist_info$counts / (n * diff(hist_info$breaks))

# Рисуем гистограмму
plot(hist_info, freq = FALSE, col = "lightblue",
     xlab = "Длина чашелистиков (см)", ylab = "Плотность (Высота)",
     main = "Гистограмма с полигоном частот")

# Строим полигон частот: находим середины интервалов и добавляем точки по краям
midpoints <- hist_info$mids
x_poly <- c(hist_info$breaks[1], midpoints, tail(hist_info$breaks, 1))
y_poly <- c(0, hist_info$density, 0)
lines(x_poly, y_poly, type = "l", col = "red", lwd =2)



# 2.1a
# Таблица частот
species_table <- table(iris$Species)
species_rel_table <- prop.table(species_table)
print("Абсолютные частоты:")
print(species_table)
print("Относительные частоты:")
print(round(species_rel_table, 3))

# Столбчатая диаграмма (предпочтительнее)
barplot(species_table, col = c("lightgreen", "lightcoral", "lightblue"),
        main = "Распределение видов ирисов", xlab = "Вид", ylab = "Количество")

# Круговая диаграмма
pie(species_table, col = c("lightgreen", "lightcoral", "lightblue"),
    main = "Распределение видов ирисов")


# 2.1b
# Создаем 2x2 сетку для графиков
par(mfrow = c(2, 2))

# Boxplot для каждой переменной, сгруппированный по видам
variables <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
plot_colors <- c("lightgreen", "lightcoral", "lightblue")

for (var in variables) {
  boxplot(iris[[var]] ~ iris$Species, col = plot_colors,
          main = paste("Влияние вида на", var),
          xlab = "Вид", ylab = var)
}

# Пятичисловая сводка для Sepal.Length по видам
par(mfrow = c(1, 1)) # Сбрасываем сетку
print("Пятичисловая сводка для Sepal.Length по видам:")
by(iris$Sepal.Length, iris$Species, summary)
# Вывод: Медианы (и весь разброс) увеличиваются: setosa(5.0) -> versicolor(5.9) -> virginica(6.5)



# 2 2 a
# Расчет коэффициента корреляции Пирсона
correlation <- cor(iris$Sepal.Length, iris$Petal.Length)
print(paste("Коэффициент корреляции между Sepal.Length и Petal.Length:",
            round(correlation, 3)))
# Значение 0.872 указывает на сильную положительную линейную связь.
# Регрессия оправдана.


# 2 2 b

# Построение модели линейной регрессии
model_all <- lm(Petal.Length ~ Sepal.Length, data = iris)
print("Уравнение регрессии для всех данных:")
print(coef(model_all))
# Petal.Length = -7.101 + 1.858 * Sepal.Length

# График рассеяния с линией регрессии
plot(iris$Sepal.Length, iris$Petal.Length,
     xlab = "Длина чашелистика (Sepal.Length)", ylab = "Длина лепестка (Petal.Length)",
     main = "Связь длины чашелистика и лепестка\n(Все данные)")
abline(model_all, col = "red", lwd = 2)
legend("topleft", legend = paste("y =", round(coef(model_all)[2], 3), "x +", round(coef(model_all)[1], 3)),
       col = "red", lwd = 2, bty = "n")



# 2 2 c
# Создаем подмножество БЕЗ setosa
iris_no_setosa <- subset(iris, Species != "setosa")

# Строим модель для данных без setosa
model_no_setosa <- lm(Petal.Length ~ Sepal.Length, data = iris_no_setosa)
print("Уравнение регрессии без Setosa:")
print(coef(model_no_setosa))
# Petal.Length = -1.556 + 1.032 * Sepal.Length

# Строим итоговый график
plot(iris$Sepal.Length, iris$Petal.Length, col = ifelse(iris$Species == "setosa", "green", "black"),
     xlab = "Длина чашелистика (Sepal.Length)", ylab = "Длина лепестка (Petal.Length)",
     main = "Влияние вида Setosa на регрессию")
abline(model_all, col = "red", lwd = 2) # Линия для всех данных
abline(model_no_setosa, col = "blue", lwd = 2) # Линия без setosa
legend("topleft",
       legend = c("Все данные", "Без setosa", "Setosa"),
       col = c("red", "blue", "green"), lwd = c(2, 2, NA), pch = c(NA, NA, 1), bty = "n")
# Наглядно видно, как setosa "тянет" общую линию регрессии вниз.
# Наклон линии для двух других видов (1.032) гораздо меньше.








