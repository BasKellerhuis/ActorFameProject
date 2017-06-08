fame <- read.csv("actorfame.csv")
american <- c("United States", "America")
british <- c("United Kingdom", "British", "English", "Britain", "England", "Ireland", "Irish", "Welsh", "Wales", "Scottish", "Scotland")
US <- subset(fame, grepl(paste(american, collapse= "|"), fame$CountryOfOrigin))
UK <- subset(fame, grepl(paste(british, collapse= "|"), fame$CountryOfOrigin))
t.test(US$FameScore,UK$FameScore)
UK$country <- 'United Kingdom'
US$country <- 'United States'
UKUS <- rbind(UK, US)

FameByCountry <- table(UKUS$country, UKUS$FameScore)
barplot(FameByCountry, main="Number of actors with certain fame score per country",
        xlab="Fame score, lower is better", col=c("darkblue","red"),
        legend = rownames(FameByCountry), beside=TRUE)

kid <- subset(fame, fame$Age < 16)
young <- subset(fame, fame$Age >=16 & fame$Age <25)
adult  <- subset(fame, fame$Age >=25 & fame$Age <40)
middle <- subset(fame, fame$Age >=40 & fame$Age < 60)
old <- subset(fame, fame$Age >=60 & fame$Age <90)
ancient <- subset(fame, fame$Age >=90)

kid$Age <- '<16'
young$Age <- '16-25'
adult$Age <- '25-40'
middle$Age <- '40-60'
old$Age <- '60+'
ancient$Age <- 'Ancient'

ageFame <- Reduce(function(x, y) merge(x, y, all=TRUE), list(kid, young, adult, middle, old))
ageFameCorrected <- subset(ageFame, ageFame$FameScore >=0)
FameByAge <- table(ageFameCorrected$Age, ageFameCorrected$FameScore)
barplot(FameByAge, main="Number of actors with certain fame score per age group",
        xlab="Fame score, lower is better", col=c("red", "yellow", "green", "blue", "violet"), ylim = c(0,2000),
        legend = rownames(FameByAge), beside=TRUE)
fit <- aov(FameScore ~ Age, data=ageFameCorrected)
summary(fit)
TukeyHSD(fit)

meanFame <- mean(ageFame$FameScore, na.rm=TRUE)
kidsMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(kid$FameScore, na.rm=TRUE)
youngMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(young$FameScore, na.rm=TRUE)
adultMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(adult$FameScore, na.rm=TRUE)
middleMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(middle$FameScore, na.rm=TRUE)
oldMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(old$FameScore, na.rm=TRUE)

meanFameCorrected <- c(kidsMeanFame, youngMeanFame, adultMeanFame, middleMeanFame, oldMeanFame)
groupnames <- c('<16', '16-24', '25-39', '40-59', '60+')
meanFameDataFrame <- data.frame(meanFameCorrected, groupnames)

meanFameByAge <- table(meanFameDataFrame$groupnames, meanFameDataFrame$meanFameCorrected)
barplot(meanFameByAge, main="Mean fame score per age group",
        xlab="Fame score, lower is better", col=c("red", "yellow", "green", "blue", "violet"), ylim = c(-2,2),
        legend = rownames(meanFameByAge), beside=TRUE)

#install.packages("ggplot2")
#library(ggplot2)
label <- c("<16", "16-24", "25-39", "40-59", "60+")
ggplot(meanFameDataFrame, aes(label, meanFameDataFrame$meanFameCorrected, fill=as.factor(meanFameDataFrame$groupnames))) +
geom_bar(position="dodge", stat="summary", fun.y ="mean") + xlab("Age groups") + ylab("Mean difference in fame score") + ggtitle("Mean difference per age group")

regressionData <- subset(fame, fame$Age <90)
xyplot( jitter(FameScore, amount = 0.5)~jitter(Age, amount = 0.5), data = regressionData, xlab = "Age", ylab = "Fame score", main = "Fame score vs Age in Actors")

summary(lm( formula =FameScore~Age, data = regressionData))
