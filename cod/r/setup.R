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
  parallel,
  dbscan,
  mclust,
  kohonen,
  pdfCluster,
  kernlab,
  teigen,
  meanShiftR,
  cluster,
  clusterCrit,
  ggalluvial
)

# Scripts de R ------------------------------------------------------------

source("cod/r/scrapW.R")
source("cod/r/scrapT.R")