#' Función que realiza el scrap a partir de un archivo json 
#' de un chat de Telegram, mientras pueda ser exportable
#' mediante la aplicación de desktop de Telegram.
#' 
#' @param name - string: nombre del archivo, puesto en la carpeta data.
#' 
#' @returns data.frame: los datos después del proceso de lectura.
scrapT <- function(name){
  # Importa
  ruta <- paste("data/", name, ".json", sep = '')
  telegram <- fromJSON(ruta)
  
  # En dataframe
  telegram <- as.data.frame(telegram$messages)
  
  # Cambios de forma
  telegram <- telegram[telegram$type == "message",]
  
  telegram$text[!is.na(telegram$photo)] <- 'imagen omitida'
  telegram$text[!is.na(telegram$file)] <- 'documento omitido'
  telegram$media_type[telegram$media_type == "voice_message"] <- 'audio omitido'
  telegram$media_type[telegram$media_type == "sticker"] <- 'sticker omitido'
  telegram$text[!is.na(telegram$media_type)] <- telegram$media_type[!is.na(telegram$media_type)]
  telegram$edited[!is.na(telegram$edited)] <- TRUE
  telegram$text[!is.na(telegram$poll$question)] <- telegram$poll$question[!is.na(telegram$poll$question)]
  # Seleccionar las que aportan
  # ATENCIÓN: Se removió el reply column puesto que whatsapp no lo tiene
  telegram <- telegram %>% select(date, from, text, edited)
  
  # Formatos
  telegram <- telegram %>% separate(date, c('dia','hora'), sep = 'T')
  telegram$dia <- ymd(telegram$dia)
  telegram$hora <- as.double(hms(telegram$hora))
  colnames(telegram) <- c("dia", "hora", "autor", "mensaje", "editado")
  telegram$editado <- ifelse(is.na(telegram$editado), FALSE, TRUE)
  row.names(telegram) <- NULL
  
  # listas <- sapply(telegram$mensaje, function (x) typeof(x) == "list")
  # telegram$mensaje[listas] <- sapply(telegram$mensaje[lista],
  #                                    function(x) as.data.frame(x) %>%
  #                                      select (-type))
  indicador <- sapply(telegram$mensaje, function(x) typeof(x) == "list")
  if(sum(indicador) != 0){
    listas <- sapply(telegram$mensaje[indicador], function(x) data.frame(x))
    listas <- sapply(listas, function(x) x %>% select(-grep("type", colnames(x))))
    listas <- data.frame(sapply(listas, function(x) paste(x, collapse = "")))
    for (i in 1:length(listas[[1]])){
      telegram$mensaje[indicador][[i]] <- listas[i,]
    }
  }
  return(telegram)
}