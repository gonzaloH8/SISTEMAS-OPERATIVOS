#! /bin/bash 
# 1 situaros en directorio "Musica" del perfil de tu usuario y ver contenido
# 2 Crearos dentro del mismo estos directorios
# Musica
#    heavy/instrumental
#    hardcore/trash-metal
#            death-metal
#    dance
#    pop
#    trap
#    regatton
# - 3 ver con tree si todo esta creado ok
# - 4 borrar directorios trap y regatton
# - 5 renombrar directorio pop a Happy-pop 
# - 6 meter algun fichero en directorio Happy-Pop y copiar su contenido en /tmp/Happy-Pop'
clear

echo "Dime una opcion"
read opcion

case $opcion in
1) 
    mkdir /tmp/Musica
;;

2)
    mkdir -p /tmp/Musica/heavy/Instrumental | mkdir -p /tmp/Musica/hardcore/trash-metal | mkdir -p /tmp/Musica/hardcore/death-metal | mkdir /tmp/Musica/pop | mkdir /tmp/Musica/trap | mkdir /tmp/Musica/regatton
;;

3)
    tree /tmp/Musica
;;

4)
    rmdir /tmp/Musica/trap | rmdir /tmp/Musica/regatton
;;
5)
    mv /tmp/Musica/pop /tmp/Musica/Happy-pop 
;;

6)
    echo "Hola Mundo" > /tmp/Musica/Happy-pop/archivo1.txt 
    cp -r /tmp/Musica/Happy-pop/* /tmp/Happy-pop
;;

7)
    rm -rf /tmp/Musica
    echo "Borramos el directorio Musica y su contenido, salimos del script"
    exit 0
;;
esac
