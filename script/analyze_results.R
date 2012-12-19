#!/usr/bin/Rscript
require("reshape")

answers <- read.csv(file="answers_wed_no_test_users.csv")

# remove test (and anmin) users
answers <- answers[answers$user_login != "testuser",]

# compute means for different material types for each step
means <- aggregate(answers$correct, by = list(material_type = answers$material_type, step_order = answers$step_order), mean)

# print figure of these correct answers means
png('correct_answers_means.png')
plot(means[means$material_type == "personalized",]$x, type="o", ylim=c(0,1), col="blue", axes=FALSE, ann=FALSE)
lines(means[means$material_type == "traditional",]$x, type="o", ylim=c(0,1), col="red")
axis(1, at=1:3, lab=c("Pre-test","Practice","Post-test"))
axis(2)
title(xlab="Step")
title(ylab="Mean ratio of correct answers")
legend(1, 1, c("personalized", "traditional"), cex=0.8, col=c("blue","red"), pch=21:23, lty=1:3)
dev.off()

# calculate users improvement
means_users <- aggregate(answers$correct, by = list(user = answers$user_login, material_type = answers$material_type, step_name = answers$step_name), mean)
names(means_users)[names(means_users)=="x"] <- "mean"
means_users_wide <- reshape(means_users, v.names = "mean" , idvar = "user", direction="wide", timevar="step_name")
means_users_wide$improvement = means_users_wide$"mean.wrap up" - means_users_wide$"mean.warm up"
means_correct_improvement <- aggregate(means_users_wide$improvement, by=list(material_type = means_users_wide$material_type), mean)

# Welch T-Tests to determine if the means significantly differs
print("Welch T-Test for PRACTICE step")
print(t.test( correct ~ material_type, answers[answers$step_name=="practice",]))
print("Welch T-Test for WRAP UP step")
print(t.test( correct ~ material_type, answers[answers$step_name=="wrap up",]))

# retreive durations and compute mean improvements
duration <- read.csv(file="durations.csv")
duration$improvement= 1 - (duration$post_test / duration$pre_test)
means_durations_improvement <- aggregate(duration$improvement, by=list(material_type=duration$material_type), mean)

png('improvements.png')
# merge duration and correct improvements and plot them
improvements <- merge(means_correct_improvement, means_durations_improvement, by="material_type", suffixes=c("_correct", "_duration"))
 barplot(as.matrix(improvements[,c("x_correct", "x_duration")]), ylab="improvement ratio", beside=T, col=c("blue","red"), names.arg=c("correct answers", "duration"))
legend("topleft", c("personalized", "traditional"), cex=0.8, fill=c("blue","red"))
dev.off()