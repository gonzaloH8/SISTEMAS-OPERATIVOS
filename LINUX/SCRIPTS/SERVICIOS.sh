
#!/bin/bash
clear
opcion=0
while [ $opcion -ne 7 ]
do
echo -e "\nMENU"
echo "1) Muestra el fichero de configuracion"
echo "2) Muestra lo servicios"
echo "3) Inicia el servicio"
echo "4) Para el servicio"
echo "5) Desactiva el servicio"
echo "6) Activa el servicio"
echo "*) SALIR"

read -p "Dime una opcion: " opcion
read -p "Dime el servicio: " serv

case $opcion in 
1)
    sudo systemctl cat $serv.service
;;
2)
    sudo systemctl status $serv.service
;;

3)
    sudo systemctl start $serv.service
;;

4)
    sudo systemctl stop $serv.service
;;

5)
    sudo systemctl disable $serv.service
;;

6)
    sudo systemctl enable $serv.service
;;

*)
    echo "Salimos del Script"
    exit 0
;;
esac
done
