

data <- read.table("Communes.txt", header=TRUE, sep="", stringsAsFactors = FALSE)

print(data)

print(min(data$Chomage))
print(max(data$Chomage))



