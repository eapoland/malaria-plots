# DEPENDENCIES
library(tidyverse)
library(data.table)

# SOURCING
malaria_deaths <- read.csv(paste(dirname(sys.frame(1)$ofile), "/malaria-death-rates.csv", sep=''))

# WRANGLING
colnames(malaria_deaths) <- colnames(malaria_deaths) %>% tolower()
malaria_deaths <- malaria_deaths %>%
  rename(deaths = deaths...malaria...sex..both...age..age.standardized..rate...per.100.000.people.) %>%
  rename(country = entity)

# INSPECTION  R
glimpse(malaria_deaths)
summary(malaria_deaths$deaths)

# RENAME COUNTRIES
malaria_deaths <- malaria_deaths %>% mutate(country = recode(country,
  'Congo' = 'Republic of Congo',
  'Democratic Republic of Congo' = 'Democratic Republic of the Congo',
  'United Kingdom' = 'UK',
  'United States' = 'USA',
  'Trinidad and Tobago' = 'Trinidad',
  `Cote d'Ivoire` = 'Ivory Coast'
  ))

# MAP
map.world <- map_data('world')

map.malaria <- left_join( map.world, malaria_deaths, by = c('region' = 'country'))

plot <- ggplot(map.malaria, aes( x = long, y = lat, group = group )) +
    geom_polygon(aes(fill = deaths))

print(plot)