# Librerías ---------------------------------------------------------------

pacman::p_load(
  readr, 
  jsonlite, 
  lubridate,
  tidyverse,
  reticulate
)

# Scripts de R ------------------------------------------------------------

source("cod/r/scrapW.R")
source("cod/r/scrapT.R")

# Módulos de Python -------------------------------------------------------

source_python("cod/python/setup.py")
source_python("cod/python/ProcesadorTexto.py")
