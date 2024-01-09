# Load the dplyr and ggplot2 libraries
library(dplyr)
library(ggplot2)
library(tidyverse)

# Import the world_population.csv dataset
world_population <- read.csv("world_population_data.csv")

# Create data for world coordinates using map_data
world_coordinates <- map_data("world") %>%
  filter(region != "Antarctica")

# Filter the world_population dataset
top_population <- world_population %>%
  filter(
    country %in% c(
      "India", "China", "United States",
      "Indonesia", "Pakistan", "Nigeria",
      "Brazil", "Bangladesh", "Russia",
      "Mexico", "Ethiopia", "Japan",
      "Philippines", "Egypt", "DR Congo",
      "Vietnam", "Iran", "Turkey",
      "Germany", "Thailand", "United Kingdom"
    )
  ) %>%
  mutate("population_density" = population_2023 / area_kms_squared)

# Create a scatterplot using ggplot2
print(ggplot() +
  geom_map(
    data = world_coordinates, map = world_coordinates,
    aes(long, lat, map_id = region)
  )) +
  geom_point(data = top_population, aes(
    color = population_density,
    size = population_2023
  ))
