
# PRACTICA
# Nos creamos este script en /tmp <---- infinito.sh(añdir permisos de ejecucion y lanzarlo)
# Consultar en otra consola el valor de su bondad, prioridad y estado (opciones de ps: nice,pri,stat)
# Mandar señal con kill de tipo SIGUSR1 al pid del script ¿que hace el script?
# Suspender el script con CTRL + Z y mandarlo a segundo plano para que continue su ejecucion (comprobarlo con jobs)
# Aumentar su prioridad en 2 puntos con renice, volverlo a comprobar con comando ps
# Matar el script

INFINITO.SH # script con un bucle infinito
#!/bin/bash
clear
cont=0
while true
do
trap 'echo "...señal recibida"' SIGUSR1

if [ $cont -le 10 ]
then
  echo -n "."
else
  clear
  cont=0
fi
cont=`expr $cont + 1`
sleep 1s
done

#! /bin/bash
clear

app="infinito.sh"
echo "MENU"
echo "1) Consultar en otra consola el valor de su bondad, prioridad y estado (opciones de ps: nice,pri,stat)"
echo "2) Mandar señal con kill de tipo SIGUSR1 al pid del script ¿que hace el script? "
echo "3) Suspender el script con CTRL + Z y mandarlo a segundo plano para que continue su ejecucion (comprobarlo con jobs)"
echo "4) Aumentar su prioridad en 2 puntos con renice, volverlo a comprobar con comando ps "
echo "5) Matar el script "
read -p "Dime una opcion: " opcion
case $opcion in
    1)
       ps -C $app -o nice,pri,stat
    ;;

2) 
    ps -C $app -o pid,cmd
    read -p "escribe el pid: " pid
    kill -s SIGUSR1 $pid
;;

3)

;;

4)
    renice -n +2 $app
    ps -C $app -o pid,pri,cmd,stat
;;

5)
    ps -C $app -o pid,cmd
    read -p "Excribe la pid: " pid
    kill -s SIGTERM $pid
;;

*)
    echo "Salimos del Script"
;;
esac

# MI PRACTICA
#!/bin/bash
clear

N_ALMOHADILLA='\e[1;32m'
N_AZUL='\e[1;34m'
N_OPCION='\e[1;96m'
N_ROJO='\e[1;31m'
RESET='\e[0m'

echo -e "\t\t\t $N_ALMOHADILLA ################################################################################ $RESET"
echo -e "\t\t\t $N_ALMOHADILLA ################################### $RESET $N_AZUL PROCESOS $RESET $N_ALMOHADILLA ################################### $RESET"
echo -e "\t\t\t $N_ALMOHADILLA ################################################################################ $RESET"
echo -e "\t\t\t $N_OPCION 1) Ejecucion de la aplicacion $RESET"
echo -e "\t\t\t $N_OPCION 2) Mirar sus procesos de todas las formas posibles $RESET "
echo -e "\t\t\t $N_OPCION 3) Cambiar la bondad del proceso $RESET"
echo -e "\t\t\t $N_OPCION 4) Mata el proceso $RESET"
echo -e "\t\t\t $N_ROJO   *) SALIR DEL SCRIPT $RESET"

read -p "Dime la aplicacion a consultar: " app
read -p "Dime una opcion: " opcion

case $opcion in
1)
    $app &
;;
2)
    ps -C $app -o pid,cmd,nice,pri
;;
3)
    ps -C $app -o pid,nice
    read -p "Dime el numero del pid: " pid
    renice -n +15 -p $pid
;;
4)
    echo "Vemos todos las señales de kill, que podemos ejecutar"
    kill -l
    ps -C $app -o pid
    read -p "Dime el numero del pid: " pid
    sudo kill -s SIGTERM $pid
;;
*)
    echo "Salimos del Script"
    exit 0
;;
esac
