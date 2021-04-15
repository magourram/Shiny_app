# Shiny_app: Basic EDA and Analisys on the Wu Tang Clan music group

![Wu_logo](https://user-images.githubusercontent.com/82286927/114915557-fcf6aa80-9e23-11eb-84f1-2872ef1daf1f.jpg)


This Shiny Apps some insights about one of the most iconic rap groups of all time: the Wu Tang Clan.
Using the `spotifyr` library by the user **charlie86** (link to his work: http://www.rcharlie.com/spotifyr). This library allows to pull different features about artists, tracks, album, and so on. By automatically batching API requests, it allows you to enter an artist’s name and retrieve their entire discography.

This library can also be used to pull informations about personal accounts, provided an ID and a 'secret key' from a Spotify Developer user.

## Data

Using Spotify's own sound parameters, I accessed the audio features data of the nine original founder of the Wu Tang Clan. I provided some basical EDA per artist, considering three different parameters. 

## Analysis

Considered the groups' history, the last tab represent a scatterplot of all the different track provided by this artists singularly. The scatterplot is meant to represent a correlation between the spotify parameters and the "personal touch" of every single Wu Tang Clan member.

## Run the application

shiny command:
```
shiny::runGitHub("Shiny_app", "magourram", ref="main")
```


### About

*Spotify links*:

Wu Tang Clan : https://open.spotify.com/artist/34EP7KEpOjXcM2TCat1ISk?si=ezxaqveKRUC_gQhTSnKoOA

The RZA : https://open.spotify.com/artist/4iCwCMnqsNZ6atvRiADgtn?si=n5B3rNtUTGuhVToi843dVQ

The GZA : https://open.spotify.com/artist/6ns6XAOsw4B0nDUIovAOUO?si=MUk9_PLJSWuOfZjFzc1QQg

Ol' Dirty Bastard :  https://open.spotify.com/artist/50NoVNy9GU1lCrDV8iGpyu?si=l88XjvDEQBCtt0vjdHw4swù

Method Man : https://open.spotify.com/artist/4VmEWwd8y9MCLwexFMdpwt?si=850x5mG9RwCsrbkc5A2eBg

Inspectah Deck : https://open.spotify.com/artist/4OBbOrkD4geIjOLrICN3wO?si=TOjgvrl_TYO9oXesLpErFA

Raekwon the Chef : https://open.spotify.com/artist/2yQf6b8hxahZaT5dHlWaB1?si=mwEwx3hZT_6dhbApyG99KA

Ghostface Killah : https://open.spotify.com/artist/6FD0unjzGQhX3b6eMccMJe?si=YQMolveVQ-KLEelZmt2m7g

U-God : https://open.spotify.com/artist/0G070wUUUBptmqGEKAAUVx?si=SIMClOcfS1GVth3yFDFWUQ

Masta Killa : https://open.spotify.com/artist/0ME1RawvWt3qOJnYnxVqeh?si=TubUN40mQu-rElMWxJfsqg



*Hulu link*: https://www.hulu.com/series/wu-tang-an-american-saga-8e4e1643-1254-4d6e-a567-d2c62f7b3e00



*Wikipedia link*: https://en.wikipedia.org/wiki/Wu-Tang_Clan
