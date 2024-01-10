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

# Filter data for African countries
africa_map <- subset(world_coordinates, region %in% c(
  "Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi",
  "Cabo Verde", "Cameroon", "Central African Republic", "Chad", "Comoros",
  "Democratic Republic of the Congo", "Djibouti", "Egypt",
  "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", "Gabon",
  "Gambia", "Ghana", "Guinea",
  "Guinea-Bissau", "Ivory Coast", "Kenya", "Lesotho", "Liberia", "Libya",
  "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco",
  "Mozambique", "Namibia", "Niger", "Nigeria", "Republic of Congo",
  "Rwanda", "Sao Tome and Principe",
  "Senegal", "Seychelles", "Sierra Leone", "Somalia",
  "South Africa", "South Sudan",
  "Sudan", "Swaziland", "Tanzania", "Togo", "Tunisia",
  "Uganda", "Western Sahara", "Zambia", "Zimbabwe"
)) %>%
  left_join(world_population, by = c("region" = "country"))

# Create label data for Africa
label_data <- africa_map %>%
  group_by(region) %>%
  filter(row_number() == 50)

# Create a geom_polygon plot using ggplot2
print(ggplot(africa_map) +
  geom_polygon(aes(long, lat, group = group, fill = growth_rate)) +
  coord_quickmap() +
  scale_fill_viridis_c(option = "plasma") +

  # Add labels to the plot
  labs(fill = "Growth %") +
  ggtitle("Growth Rate In Africa") +

  # Use geom_label_repel for Africa labels
  geom_label_repel(
    data = label_data, aes(x = long, y = lat, label = region),
    size = 7, max.overlaps = 7
  ) +

  # Tweak display of theme
  theme_map())

# Save the plot as a PNG file
ggsave("africa_plot.png", dpi = 300)
