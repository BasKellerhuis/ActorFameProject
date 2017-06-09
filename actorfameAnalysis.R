#Installing required packages

#install.packages("ggplot2")
#library(ggplot2)
#library(lattice)

#Read in the fame data and select only those with a positive fame score
fame <- read.csv("actorfame.csv")
fame <- subset(fame, fame$FameScore >= 0)

#Find an American and a British subset
american <- c("United States", "America")
british <- c("United Kingdom", "British", "English", "Britain", "England", "Ireland", "Irish", "Welsh", "Wales", "Scottish", "Scotland")
US <- subset(fame, grepl(paste(american, collapse= "|"), fame$CountryOfOrigin))
UK <- subset(fame, grepl(paste(british, collapse= "|"), fame$CountryOfOrigin))

#Run a t-test
t.test(US$FameScore,UK$FameScore)

#Combining the country subsets with a clear label
UK$country <- 'United Kingdom'
US$country <- 'United States'
UKUS <- rbind(UK, US)

#Create plots comparing fame score by country
FameByCountry <- table(UKUS$country, UKUS$FameScore)
barplot(FameByCountry, main="Number of actors with certain fame score per country",
        xlab="Fame score, lower is better", ylab="Number of actors", col=c("darkblue","red"),
        legend = rownames(FameByCountry), beside=TRUE)

USmeanFame <- mean(fame$FameScore, na.rm = TRUE) - mean(US$FameScore, na.rm = TRUE)
UKmeanFame <- mean(fame$FameScore, na.rm = TRUE) - mean(UK$FameScore, na.rm = TRUE)

meanFameCountry <- c(USmeanFame, UKmeanFame)
groupnamesCountry <- c('US', 'UK')
meanFameDataFrameCountry <- data.frame(meanFameCountry, groupnamesCountry)
Country<-as.factor(meanFameDataFrameCountry$groupnamesCountry)

ggplot(meanFameDataFrameCountry, aes(groupnamesCountry, meanFameCountry, fill=Country)) +
  geom_bar(position="dodge", stat="summary", fun.y ="mean") + xlab("Country") + ylab("Mean difference in fame score") + 
  ggtitle("Mean difference per country")


#Subset by age and create clear labels, then turn back into one dataframe
kid <- subset(fame, fame$Age < 16)
young <- subset(fame, fame$Age >=16 & fame$Age <25)
adult  <- subset(fame, fame$Age >=25 & fame$Age <40)
middle <- subset(fame, fame$Age >=40 & fame$Age < 60)
old <- subset(fame, fame$Age >=60 & fame$Age <90)
ancient <- subset(fame, fame$Age >=90)

kid$Age <- '<16'
young$Age <- '16-24'
adult$Age <- '25-39'
middle$Age <- '40-59'
old$Age <- '60+'
ancient$Age <- 'Ancient'

ageFame <- Reduce(function(x, y) merge(x, y, all=TRUE), list(kid, young, adult, middle, old))

#Create a plot comparing fame score by age group
FameByAge <- table(ageFame$Age, ageFame$FameScore)
barplot(FameByAge, main="Number of actors with certain fame score per age group",
        xlab="Fame score, lower is better", ylab = "Number of actors", col=c("red", "yellow", "green", "blue", "violet"), ylim = c(0,2000),
        legend = rownames(FameByAge), beside=TRUE)

#Run one-way ANOVA with post hoc
fit <- aov(FameScore ~ Age, data=ageFame)
summary(fit)
TukeyHSD(fit)

#Calculate means per age group and plot the means
meanFame <- mean(ageFame$FameScore, na.rm=TRUE)
kidsMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(kid$FameScore, na.rm=TRUE)
youngMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(young$FameScore, na.rm=TRUE)
adultMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(adult$FameScore, na.rm=TRUE)
middleMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(middle$FameScore, na.rm=TRUE)
oldMeanFame <- mean(ageFame$FameScore, na.rm=TRUE) - mean(old$FameScore, na.rm=TRUE)

