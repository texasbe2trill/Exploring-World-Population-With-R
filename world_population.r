# Load the dplyr and ggplot2 libraries
library(dplyr)
library(ggplot2)

# Import the world_population.csv dataset
world_population <- read.csv("world_population_data.csv")

# Filter the world_population dataset

# Create a scatterplot using ggplot2
print(ggplot(world_population, aes(x = continent, y = growth.rate)) +
  geom_point())
