library(shiny)
library(shinythemes)
library(shinyWidgets)
library(spotifyr)
library(tidyverse)
library(ggplot2)
library(ggridges)
library(plyr)


#Authentication & Access, Import data, Remove Useless columns

id <- '48775b8158da4d368a9ea6bc2a6ddfec'
secret <- 'c9dd35a7e55f4416a4b3915439256fab'
Sys.setenv(SPOTIFY_CLIENT_ID = id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)

access_token <- get_spotify_access_token()

#Enter the 36 chambers 

methodman <- get_artist_audio_features(artist = 'Method Man')
rza <- get_artist_audio_features(artist = 'RZA')
gza <- get_artist_audio_features(artist = 'GZA')
odb <- get_artist_audio_features(artist = 'ODB')
gfk <- get_artist_audio_features(artist = 'Ghostface Killah')
raekwon <- get_artist_audio_features(artist = 'Raekwon the Chef')
ugod <- get_artist_audio_features(artist = 'U-God')
deck <- get_artist_audio_features(artist = 'Inspectah Deck')
masta <- get_artist_audio_features(artist = 'Masta Killa')

#Creating set and cleaning data

data <- rbind.fill(methodman,rza, gza, odb, gfk, raekwon, ugod, deck, masta)
rm(methodman,rza, gza, odb, gfk, raekwon, ugod, deck, masta)
data <- data[, c(1, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 30, 36)]
duplicated(data$track_name)
data <- distinct(data)

#Remove track names and select only albums
#ind <- which(duplicated(data[c('artist_name', 'album_name')]),)
#data_new <- data[!duplicated(data[c('artist_name', 'album_name')]),]
#data_new <- data_new[, c(1, 14)]