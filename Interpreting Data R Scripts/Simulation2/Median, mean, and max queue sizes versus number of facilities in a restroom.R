library(ggplot2)
data <- read.table("simulation2.csv", header=TRUE, sep=",")
mean <- mean(data)
median <- apply(data,2,median)
max <- apply(data,2,max)
df <- data.frame(population=seq(from=1,to=30),mean=mean, median=median,max=max)
ggplot(data = df) + scale_color_discrete(name="Type") +
  geom_smooth(aes(x=population,y=mean,color="mean")) +
  geom_point(aes(x=population,y=mean,color="mean")) +
  geom_smooth(aes(x=population,y=median,color="median")) +
  geom_point(aes(x=population,y=median,color="median")) +
  geom_smooth(aes(x=population,y=max,color="max")) +
  geom_point(aes(x=population,y=max,color="max")) +
  scale_y_continuous("queue size") +
  scale_x_continuous("number of facilities in a restroom")