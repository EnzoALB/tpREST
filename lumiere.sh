#!/bin/bash

Ampoule=$(zenity --entry --text "Quelle(s) ampoule(s) souhaitez vous utiliser ? (1 / 2 / all)")

Amp1=$(cat Ampoules|grep Amp1| awk '{print $2}')
Amp2=$(cat Ampoules|grep Amp2| awk '{print $2}')

if [ $Ampoule = 1 ]
then

	state=$(curl $Amp1/status --silent|jq .meters[0].power)
	INT=$(zenity --entry --text "Votre ampoule consomme : $state Entrez l'état souhaité (on - off) :")
	curl $Amp1/relay/0?turn=$INT --silent|jq
fi

if [ $Ampoule = 2 ]
then

	state=$(curl $Amp2/status --silent|jq .meters[0].power)
	INT=$(zenity --entry --text "Votre ampoule consomme : $state Entrez l'état souhaité (on - off) :")
	curl $Amp2/relay/0?turn=$INT --silent|jq
fi

if [ $Ampoule = all ]
then

	state1=$(curl $Amp1/status --silent|jq .meters[0].power)
	state2=$(curl $Amp2/status --silent|jq .meters[0].power)
	INT=$(zenity --entry --text "Votre ampoule 1 consomme : $state1 et votre ampoule 2 consomme : $state2 Entrez l'état souhaité (on - off) :")
	curl $Amp1/relay/0?turn=$INT --silent|jq
	curl $Amp2/relay/0?turn=$INT --silent|jq
fi





