# Load the necessary libraries
library(dplyr)
library(ggplot2)
library(tidyverse)
library(ggrepel)
library(ggthemes)

# Import the world_population.csv dataset
world_population <- read.csv("world_population_data.csv")

# Remove '%' from growth_rate column
world_population <- world_population %>%
  mutate(growth_rate = as.numeric(sub("%", "", growth_rate)))

# Create dataframe for world coordinates using map_data
world_coordinates <- map_data("world")

# Add map_data data, remove Antarctica, and join by region
world_map <- map_data("world") %>%
  filter(region != "Antarctica") %>%
  left_join(world_population, by = c("region" = "country"))

# Create label data for World
label_data <- world_map %>%
  group_by(continent) %>%
  filter(row_number() == 25, continent != "Antarctica") %>%
  # Set North America long and lat to USA for display purposes
  # Set Australia coordinates and change Oceania label
  mutate(
    long = ifelse(continent == "North America", -120.7401, long),
    lat = ifelse(continent == "North America", 47.7511, lat),
    long = ifelse(continent == "South America", -71.9675, long),
    lat = ifelse(continent == "South America", -13.5319, lat),
    long = ifelse(continent == "Africa", 18.7322, long),
    lat = ifelse(continent == "Africa", 15.4542, lat),
    long = ifelse(continent == "Europe", 25.2822, long),
    lat = ifelse(continent == "Europe", 54.8900, lat),
    long = ifelse(continent == "Asia", 87.6168, long),
    lat = ifelse(continent == "Asia", 43.8256, lat),
    long = ifelse(continent == "Oceania", 133.7751, long),
    lat = ifelse(continent == "Oceania", -25.2744, lat),
    continent = ifelse(continent == "Oceania", "Australia", continent)
  )

# Create a geom_polygon plot using ggplot2
print(ggplot(world_map) +
  geom_polygon(aes(long, lat, group = group, fill = growth_rate)) +
  coord_quickmap() +
  scale_fill_viridis_c(option = "plasma") +

  # Add labels to the plot
  labs(fill = "Growth %") +
  ggtitle("Growth Rate by Continent (2023)") +

  # Use geom_label_repel for continent labels
  geom_label_repel(
    data = label_data, aes(x = long, y = lat, label = continent),
    size = 7, max.overlaps = 5,
    box.padding = .5, point.padding = .5
  ) +

  # Uses map theme from ggthemes library
  theme_map())

# Save the plot as a file
ggsave("world_plot.jpg", dpi = 300)
