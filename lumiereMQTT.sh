#!/bin/bash


Amp1=$(cat Ampoules|grep Amp1| awk '{print $2}')
Amp2=$(cat Ampoules|grep Amp2| awk '{print $2}')

state1=$(mosquitto_sub -h 10.202.0.107 -p 1883 -t "shellies/shellyplug-s-6A6534/relay/0" --retained-only -C 1)
state2=$(mosquitto_sub -h 10.202.0.65 -p 1883 -t "shellies/shellyplug-s-6A64DB/relay/0" --retained-only -C 1)
echo $state1
echo $state2


Ampoule=$(zenity --entry --text "Quelle(s) ampoule(s) souhaitez vous utiliser ? (1 / 2 / all)")


if [ $Ampoule = 1 ]
then
	INT=$(zenity --entry --text "Votre ampoule est : $state1 Entrez l'état souhaité (on - off) :")
	mosquitto_pub -h 10.202.0.107 -p 1883 -t "shellies/shellyplug-s-6A6534/relay/0/command" -m $INT
fi




if [ $Ampoule = 2 ]
then
	INT=$(zenity --entry --text "Votre ampoule est : $state2 Entrez l'état souhaité (on - off) :")
	mosquitto_pub -h 10.202.0.65 -p 1883 -t "shellies/shellyplug-s-6A64DB/relay/0/command" -m $INT
fi




if [ $Ampoule = all ]
then

	INT=$(zenity --forms --title="Lumières" --text="Votre ampoule 1 est : $state1 et votre ampoule 2 est : $state2" --add-entry="Ampoule 1 (on / off)" --add-entry="Ampoule 2 (on / off)")
	INT1=$(echo $INT|cut -d "|" -f 1)
	INT2=$(echo $INT|cut -d "|" -f 2)
	mosquitto_pub -h 10.202.0.107 -p 1883 -t "shellies/shellyplug-s-6A6534/relay/0/command" -m $INT1
	mosquitto_pub -h 10.202.0.65 -p 1883 -t "shellies/shellyplug-s-6A64DB/relay/0/command" -m $INT2
fi





