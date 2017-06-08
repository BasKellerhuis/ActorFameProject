fame <- read.csv("actorfame.csv")
american <- c("United States", "America")
british <- c("United Kingdom", "British", "English", "Britain", "England", "Ireland", "Irish", "Welsh", "Wales", "Scottish", "Scotland")
US <- subset(fame, grepl(paste(american, collapse= "|"), fame$Country.of.Origin))
UK <- subset(fame, grepl(paste(british, collapse= "|"), fame$Country.of.Origin))
t.test(vs$Fame.score,vk$Fame.score)
UK$country <- 'United Kingdom'
US$country <- 'United States'
UKUS <- rbind(UK, US)

FameByCountry <- table(UKUS$country, UKUS$Fame.score)
barplot(FameByCountry, main="Amount of actors with certain fame score per country",
        xlab="Fame score, lower is better", col=c("darkblue","red"),
        legend = rownames(FameByCountry), beside=TRUE)
