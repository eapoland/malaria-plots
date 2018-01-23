# DEPENDENCIES
library(tidyverse)
library(data.table)

# SOURCING
malaria_deaths <- read.csv(paste(dirname(sys.frame(1)$ofile), "/malaria-deaths-by-region.csv", sep=''))

# WRANGLING
colnames(malaria_deaths) <- colnames(malaria_deaths) %>% tolower()
malaria_deaths <- malaria_deaths %>% 
  rename(zgony = malaria.deaths..ihme..2017...deaths.) %>% 
  rename(rok = year) %>% 
  rename(region = entity) %>% 
  select(region, rok, zgony)

# INSPECTION  R
glimpse(malaria_deaths)
summary(malaria_deaths$zgony)

# VISUALISATION
plot <- malaria_deaths %>%
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
  theme_minimal() + scale_fill_brewer(palette = "Accent", direction = 1) +
  theme(
    plot.title = element_text(family = "Verdana", size = 14),
    legend.position = "none",
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank()
  )

print(plot)
