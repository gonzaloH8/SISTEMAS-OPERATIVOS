#!/bin/bash
# PRACTICA
# ALTA USUARIOS
# pedir por teclado el nombre del usuario a crear: ====> comprobar q no esta vacia, si esta vacio mostrar mensaje de error y salir
# pedir la nueva contaseña del usuario ===> no puede estar en blanco
# Repetir la nueva contraseña del usuario ====> no puede estar en blanco y debe coincidir con valor de arriba
# SI COINCIDEN poner esta contraseña a la cuenta ===> usando el comando chpasswd
# Pedir los comentarios a poner a la cuenta
# pedir la shell ===> si esta vacio, se pone por defecto /bin/bash
# con esos datos, crear la cuenta comprobarlo en el fichero /etc/passwd (buscando la linea con grep)
# 2º) Borrar usuario pedir usuario a borrar===> comprobar qe no esta vacio 
# y que el usuario existe Pedir si realmente estas seguro de querer borrarlo: ....Si o NO Si es afirmativo, borrar la cuenta
clear

read -p "Dime el nombre de usuario a crear: " user

if [ -z "$user" ]
then
    echo "No has escrito nada"
    exit 0
fi

# minúsculas, mayúsculas, números y caracteres especiales
# 11449X_azul

read -p "Dime la password para el $user a usar: " pass
if [ -z "$pass" ]
then    
    echo "La password no puede estar en blanco"
    exit 0
fi

read -p "Repite la password, para su verificacion: " passw
if [ -z "$passw" ]
then
    echo "La password no puede estar en blanco"
    exit 0
elif [ $pass != "$passw" ]
then
    echo "La password no coincide"
    exit 0
fi

read -p "Escribe los comentarios: " comments
read -p "Introduce la SHELL del nuevo usuario: " shell
[ -z "$shell" ] && shell=/bin/bash

sudo useradd -c "$comments" -s "$shell" $user && echo "Usuario creado correctamente" # añadimos el user con lo comentarios y el directorio principal
echo "$user:$pass" | sudo chpasswd # aplicamos la password al usuario
grep -e "^$user:x:" /etc/passwd # busca el usuario creado

===================================================================================================================================
#!/bin/bash
clear
# SCRIPT DEL PROFESOR
#variables para definir colores en script
COLOR_BACKROJO_LETAMARILLO='\e[1;33;31m'
COLOR_ROJO='\e[31m'
COLOR_VERDE='\e[32m'
COLOR_AMARILLO='\e[33m'
COLOR_AZUL='\e[34m'
COLOR_MORADO='\e[35m'
COLOR_CYAN='\e[36m'

COLOR_RESET='\e[0m'

echo -e "\t\t\t $COLOR_BACKROJO_LETAMARILLO ############################## $COLOR_RESET"
echo -e "\t\t\t $COLOR_BACKROJO_LETAMARILLO ##     ALTA DE USUARIOS    ### $COLOR_RESET"
echo -e "\t\t\t $COLOR_BACKROJO_LETAMARILLO ############################## $COLOR_RESET"

echo -n -e "\t\tIntroduce el $COLOR_CYAN NOMBRE $COLOR_RESET del nuevo usuario..."; read nombre
if [ -z "$nombre" ]
then
    echo -e "\t\t\t...$COLOR_ROJO el nombre de la cuenta no puede estar vacio $COLOR_RESET ..."
    exit 0
fi

echo -n -e "\t\tIntroduce la $COLOR_CYAN PASSWORD $COLOR_RESET del nuevo usuario..."; read password
if [ -z "$password" ]
then
    echo -e "\t\t\t...$COLOR_ROJO la password de la cuenta no puede estar vacio $COLOR_RESET ..."
    exit 0
fi


echo -n -e "\t\tIntroduce de nuevo la $COLOR_AMARILLO PASSWORD $COLOR_RESET ..."; read repassword
if [ -z "$repassword" ]
then
    echo -e "\t\t\t...$COLOR_ROJO la password de la cuenta no puede estar vacio $COLOR_RESET ..."
    exit 0
elif [ "$password" != "$repassword" ]
then
    echo -e "\t\t\t...$COLOR_ROJO las passwords no coinciden $COLOR_RESET ..."
    exit 0

fi

echo -n -e "\t\tIntroduce los $COLOR_CYAN COMENTARIOS $COLOR_RESET del nuevo usuario..."; read comments
echo -n -e "\t\tIntroduce la $COLOR_CYAN SHELL $COLOR_RESET del nuevo usuario..."; read shell
[ -z "$shell" ] && shell=/bin/bash

useradd -c "$comments" -s "$shell" $nombre && echo -e "\n\n\t\t $COLOR_VERDE CUENTA CREADA CORRECTAMENTE... $COLOR_RESET"
echo "$nombre:$password" | chpasswd

#.....mostramos linea en fihcero /etc/passwd....
echo -e "\n\t\t linea en fichero $COLOR_AMARILLO /etc/passwd $COLOR_RESET"
grep -e "^$nombre:x:" /etc/passwd

==========================================================================================================================
#!/bin/bash
read -p "Introduzca el nombre del usuario (login) " usuario
existe=0
for aux in `cat /etc/passwd | cut .f1 -d":"`
do
  if [ "aux" == "$usuario" ]
  then
      existe=1
  fi
done

if [ $existe -eq 1 ]
then
    echo "El usuario existe en el sistema"
else
  echo "El usuario no existe"
fi

===================BUCLE WHILE============================================================================================================
#!/bin/bash
clear
read -p "Dime una opcion" opcion
case $opcion in
1)
    while [ true ]
    do
    read -p "Dime el nombre de usuario a crear: " user
    read -p "Dime la password a usar: " pass
    read -p "Repite la password para su verificacion: " passw
    if [[ -z "$user" || -z "$pass" || -z "$passw" ]]
    then
        echo "El usuario o el password o la rep.password estan vacias"
    elif [ "$pass" != "$passw" ]
    then
    echo "Las password no son iguales"
    else
        read -p "Escribe los comentarios: " comments
    read -p "Introduce la SHELL del nuevo usuario: " shell
    [ -z "$shell" ] && shell=/bin/bash

    sudo useradd -c "$comments" -s "$shell" $user && echo "Usuario creado correctamente"
    echo "$user:$pass" | sudo chpasswd
    grep -e "^$user:x:" /etc/passwd
    exit 0
    fi
    done
;;

2)
 read -p "Dime el usuario a buscar: " usuario
    if [ -z $usuario ]
    then
        echo "No has escrito nada"
    fi

    if id "$usuario"; 
    then
        echo "El usuario $usuario existe"
    fi

    echo "¿Procedemos a borrarlo?S/N: "; read res
    if [ "$res" = "S" ]
    then
        sudo userdel $usuario
        echo "El $usuario ha sido borrado"
        exit 0
    elif [ "$res" = "N" ]
    then
        echo "No ha sido borrado el $usuario"
    fi
    ;;
esac
