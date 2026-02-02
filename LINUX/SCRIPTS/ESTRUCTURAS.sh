#!/bin/bash
clear

while true
do
echo "MENU"
echo "1) ARRAY DE NOMBRES"
echo "2) FOR DE DIRECTORIO"
echo "3) FOR NORMAL"
echo "4) FOR CON PATRON"
echo "5) BUCLE SOBRE ARCHIVO"
echo "6) CONDICIONAL UNO"

echo "*) SALIR DEL MENU"
read -p "Dime una opcion: " opcion
case $opcion in
1)
    nombres=("Juan" "Pedro" "Maria" "Irina" "Cristina")
    for i in ${nombres[*]}
    do
        echo "Mi nombres es: $i"
    done
;;

2)
    for i in /etc/*
    do
        echo "Contenido es: $i"
    done
;;

3)
    for i in {1..5}
    do
        echo "Este es el numero: $i"
    done
;;

4)

    for i in {0..10..3}
    do  
        echo "Este es el numero: $i"
    done
;;
5)
    while read linea
    do
        echo $linea
    done < Fichero_v.txt
;;

6)
    if [ -d /home/gonzalo/Documentos ]
    then
        echo "Existe el directorio"
    elif [ -f Fichero_v.txt ]
    then    
        echo "existe el fichero"
    elif [ -z $palabra ]
    then
        echo "No has escrito nada"
    elif [ 1 -eq 1 ]
    then
        echo "Son iguales"
    elif [ 1 -lt 5 ]
    then
        echo "El primer numero es menor"
    elif [ 1 -gt 5 ]
    then
        echo "El segundo numero es mayor"
    elif [ 1 != 5 ]
    then
        echo "El primero numero es distinto del segundo"
    elif id gonzalo
    then
        echo "Este usuario existe"
    fi
;;

*)
        echo "SALIMOS DEL MENU"
        exit 0
;;
    esac
done
