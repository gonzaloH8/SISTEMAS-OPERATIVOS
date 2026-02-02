# ENLACES
- [USUARIOS](https://computernewage.com/2015/06/27/conoce-la-estructura-de-permisos-de-linux-al-detalle/)
- [Informacion Extra](https://victorhckinthefreeworld.com/2017/07/06/comando-cp-de-linux-un-par-de-trucos-utiles/)
- [AWK](https://vergaracarmona.es/guia-del-comando-awk/)
- [AWK Ejemplos](https://geekland.eu/uso-del-comando-awk-en-linux-y-unix-con-ejemplos/)
- [MANUAL AWK](https://congresos.nnb.unam.mx/TIB2014/sites/default/files/TIB2014/manual_awk.pdf)

# CREACION DE ARCHIVOS
    touch nombreArchivo -- permite crear uno o varios archivos vacios en formato txt
    > fichero1.txt > fichero2.txt -- permite crear fichero vacios
    touch fich{1..4}.txt -- crea 4 ficheros
    echo -e 'contenido' >> fichero.txt -- permite agregar un texto y crear el fichero que lo contenga al mismo tiempo
    echo 'contenido' > fichero.txt .. sobreescribe el contenido del fichero

# VER CONTENIDO DEL ARCHIVO
    cat >> nombreArchivo contenido -- crea un archivo con el conteido inidcado. CTRL + D finaliza
    cat > Archivo.txt contenido -- sobreescribe el contenido
    cat nombreArchvio -- imprimira en la terminal el contenido del archivo
    cat -n nombreArchivo -- imprime el contenido y hace un conteo de lineas
    cat -b -- imprime el contenido y numero solo aquellas que contengan texto, descarta las lineas en blanco

# BUSCADOR EN ARCHIVOS
    grep [-opciones] /ruta/fichero -- permite buscar palabras o caracteres dentro de un texto. Hace la funcion de CTRL + F
      -v  -- muestra aquello que no cumple el patron
      -E, --extended-regexp     PATRONES son expresiones regulares extendidas (ERE)
      -F, --fixed-strings       PATRONES son cadenas
      -G, --basic-regexp        PATRONES son expresiones regulares básicas (BRE)
      -P, --perl-regexp         PATRONES son expresiones regulares en Perl
      -e, --regexp=PATRONES     utiliza PATRONES para encontrar coincidencias
      -f, --file=FICHERO        obtiene PATRONES de FICHERO
      -i, --ignore-case         considera iguales mayúsculas y minúsculas
            --no-ignore-case      considera diferentes mayúsculas y minúsculas
      -w, --word-regexp         coincide solamente con palabras completas
      -x, --line-regexp         coincide solamente con líneas completas
      -z, --null-data           una línea de datos termina en un byte 0, no en un carácter de nueva línea

    more -- imprime el contenido paginado. Adecuado para archivos largos

    less -- muestra el contenido en modo editor de texto
    g + Enter -- avanza por defecto una linea adelante
    :1 -- marcas la g e introduces el numero deseado avanzando esa cantidad de lineas

# MOSTRAR CONTENIDO POR LINEAS
    tail -nNumero_lineas nombre_archivo -- muestra las lineas indicadas del archivo
    tail -cNumero_bytes nombre_archivo -- muestra los bytes indicadas del archivo
    tail -f nombre_archivo -- muestra las ultimas 10 lineas
    ls -l | tail -n8 -- veremos los siete archivos o carpetas modificados hace más tiempo.
    
    head -nNumero_lineas nombre_archivo -- muestra las lineas indicadas del archivo
    head -cNumero_lineas nombre_archivo -- visualización a los primeros bytes
    head -q -n 1 /etc/*.conf -- mostrar únicamente los nombres de los archivos
    head -v /etc/host*.conf -- extraer solo los nombres de los archivos

# ORDEN
    sort -r -- muestra el contenido desde el final

# DELIMITADOR
    cut -d ':' corta el string por el delimitador definido entre comillas
    cut -d ':' -f 1,3 -- indica la posicion del array creado que se quiere mostrar
    
    while IFS= read -r line. do. echo "$line" -- lectura de ficheros
    while read a do echo $a done
    IFS(INPUT FIELD SEPARATOR) -- indica por defecto el salto de linea

# COMPARACION DE ARCHIVOS DE TEXTO
    diff parametros archivo1 archivo2 -- compara dos archivos linea por linea. Muestra las diferencias 1ºArchivo < 2ºArchivo >
    diff -b .. hacemos la comparacion sin tener en cuenta los espacios en blanco
  
    cmp archivo1 archivo2 -- compara dos archivos byte a byte
    cmp -b archivo1 archivo2 -- nos muestra los byte diferentes, numero de linea y contenido que varia

# NANO(EDITOR DE TEXTO)
    NANO -- abres el editor de texto
        CTRL + R -- permite abrir un archivo de texto y mostrar su contenido
        CTRL + V -- permite avanzar a la pagina siguiente
        CTRL + Y -- permite retrocer a la pagina anterior
        CTRL + W -- abre un buscador de palabras dentro del texto
        CTRL + X -- permite salir del editor de texto
        CTRL + O -- permite guardar cambios
        CTRL + SHIFT + V -- permite pegar texto externo
    sed - e "s/textoO/textoM/g" fichero ---> es un editor de texto online

# VIM
    VIM -- editor de texto mas complejo
    sudo apt intall vim -- instalacion de vim
    vim -- abre el editor de texto
    :help -- archivo de ayuda sobre los comandos de vim

# AWK
    DELIMITADORES
    IFS: '|'
    awk '{print}' archivo.txt -- imprime el contenido
    awk -F ':' '{print $1}' archivo.txt -- cambiar el delimitador y extre la primera columna
    awk -F '|' '{print $2, $4}' archivo.txt -- extrae varias columnas, teniendo como delimitador |
    awk 'BEGIN {FS = ":"}' '{print $1, $3}' archivo.txt
    awk -F '/' '{print $NF}' archivo.txt -- se utiliza el / como delimitador y se imprime el ultimo delimitador de cada linea  
    awk 'BEGIN {system("comando")}' archivo.txt -- ejecuta el comando

    FUNCIONES
    awk '/patron/ {print}' archivo.txt -- imprime la lineas que sigan el patron
    awk '/condición/ {print $2, $4}' archivo.txt -- imprime las lineas que cumplen la condicion
    awk '/condición1/ && /condición2/ {print}' archivo.txt -- imprime las lineas que cumplan con ambas condiciones
    awk '{print length}' archivo.txt -- permite ver la longitud de cada linea
    awk 'length == 5 {print length}' archivo.txt -- imprime las lineas que contengan un numero determinado de caracteres
    awk -F ':' '{if ($NF == "palabra") print}' archivo.txt -- imprime todas las lineas cuyo ultimo delimitador sea igual a una determinada palabra
    awk '{print substr($0, 3)}' archivo.txt -- imprime todas las lineas eliminando las 3 primeros caracteres
    awk 'match($0, /patrón/) {print RSTART}' archivo.txt -- imprime la posicion en la que se encuenta el patron
    awk 'match($0, /patrón/) {print RLENGTH}' archivo.txt -- imprime la longitud del patron encontrado en cada linea
    
    VARIABLE NF
    awk -F '/' '{print $(NF-1)}' archivo.txt -- imprime del penultimo o antepenultimo delimitador

    VARIABLE NR
    awk 'END {print NR}' archivo.txt -- cuenta el numero de lineas de un fichero o de salida de un comando
    awk 'NR == 1 {print}' archivo.txt - imprime la primera linea de un fichero o salida de un comando
    awk 'NR >= 5 {print}' archivo.txt -- imprime todas las lineas a partir de la linea 5
    awk 'NR >= 3 && NR <= 7 {print}' archivo.txt -- imprime un rango de lineas, desde la 3 a la 7 linea

    GSUB
    awk '{gsub(/patrón/, "reemplazo"); print}' archivo.txt -- busca todas las coincidencias con el patron y las reemplaza
    awk -F ':' '{gsub(/patrón/, "reemplazo", $2); print}' archivo.txt -- establece un delimitador, busca y reemplaza el patron en la segunda columna
    

    SCRIPTS
    awk -f script.awk archivo.txt
    
