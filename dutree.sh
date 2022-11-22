#!/bin/bash
function dirsize(){
    du -sh $1 | cut -f 1
}

function mytree() { 
    #Prend un répertoire en paramètre et affiche les répertoires qu'il contient sous forme d'un arbre
    oldIFS=$IFS
    IFS=$'\n'
    if [[ -z $1 ]]
    then
    home="/home/etud"
    echo -ne "$home\n"
    listesansprofondeur $home 1
    else
    if [[ -d $1 ]] # Test si le paramètre est un dossier
    then
        if [[ $(find $1 | wc -l) = 0 ]] # Test si le dossier est vide
        then 
            echo "le dossier $1 est vide"
        else
            echo -ne "$1\t"
            dirsize $1
        
            if [[ -z $2 ]]
            then
                listesansprofondeur $1 1 $1
            else
                #ici on gere la profondeur maximale avant d'appeler la fonction listeavecprofondeur
                #je recupère ma profondeur maximale grace à cette commande
                local prodmax=$(find $1 . -type d -printf '%d\n' | sort -rn | head -1)
                #j'incremente d'une unité parce que il comptabilise pas le dossier courant
                ((prodmax=prodmax+1))
                #je teste avec la profondeur donnee en paramètre
                #si c'est inférieure ou égale à la profondeur donnee on incremente 
                if [[ $2 -le $prodmax ]]
                then
                listeavecprofondeur $1 1 $2 $1
                else
                echo -ne "Erreur, la profondeur max est $prodmax alors que celle voulue est de $2\n"  
                fi
            fi
            
        fi
    else 
        echo -ne "Le paramètre n'est pas un dossier valide\n"
    fi
    fi
    IFS=$oldIFS
    exit 1
}


function listesansprofondeur() { 
    # Affiche les éléments contenu dans le répertoire passé en paramètre
    # ($1) en fonction d'une profondeur donnée ($2)
    if [[ -d $1 ]]
    then
        local files=$(find $1 -mindepth 1 -maxdepth 1)
        for file in $files
        do
            #l'objectif de $2 c'est d'afficher le |-- 
            # avant l'appel le $2 est a 1 et a chaque apple il s'incrementes
            for i in $(seq 1 $2)
            do
                echo -ne "|--"
            done
            local fileName=$(basename $file)
            echo -ne "$fileName\t"
            #afficher la taille
            dirsize $file
            #si c'est un dossier appel recursif
            if [[ -d $file ]]
            then
                listesansprofondeur $file $(($2 + 1)) $chemin
            fi
        done
    else
        echo -ne "\nErreur : echec d'ouverture de fichier\n"
    fi
}


function listeavecprofondeur(){
    if [[ $2 -le $3 ]]
    then
    if [[ -d $1  ]]
    then
        local files=$(find $1 -mindepth 1 -maxdepth 1)
        for file in $files
        do
            for i in $(seq 1 $2)
            do
                echo -ne "|-- "
            done
            local fileName=$(basename $file)
            echo -ne "$fileName\t"
            dirsize $file
            
            if [[ -d $file ]]
            then
                listeavecprofondeur $file $(($2 + 1)) $3
            fi
        done
    else
        echo -ne "\nErreur : echec d'ouverture de dossier"
    fi
    fi
}



mytree $1 $2
