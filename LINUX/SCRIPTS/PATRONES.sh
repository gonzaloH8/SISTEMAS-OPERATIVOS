
# ARCHIVO leeme.txt
# PATRONES CORRECTOS
# Gema:Gonzalez Prieto:08981122-A:+34 677 11 22 33:gema.gonzalez@educa.madrid.org
# Cristina:Peralez Caste:13579012-S:+34 857 05 26 43:Cristina.Peralez@educa.madrid.hotmail
# Fernando:Santome Pier:91756201-Z:+34 905 84 00 95:Fernando.Santome@educa.madrid.msn
# Alberto:San Andres Anton:98129410-L:+34 859 83 96 33:Alberto.SanAndresAnton@educa.madrid.es
# Ana:Caste Miralez:65812059-F:+34 129 85 28 41:Ana.Caste@educa.madrid.com

# PATRONES INCORRECTOS
# irina:wallace azul:842350183+F:+56 129 53 94 82: 9IrinaWallace@mita.mexico.est
# 5Irina:wAllace aZul:8423501834-F:+56345129710: _Irina-Wallace=queri.mexico.es
# _Irina:wallace azul:842350183+F:+56 a14 65 12 83: #IrinaWallace;nica.brasil.com
# -IrInA:wallace azul:842350183+F:+42 012 95 49 81: $IrinaWallace,kike.chile.ogi
# Mati:wallace azul:842350183+F:+14 875 58 19 73: %IrinaWallace'loca.argen.est

#!/bin/bash
clear

N_ALMOHADILLA='\e[1;32m'
N_AZUL='\e[1;34m'
N_OPCION='\e[1;96m'
N_ROJO='\e[1;31m'
RESET='\e[0m'

echo -e "\t\t\t $N_ALMOHADILLA ################################################################################ $RESET"
echo -e "\t\t\t $N_ALMOHADILLA ################################### $RESET $N_AZUL PATRONES $RESET $N_ALMOHADILLA ############################### $RESET"
echo -e "\t\t\t $N_ALMOHADILLA ################################################################################ $RESET"
echo -e "\t\t\t $N_OPCION 1) NOMBRES $RESET"
echo -e "\t\t\t $N_OPCION 2) APELLIDOS$RESET "
echo -e "\t\t\t $N_OPCION 3) DNI $RESET"
echo -e "\t\t\t $N_OPCION 4) TELEFONOS $RESET"
echo -e "\t\t\t $N_OPCION 5) EMAIL $RESET"
echo -e "\t\t\t $N_OPCION 6) LINEA COMPLETA $RESET"
echo -e "\t\t\t $N_ROJO 7) SALIR DEL SCRIPT $RESET"

fichero=/home/gonzalo/Escritorio/Scripts/Practicas/leeme.txt
read -p "dime opcion: " opcion
cat $fichero

case $opcion in
1)
    echo "Nombre"
    grep --color -E '^[a-zA-Z]{4,8}' $fichero
;;
2)
    echo "Apellidos"
    grep --color -E '[a-zA-Z]{1,9}\s[a-zA-Z]{1,9}' $fichero
;;
3)
    echo "DNI"
    grep --color -E '[0-9]{8}-[A-Z]{1}' $fichero
;;

4)
    echo -e "\nTelefonos"
    grep --color -E '\+34\s[0-9]{3}(\s[0-9]{2}){,3}' $fichero
;;

5)
    echo "Email"
    grep --color -E '[a-zA-Z]*\.[a-zA-Z]*@[a-zA-Z]*\.(madrid)\.(org|es|com)' $fichero
;;

6)
    echo -e "\nCompleto"
    grep --color -E "^[a-zA-Z]{4}:[a-zA-Z]{1,}\s[a-zA-Z]{1,}:[0-9]{8}-[A-Z]{1}:\+34\s[0-9]{3}(\s[0-9]{2}){,3}:[a-zA-Z]+\.[a-zA-Z]+@[a-zA-Z]+\.(madrid)\.(org)" $fichero

;;
*)
    echo "Salimos del script Patrones"
    exit 0
;;
esac
        echo "Sales de Script"
        ;;
esac
