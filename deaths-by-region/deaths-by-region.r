# DEPENDENCIES
library(tidyverse)
library(data.table)

# SOURCING
malaria_deaths <- read.csv(paste(dirname(sys.frame(1)$ofile), "/malaria-deaths-by-region.csv", sep=''))

# WRANGLING
colnames(malaria_deaths) <- colnames(malaria_deaths) %>% tolower()
malaria_deaths <- malaria_deaths %>%
  rename(deaths = malaria.deaths..ihme..2017...deaths.) %>%
  rename(region = entity) %>%
  select(region, year, deaths)

# INSPECTION  R
glimpse(malaria_deaths)
summary(malaria_deaths$deaths)

# VISUALISATION
plot <- malaria_deaths %>%
  filter(deaths > 6000) %>%
  ggplot() + geom_area(aes(year, deaths, fill = region),
                       alpha = .9,
                       position = "stack") +
  labs(
    title = "Żniwo malarii",
    x = "Lata",
    y = "Zgony",
    caption = "Oparto o ourworldindata.org/malaria CC BY-SA"
  ) +
  theme_minimal() +
  scale_fill_brewer(palette = "Accent", direction = 1) +
  theme(
    plot.title = element_text(family = "Verdana", size = 14),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank()
  )

print(plot)
