
# FICHEROS Y DIRECTORIOS
    #! /bin/bash
    clear

    # si no escribes el fichero, pon por defecto la variable localfile

    localfile=/home/gonzalo/Escritorio/Practicas/DATOS_CLIENTES.txt
    read -p "Introduce la ruta y el nombre del fichero donde estan los datos del clientes..." fich

    if [ -z $fich ] 
      then    
        fich=$localfile
    fi

    # si no existe el fichero entonces muestro error y sale del script
    # si existe, muestro menu de operaciones

    if [ ! -f $fich ]
      then
        echo "no existe el fichero, compruebalo"
        exit 0
    else    
      echo "MENU DE OPERACIONES"
      echo "-------------------"
      echo "1 Buscar cliente por NIF"
      echo "2 Buscar cliente por Telf"
      echo "3 Buscar cliente por Email"
      echo "4 ---SALIR----"
    
    read -p "Opcion_" opcion
      if [ $opcion -eq 1 ]
        then
          read -p "introduce el NIF..." nif
          grep -e "^.*:.*:$nif" $fich
      elif [ $opcion -eq 2 ]
        then
          read -p "introduce el TELF..." telf
          grep -e "^.*:.*:.*:$telf" $fich
      elif [ $opcion -eq 3 ]
        then    
          read -p "introduce el Email..." email
          grep -e "^.*:.*:.*:.*:$email" $fich
      else
          echo "----FIN DEL SCRIPT----"
          exit 0
      fi
    fi
      exit
