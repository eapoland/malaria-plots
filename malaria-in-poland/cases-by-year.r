# DEPENDENCIES
library(tidyverse)
library(data.table)

# SOURCING
malaria_cases <- read.csv(paste(dirname(sys.frame(1)$ofile), "/cases-by-year.csv", sep=''))

# INSPECTION  R
glimpse(malaria_cases)
summary(malaria_cases$cases)

plot <- malaria_cases %>%
  ggplot() +
  geom_bar(aes(x=year, y=cases), stat="identity") +

  labs(
    title = "Przypadki malarii/zimnicy w Polsce",
    x = "Rok",
    y = "Zachorowania",
    caption = "Oparto o Epidemiological situation of malaria in Poland--past, present and future"
  )

print(plot)
