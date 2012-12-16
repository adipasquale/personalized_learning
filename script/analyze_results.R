#!/usr/bin/Rscript
answers <- read.csv(file="answers.csv")

# remove test (and anmin) users
answers <- answers[answers$user_login != "testuser",]

# compute means for control and test group for each step
means <- aggregate(answers$correct, by = list(material_type = answers$material_type, step_order = answers$step_order), mean)

# print figure of these means
png('means.png')
plot(means[means$material_type == "personalized",]$x, type="o", ylim=c(0,1), col="blue", axes=FALSE, ann=FALSE)
lines(means[means$material_type == "traditional",]$x, type="o", ylim=c(0,1), col="red")
axis(1, at=1:3, lab=c("Pre-test","Practice","Post-test"))
axis(2)
title(xlab="Step")
title(ylab="Mean ratio of correct answers")
legend(1, 1, c("personalized", "traditional"), cex=0.8, col=c("blue","red"), pch=21:23, lty=1:3)
dev.off()

# Welch T-Tests to determine if the means significantly differs
print("Welch T-Test for PRACTICE step")
print(t.test( correct ~ material_type, answers[answers$step_name=="practice",]))
print("Welch T-Test for WRAP UP step")
print(t.test( correct ~ material_type, answers[answers$step_name=="wrap up",]))