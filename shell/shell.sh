#!/bin/bash

     #1ere fonction 
function comp()
{
 tar -cjvf  file.tar.bz2 /home/$USER
echo " fin compression"
 
}
     #2eme fonction 
function res()
{
 #foremost -w -i /home/$USER -o ~/recupere
 tar -xjvf file.tar.bz2 
}
     #8 fonction version
function ver()
{
uname -r -n
 
}
     #fonction help
function hel()
{
 gedit /etc/info.txt #pour l'editer il faut 1- cd /etc puis sudo gedit info.txt
}


     #fonction sauvgarder
 
function sauv() #sauvgarder dans le fichier $1 passé en parametres
{
 ls > "$1"
 #gedit "$1" 
 echo "sauvgardé avec succés!"

}
function sauvG() #pour sauv dans le menu graphique 
{
 ls > ma.txt
 #gedit ma.txt 
 echo "sauvgardé avec succés!"
}


      #afficher

function aff()
{
 #"$1" = "-o" 
if [ -e "$1" ]; #voir si le fichier existe 
then 
 sauv "$1" #appel à la fonction sauv
 gedit  "$1"
 echo "Fonction afficher opérée avec succés! "
else
  echo " le fichier n'exsite pas"
fi
}

function affG() #affichage pour le menu graphique 
{
 
if [ -e ma.txt ];
then 
ls > ma.txt # redirection des informations issues de lsblk dans le fichier1.txt
 gedit  ma.txt
echo "Fonction afficher opérée avec succés! "
else
  echo " le fichier n'exsite pas"
fi
}

#MOT CLÉ
function mot() 
{
if [ "$1" = "-o" ] #option doit etre suivie de l'option -o
then   
 grep "$4" "$2"
echo "Fonction mot clé opérée avec succés! "
else
  echo " cette option doit etre suivie de l'option -o"
fi  
}

function motG() #mot clé pour le menu graphique
{
 grep "ma" ma.txt
echo "Fonction mot clé opérée avec succés! "
}

#quitter yad
function ferme_yad () 
{ 
echo "bye bye" ; 
PidYad=$(pgrep yad); 
kill -s SIGUSR1 "$PidYad"; #fermer
}
#menu graphique
function menug()
{
#fenetre principale
yad  --title="menu graphique ." --window-icon="yad" --width="200" --height="200" --center --text="<span font_desc='Ubuntu Mono Bold Italic 12' foreground='#14006c'>Bienvenue.</span>" --text-align="center"

#commande comp
export -f comp
#commande res
export -f res
#help
export -f hel
#version
export -f ver
#sauv
export -f sauvG
#afficher
export -f affG
#MOT CLÉ
export -f motG
#quitter
export -f ferme_yad

yad --form --field "commande comp:btn" "bash -c comp" --field "commande res:btn" "bash -c res" --field "commande ver:btn" "bash -c ver" --field "help:btn" "bash -c  hel " --field "sauvgarder:btn" "bash -c sauvG " --field "afficher:btn" "bash -c affG " --field "mot clé:btn" "bash -c motG " --field "quiter:btn" "bash -c ferme_yad " 

echo "$?"
}
#menu textuel
function menut()
{
choix=-1
until [ "$choix" == "0" ]
do
echo "1- compresser "
echo "2- restorer"
echo "3- help "
echo "4- sauvgarder"
echo "5- version"
echo "6- afficher "
echo "7- mot clé "
echo "0- quitter "

read choix
case $choix in 

1)comp 
;;
2)res
;;
3)hel
;;
4)sauv ma.txt
;;
5)ver
;;
6)aff ma.txt
;;
7)mot -o ma.txt -- "ma"
;;
0) break;
;;
esac
done
}

#menuf
options="$(getopt -o crhvgms:o:f:-l  help  --name "$0" -- "$@")"

eval set -- "$options"

while true
do
case "$1" in
-c)comp
shift
;;
-r)res
shift
break
;;
-h|--help)hel
shift
;;
-m)menut
shift
;;
-g)menug
shift
;;
-s)sauv $2
shift
break
;;
-v)ver
shift
;;
-o)aff $2
shift
break
;;
-f)mot $2 $3 $4 $5 $6
shift
#break
;;
(--) 
echo "erreur entrez un argument SVP"
shift; break;;
(-*) 
 shift; 
break;;
(*) 
break;;

esac
shift
done 
