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
  "Sudan", "Tanzania", "Togo", "Tunisia",
  "Uganda", "Western Sahara", "Zambia", "Zimbabwe"
)) %>%
  left_join(world_population, by = c("region" = "country"))

# Create label data for Africa
label_data <- africa_map %>%
  group_by(region) %>%
  filter(row_number() == 2) %>%
  mutate(
    region = ifelse(region == "Democratic Republic of the Congo", "DRC", region),
    long = ifelse(region == "Algeria", 2.6322, long),
    lat = ifelse(region == "Algeria", 28.1636, lat),
    long = ifelse(region == "Angola", 17.8739, long),
    lat = ifelse(region == "Angola", -11.2027, lat),
    long = ifelse(region == "Benin", 2.3158, long),
    lat = ifelse(region == "Benin", 9.3077, lat),
    long = ifelse(region == "Botswana", 24.6849, long),
    lat = ifelse(region == "Botswana", -22.3275, lat),
    long = ifelse(region == "Burkina Faso", -1.5616, long),
    lat = ifelse(region == "Burkina Faso", 12.6392, lat),
    long = ifelse(region == "Burundi", 29.9196, long),
    lat = ifelse(region == "Burundi", -3.3731, lat),
    long = ifelse(region == "Cabo Verde", -23.9812, long),
    lat = ifelse(region == "Cabo Verde", 15.9552, lat),
    long = ifelse(region == "Cameroon", 12.2776, long),
    lat = ifelse(region == "Cameroon", 5.9631, lat),
    long = ifelse(region == "Central African Republic", 20.9394, long),
    lat = ifelse(region == "Central African Republic", 6.6111, lat),
    long = ifelse(region == "Chad", 18.7322, long),
    lat = ifelse(region == "Chad", 15.4542, lat),
    long = ifelse(region == "Comoros", 43.8726, long),
    lat = ifelse(region == "Comoros", -11.8776, lat),
    long = ifelse(region == "DRC", 23.6599, long),
    lat = ifelse(region == "DRC", -2.8770, lat),
    long = ifelse(region == "Djibouti", 42.5903, long),
    lat = ifelse(region == "Djibouti", 11.8251, lat),
    long = ifelse(region == "Egypt", 31.2357, long),
    lat = ifelse(region == "Egypt", 30.0444, lat),
    long = ifelse(region == "Equatorial Guinea", 10.2679, long),
    lat = ifelse(region == "Equatorial Guinea", 1.6508, lat),
    long = ifelse(region == "Eritrea", 39.7823, long),
    lat = ifelse(region == "Eritrea", 15.1794, lat),
    long = ifelse(region == "Eswatini", 31.4659, long),
    lat = ifelse(region == "Eswatini", -26.5225, lat),
    long = ifelse(region == "Ethiopia", 39.7272, long),
    lat = ifelse(region == "Ethiopia", 9.1450, lat),
    long = ifelse(region == "Gabon", 11.6094, long),
    lat = ifelse(region == "Gabon", -0.8037, lat),
    long = ifelse(region == "Gambia", -15.3960, long),
    lat = ifelse(region == "Gambia", 13.4549, lat),
    long = ifelse(region == "Ghana", -1.0307, long),
    lat = ifelse(region == "Ghana", 7.9533, lat),
    long = ifelse(region == "Guinea", -10.9446, long),
    lat = ifelse(region == "Guinea", 11.2326, lat),
    long = ifelse(region == "Guinea-Bissau", -15.1804, long),
    lat = ifelse(region == "Guinea-Bissau", 11.8037, lat),
    long = ifelse(region == "Ivory Coast", -5.5436, long),
    lat = ifelse(region == "Ivory Coast", 7.5380, lat),
    long = ifelse(region == "Kenya", 37.8400, long),
    lat = ifelse(region == "Kenya", -1.286389, lat),
    long = ifelse(region == "Lesotho", 28.2420, long),
    lat = ifelse(region == "Lesotho", -29.5800, lat),
    long = ifelse(region == "Liberia", -9.4295, long),
    lat = ifelse(region == "Liberia", 6.4281, lat),
    long = ifelse(region == "Libya", 17.2283, long),
    lat = ifelse(region == "Libya", 26.3351, lat),
    long = ifelse(region == "Madagascar", 46.8691, long),
    lat = ifelse(region == "Madagascar", -18.7669, lat),
    long = ifelse(region == "Malawi", 34.3015, long),
    lat = ifelse(region == "Malawi", -13.2543, lat),
    long = ifelse(region == "Mali", -3.9962, long),
    lat = ifelse(region == "Mali", 17.5707, lat),
    long = ifelse(region == "Mauritania", -10.9408, long),
    lat = ifelse(region == "Mauritania", 20.3484, lat),
    long = ifelse(region == "Mauritius", 57.5522, long),
    lat = ifelse(region == "Mauritius", -20.3484, lat),
    long = ifelse(region == "Morocco", -7.0926, long),
    lat = ifelse(region == "Morocco", 31.7917, lat),
    long = ifelse(region == "Mozambique", 35.5296, long),
    lat = ifelse(region == "Mozambique", -18.6657, lat),
    long = ifelse(region == "Namibia", 17.0818, long),
    lat = ifelse(region == "Namibia", -22.5609, lat),
    long = ifelse(region == "Niger", 8.2245, long),
    lat = ifelse(region == "Niger", 17.6078, lat),
    long = ifelse(region == "Nigeria", 8.6753, long),
    lat = ifelse(region == "Nigeria", 9.0820, lat),
    long = ifelse(region == "Republic of Congo", 15.8277, long),
    lat = ifelse(region == "Republic of Congo", -0.2280, lat),
    long = ifelse(region == "Rwanda", 29.8739, long),
    lat = ifelse(region == "Rwanda", -1.9403, lat),
    long = ifelse(region == "Sao Tome and Principe", 6.6131, long),
    lat = ifelse(region == "Sao Tome and Principe", 0.1864, lat),
    long = ifelse(region == "Senegal", -14.4524, long),
    lat = ifelse(region == "Senegal", 14.4974, lat),
    long = ifelse(region == "Seychelles", 55.4915, long),
    lat = ifelse(region == "Seychelles", -4.6796, lat),
    long = ifelse(region == "Sierra Leone", -11.7799, long),
    lat = ifelse(region == "Sierra Leone", 8.4606, lat),
    long = ifelse(region == "Somalia", 46.8253, long),
    lat = ifelse(region == "Somalia", 5.1521, lat),
    long = ifelse(region == "South Africa", 25.0839, long),
    lat = ifelse(region == "South Africa", -29.0000, lat),
    long = ifelse(region == "South Sudan", 31.3872, long),
    lat = ifelse(region == "South Sudan", 6.8770, lat),
    long = ifelse(region == "Sudan", 30.8025, long),
    lat = ifelse(region == "Sudan", 12.8628, lat),
    long = ifelse(region == "Tanzania", 34.8888, long),
    lat = ifelse(region == "Tanzania", -6.369028, lat),
    long = ifelse(region == "Togo", 0.8248, long),
    lat = ifelse(region == "Togo", 8.6195, lat),
    long = ifelse(region == "Tunisia", 9.5375, long),
    lat = ifelse(region == "Tunisia", 33.8869, lat),
    long = ifelse(region == "Uganda", 32.2903, long),
    lat = ifelse(region == "Uganda", 1.3733, lat),
    long = ifelse(region == "Western Sahara", -13.1215, long),
    lat = ifelse(region == "Western Sahara", 24.2155, lat),
    long = ifelse(region == "Zambia", 27.8493, long),
    lat = ifelse(region == "Zambia", -13.1339, lat),
    long = ifelse(region == "Zimbabwe", 29.1549, long),
    lat = ifelse(region == "Zimbabwe", -19.0154, lat)
  )



# Create a geom_polygon plot using ggplot2
print(ggplot(africa_map) +
  geom_polygon(aes(long, lat, group = group, fill = growth_rate)) +
  coord_quickmap() +
  scale_fill_viridis_c(option = "plasma") +

  # Add labels to the plot
  labs(fill = "Growth %") +
  ggtitle("Growth Rate In Africa (2023)") +

  # Use geom_label_repel for Africa labels
  geom_label_repel(
    data = label_data, aes(x = long, y = lat, label = region),
    size = 6, max.overlaps = 8,
    box.padding = .5, point.padding = .5
  ) +

  # Use map theme from ggthemes library
  theme_map())

# Save the plot as a file
ggsave("africa_plot.jpg", dpi = 300)
