#!/bin/bash

state=$(curl 10.202.255.253/status --silent|jq .meters[0].power)

echo $state

INT=$(zenity --entry --text "Votre ampoule consomme : $state Entrez l'état souhaité (on - off) :")
curl 10.202.255.253/relay/0?turn=$INT --silent|jq
