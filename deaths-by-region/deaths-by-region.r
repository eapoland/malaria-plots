# DEPENDENCIES
library(tidyverse)
library(data.table)

# SOURCING
malaria_deaths <- read.csv("./malaria-deaths-by-region.csv")

# WRANGLING
colnames(malaria_deaths) <- colnames(malaria_deaths) %>% tolower()
malaria_deaths <- malaria_deaths %>% 
  rename(zgony = malaria.deaths..deaths.) %>% 
  rename(rok = year) %>% 
  rename(region = entity) %>% 
  select(region, rok, zgony)

# INSPECTION  
glimpse(malaria_deaths)
summary(dt.malaria$zgony)

# VISUALISATION
malaria_deaths %>%
  filter(zgony > 10000) %>%
  ggplot() + geom_area(aes(rok, zgony, fill = region),
                       alpha = .9,
                       position = "stack") +
  facet_wrap( ~ region) +
  labs(
    title = "Żniwo malarii",
    x = "Lata",
    y = "Zgony",
    caption = "Oparto o ourworldindata.org/malaria CC BY-SA"
  ) +
  theme_minimal() + scale_fill_brewer(palette = "Blues", direction = 1) +
  theme(
    plot.title = element_text(family = "Verdana", size = 14),
    legend.position = "none",
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank()
  )
