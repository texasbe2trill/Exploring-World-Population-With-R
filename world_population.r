# Load the necessary libraries
library(dplyr)
library(ggplot2)
library(tidyverse)

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

# Create a geom_polygon plot using ggplot2
print(ggplot(world_map) +
        geom_polygon(aes(long, lat, group = group, fill = growth_rate)) +
        coord_quickmap() +
        scale_fill_viridis_c(option = "plasma") +

        # Add labels to the plot
        labs(fill = "Growth %") +
        ggtitle("Growth Rate by Region") +

        # Tweak display of theme
        theme_void())

# Save the plot as a PNG file
ggsave("plot.png", dpi = 300)
