# Librerías ---------------------------------------------------------------

pacman::p_load(
  readr, 
  jsonlite, 
  lubridate,
  tidyverse,
  reticulate,
  wordcloud,
  RColorBrewer,
  tidytext,
  syuzhet,
  parallel
)

# Scripts de R ------------------------------------------------------------

source("cod/r/scrapW.R")
source("cod/r/scrapT.R")