meanFameAge <- c(kidsMeanFame, youngMeanFame, adultMeanFame, middleMeanFame, oldMeanFame)
groupnames <- c('<16', '16-24', '25-39', '40-59', '60+')
meanFameDataFrame <- data.frame(meanFameCorrected, groupnames)
Age_Group<-as.factor(meanFameDataFrame$groupnames)
ggplot(meanFameDataFrame, aes(groupnames, meanFameDataFrame$meanFameCorrected, fill=Age_Group)) +
geom_bar(position="dodge", stat="summary", fun.y ="mean") + xlab("Age groups") + ylab("Mean difference in fame score") + 
ggtitle("Mean difference per age group")

#Regression fame score by age and plot
regressionData <- subset(fame, fame$Age <90)
xyplot( jitter(FameScore, amount = 0.5)~jitter(Age, amount = 0.5), data = regressionData, xlab = "Age", ylab = "Fame score", main = "Fame score vs Age in Actors")

summary(lm( formula =FameScore~Age, data = regressionData))


#Plot fame score by letter
letterLegend <- c("Other", paste(LETTERS, sep = ","))

FameByLetter <- table(fame$FirstLetter, fame$FameScore)
barplot(FameByLetter, main="Number of actors with certain fame score per first letter of first name",
        xlab="Fame score, lower is better", ylab="Number of actors", col=c("darkblue","red"),
        legend = letterLegend, beside=TRUE)

#ANOVA by letter
fit <- aov(FameScore ~ FirstLetter, data=fame)
summary(fit)
TukeyHSD(fit)

#Plot fame scores by first letter in first name. This code is very lengthy, not sure if there is a simpler way to do this, but it works :)
Otherletter <- subset(fame, fame$FirstLetter == "")
Aletter <- subset(fame, fame$FirstLetter == "A")
Bletter <- subset(fame, fame$FirstLetter == "B")
Cletter <- subset(fame, fame$FirstLetter == "C")
Dletter <- subset(fame, fame$FirstLetter == "D")
Eletter <- subset(fame, fame$FirstLetter == "E")
Fletter <- subset(fame, fame$FirstLetter == "F")
Gletter <- subset(fame, fame$FirstLetter == "G")
Hletter <- subset(fame, fame$FirstLetter == "H")
Iletter <- subset(fame, fame$FirstLetter == "I")
Jletter <- subset(fame, fame$FirstLetter == "J")
Kletter <- subset(fame, fame$FirstLetter == "K")
Lletter <- subset(fame, fame$FirstLetter == "L")
Mletter <- subset(fame, fame$FirstLetter == "M")
Nletter <- subset(fame, fame$FirstLetter == "N")
Oletter <- subset(fame, fame$FirstLetter == "O")
Pletter <- subset(fame, fame$FirstLetter == "P")
Qletter <- subset(fame, fame$FirstLetter == "Q")
Rletter <- subset(fame, fame$FirstLetter == "R")
Sletter <- subset(fame, fame$FirstLetter == "S")
Tletter <- subset(fame, fame$FirstLetter == "T")
Uletter <- subset(fame, fame$FirstLetter == "U")
Vletter <- subset(fame, fame$FirstLetter == "V")
Wletter <- subset(fame, fame$FirstLetter == "W")
Xletter <- subset(fame, fame$FirstLetter == "X")
Yletter <- subset(fame, fame$FirstLetter == "Y")
Zletter <- subset(fame, fame$FirstLetter == "Z")



