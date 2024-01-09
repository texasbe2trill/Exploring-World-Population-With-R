# Load the dplyr and ggplot2 libraries
library(dplyr)
library(ggplot2)
library(tidyverse)

# Import the world_population.csv dataset
world_population <- read.csv("world_population_data.csv")

# Remove '%' from growth_rate column
world_population <- world_population %>%
  mutate(
    growth_rate = as.numeric(sub("%", "", growth_rate)),
    growth_rate_multiple = growth_rate * 100
  )

# Create data for world coordinates using map_data
world_coordinates <- map_data("world") %>%
  distinct(region) %>%
  mutate(growth_rate_multiple = runif(n())) %>%
  slice_sample(n = 200)

# Add simulated data and remove Antarctica
world_map <- map_data("world") %>%
  filter(region != "Antarctica") %>%
  cross_join(world_population)


# Create a scatterplot using ggplot2
print(ggplot(world_map) +
  geom_polygon(aes(long, lat, group = group, fill = growth_rate_multiple)) +
  coord_quickmap() +
  scale_fill_viridis_c(option = "plasma", na.value = NA) +
  theme_void())
