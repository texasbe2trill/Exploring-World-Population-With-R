# Load the dplyr and ggplot2 libraries
library(dplyr)
library(ggplot2)
library(tidyverse)

# Import the world_population.csv dataset
world_population <- read.csv("world_population_data.csv") %>%
  mutate("population_density" = population_2023 / area_kms_squared)


# Create data for world coordinates using map_data
world_coordinates <- map_data("world") %>%
  distinct(region) %>%
  mutate(population_density = runif(n())) %>%
  slice_sample(n = 200)

# Add simulated data and remove Antarctica
world_map <- map_data("world") %>%
  filter(region != "Antarctica") %>%
  cross_join(world_population)

# Filter the world_population dataset
# top_population <- world_population %>%
#   filter(
#     country %in% c(
#       "India", "China", "United States",
#       "Indonesia", "Pakistan", "Nigeria",
#       "Brazil", "Bangladesh", "Russia",
#       "Mexico", "Ethiopia", "Japan",
#       "Philippines", "Egypt", "DR Congo",
#       "Vietnam", "Iran", "Turkey",
#       "Germany", "Thailand", "United Kingdom"
#     )
#   ) %>%
#   mutate("population_density" = population_2023 / area_kms_squared)

# Create a scatterplot using ggplot2
print(ggplot(world_map) +
  geom_polygon(aes(long, lat, group = group, fill = population_density)) +
  coord_quickmap() +
  scale_fill_viridis_c(option = "plasma", na.value = NA) +
  theme_void())