fameMean <- mean(fame$FameScore, na.rm = TRUE)
OtherMeanFame <- fameMean - mean(Otherletter$FameScore, na.rm=TRUE)
AmeanFame <- fameMean - mean(Aletter$FameScore, na.rm=TRUE)
BmeanFame <- fameMean - mean(Bletter$FameScore, na.rm=TRUE)
CmeanFame <- fameMean - mean(Cletter$FameScore, na.rm=TRUE)
DmeanFame <- fameMean - mean(Dletter$FameScore, na.rm=TRUE)
EmeanFame <- fameMean - mean(Eletter$FameScore, na.rm=TRUE)
FmeanFame <- fameMean - mean(Fletter$FameScore, na.rm=TRUE)
GmeanFame <- fameMean - mean(Gletter$FameScore, na.rm=TRUE)
HmeanFame <- fameMean - mean(Hletter$FameScore, na.rm=TRUE)
ImeanFame <- fameMean - mean(Iletter$FameScore, na.rm=TRUE)
JmeanFame <- fameMean - mean(Jletter$FameScore, na.rm=TRUE)
KmeanFame <- fameMean - mean(Kletter$FameScore, na.rm=TRUE)
LmeanFame <- fameMean - mean(Lletter$FameScore, na.rm=TRUE)
MmeanFame <- fameMean - mean(Mletter$FameScore, na.rm=TRUE)
NmeanFame <- fameMean - mean(Nletter$FameScore, na.rm=TRUE)
OmeanFame <- fameMean - mean(Oletter$FameScore, na.rm=TRUE)
PmeanFame <- fameMean - mean(Pletter$FameScore, na.rm=TRUE)
QmeanFame <- fameMean - mean(Qletter$FameScore, na.rm=TRUE)
RmeanFame <- fameMean - mean(Rletter$FameScore, na.rm=TRUE)
SmeanFame <- fameMean - mean(Sletter$FameScore, na.rm=TRUE)
TmeanFame <- fameMean - mean(Tletter$FameScore, na.rm=TRUE)
UmeanFame <- fameMean - mean(Uletter$FameScore, na.rm=TRUE)
VmeanFame <- fameMean - mean(Vletter$FameScore, na.rm=TRUE)
WmeanFame <- fameMean - mean(Wletter$FameScore, na.rm=TRUE)
XmeanFame <- fameMean - mean(Xletter$FameScore, na.rm=TRUE)
YmeanFame <- fameMean - mean(Yletter$FameScore, na.rm=TRUE)
ZmeanFame <- fameMean - mean(Zletter$FameScore, na.rm=TRUE)

Otherletter$LetterLabel <- 'Other'
Aletter$LetterLabel <- 'A'
Bletter$LetterLabel <- 'B'
Cletter$LetterLabel <- 'C'
Dletter$LetterLabel <- 'D'
Eletter$LetterLabel <- 'E'
Fletter$LetterLabel <- 'F'
Gletter$LetterLabel <- 'G'
Hletter$LetterLabel <- 'H'
Iletter$LetterLabel <- 'I'
Jletter$LetterLabel <- 'J'
Kletter$LetterLabel <- 'K'
Lletter$LetterLabel <- 'L'
Mletter$LetterLabel <- 'M'
Nletter$LetterLabel <- 'N'
Oletter$LetterLabel <- 'O'
Pletter$LetterLabel <- 'P'
Qletter$LetterLabel <- 'Q'
Rletter$LetterLabel <- 'R'
Sletter$LetterLabel <- 'S'
Tletter$LetterLabel <- 'T'
Uletter$LetterLabel <- 'U'
Vletter$LetterLabel <- 'V'
Wletter$LetterLabel <- 'W'
Xletter$LetterLabel <- 'X'
Yletter$LetterLabel <- 'Y'
Zletter$LetterLabel <- 'Z'

meanFameLetters <- c(OtherMeanFame, AmeanFame, BmeanFame, CmeanFame, DmeanFame, EmeanFame, FmeanFame, GmeanFame, HmeanFame, ImeanFame, JmeanFame, KmeanFame, LmeanFame, MmeanFame, NmeanFame, OmeanFame, PmeanFame, QmeanFame, RmeanFame, SmeanFame, TmeanFame, UmeanFame, VmeanFame, WmeanFame, XmeanFame, YmeanFame, ZmeanFame)
groupnamesLetters <- c('Other', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
meanFameDataFrameLetters <- data.frame(meanFameLetters, groupnamesLetters)
First_letter<-as.factor(meanFameDataFrameLetters$groupnamesLetters)

ggplot(meanFameDataFrameLetters, aes(groupnamesLetters, meanFameLetters, fill=First_letter)) +
  geom_bar(position="dodge", stat="summary", fun.y ="mean") + xlab("First letter") + ylab("Mean difference in fame score") + 
  ggtitle("Mean difference per letter")

