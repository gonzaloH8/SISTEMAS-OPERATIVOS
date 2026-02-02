# MANEJAR ARCHIVOS Y CARPETAS
    pwd -- indica la ruta completa del directorio de trabajo en el que estas
    cd /ruta de directorio -- permite cambiar de directorio de trabajo. Si ejecutas cd vuelves al direcotio raiz
    cd .. -- va uno hacia atras en la ruta
    cd ../.. -- va dos hacia atras en la ruta

# VER CONTENIDO DE UN DIRECTORIO
    ls -- lista los archivos y directorios de la carpeta de trabajo en la que te encuentres
    ls -a  -- lista todos los archivos visibles y ocultos
    ls -l -- lista los archivos y te muestra informacion de ellos
    ls -i -- muestra los inodos de cada archivo y directorio
    tree -opciones ruta ---> imprime por pantalla la ruta en forma de arbol
    sudo apt install -y tree -- instalacion del paquete tree

# CREA, MODIFICA Y ELMINA DIRECTORIOS/FICHEROS
    mkdir /ruta/nombreDirectorio -- permite crear directorios
    rmdir /ruta/directorio -- permite eliminar el directorio especificado
    rm /ruta/archivo permite eliminar archivos sueltos y directorios que no se encuentren vacios
    rm -d Directorio -- permite borrar directorio
    rm -r /ruta/directorio -- borrara todos los archivos y directorios que se encuentren dentro de el(necesita confirmacion)
    rm -rf /ruta/directorio -- borrara todos los archivos y directorios que se encuentren dentro de el(sin confirmacion)
    mv /ruta /ruta-- permite mover archivos desde la consola y cambiar el nombre en la ubicacion de destino
    cp archivo1.txt archivo2.txt-- copia conteido del primer archivo al segundo.
