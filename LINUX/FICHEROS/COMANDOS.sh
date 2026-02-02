# ENLACES
- [COMANDOS estilo terminal(sudo apt install tmux --consola enriquecida)](https://tmuxcheatsheet.com/)
- [CURL WTTR.IN mas informacion](http://wttr.in/:help.)
- [Personalizacion del Terminal](https://computernewage.com/2014/12/25/como-personalizar-el-aspecto-del-prompt-de-la-terminal-de-linux/)

# SHORTS COMANDOS
    CTRL + MAYUS + T -- abre una nueva terminal
    CTRL + MAYUS + C -- copia el contenido seleccionado
    CTRL + MAYUS + V -- pega el contenido seleccionado
    CTRL + ALT + F1 -- permite acceder a la terminal
    CTRL + K CTRL + C -- comenta lo seleccionado
    CTRL + K CTRL + U -- descomenta lo seleccionado
    CTRL + D -- nos permite salirnos de un punto vacio
    CTRL + C -- cancela la ejecucion de un comando
    CTRL + L -- limpia el terminal == clear
    
# VOCABULARIO Y INFORMACION ADICIONAL
    Ruta Abosoluta: aplicas la ruta en orden /home/usuario/descargas/archivo1.txt /home/usuario/Documentos/archivo1.txt
    Ruta Relativa: aplica la ruta corta si estan al mismo nivel. Descargas/archivo1.txt Documentos/archivo1.txt
    En linux no contiene extensiones, son todo nombres. El sistema de archivos es mediante inodos
    gonzalo@computer:~$ -- seras un usuario estandar
    root@computer:/home/gonzalo# -- indicador root de que estas como administrador
    Terminales TTY mediante las combinaciones de teclado 'CTRL+ALT+F1' hasta 'CTRL+ALT+F7'
    EMULADORES PTS: GNOME Terminal, Konsole, Xterm, Yakuake, Guake, etc.
    chmod +x archivo.sh -- nos permite ejecutar el archivo en terminal y ver el resultado
    
    SHELL: intérprete de comandos que permite a los usuarios de Linux y Unix controlar sus sistemas operativos con interfaces de línea de comandos
    KERNEL: componente central de un sistema operativo y sirve como interfaz principal entre el hardware físico de la computadora y los procesos que se ejecutan en ella a través del software
    
# COMENTARIOS
    # este es un comentario de una linea
    : 'este es un comentario de dos o mas lineas'
    : <<'END_COMMENT' COMENTARIO END_COMMENT

# ECHO
    read opcion -- permite al usuario a aplicar un valor a la variable
    read -p "texto" opcion -- permite imprimir un texto y posteriormente permitir al usuario dar valor a la variable
    echo "Hola Mundo"
    echo $linea
        -e -- opcion que permite la ejecucion de saltos de lina(\n) y tabulacion(\t) dentro del echo
        -n -- no imprime la nueva linea
    CARACTERES DE CONTROL
        \a	Sonido de alerta
        \b	Retroceder
        \c	Suprimir salto de texto
        \f	Atrás
        \n	Salto de línea
        \r	Volver al inicio de línea
        \t	Tabulador (horizontal)
        \v	Tabulador (vertical)
        \\	Ver carácter de barra invertida
        \0nnn	Caracteres ASCII en forma octal (solo sh y ksk)
        \nnn	Caracteres ASCII en forma octal (solo Bash)

# OPERADORES DE TEXTO
    > -- entrada de datos que permite sobreescribir contenido de un fichero
    >> -- entrada de datos que permite agregar contenido a un fichero
    < -- salida de datos. Restauracion de paquetado, escritura por teclado
    <<
    \ permite escapar una interpretacion distinta a la que queremos
    \t -- tabula un mensaje
    \n -- salto de linea
    { echo "Hello World"; | ls; } > resultado.txt
    
# OPERADORES DE COMPARACION
    -eq -- igualdad ==
    -ge -- mayor o igual >=
    -le -- menor o igual <=
    -gt -- mayor que >
    -lt -- menor que <
    "$var" = "cadena"
    "$var" != "cadena"

# OPERADORES LOGICOS
    && -a -- AND necesita que se cumplan ambas condiciones especificadas
    || -o -- OR necesita que se cumpla una de las condiciones especificadas
    | -- pipe permite ejecutar varios comandos por separado al mismo tiempo

# VARIABLES
    declare -r variableConstante = 123 -- solo lectura
    variableModificable = 123
    vairbleString = "Hola"
    ejecucion=$(ls) -- guardar comandos en variables

# CONDICIONAL IF ELIF ELSE
     age=10 -- variable
     if [ age -eq 18 ]
         then
             echo "eres un adulto"
     elif [ $age >= 17]
             echo "eres casi un adulto"
     else
             echo "eres un niño"
     fi

    SINTAXIS
     if test 10 -eq 10
     if [[ $age -gt 10 && $age -lt 30 ]]
     if [[ $age -gt 10 -o $age -lt 30 ]]
     if (( $age == 10 && $age >= 10 ))

     OPCIONES: TEST
         ! -f el fichero no existe
         -z fichero/cadena vacio
         -f/-e si el fichero existe
         -d si el directorio existe

# CONDICIONAL CASE
    Se utiliza normalmente para textos
    echo "escoge entre el valor 1 o 2 "
    read valor
    case $valor in 
        1)
            echo "escogiste el 1"
        ;; -- misma funcionalidad que el break
        2) 
            echo "escogistes el 2"
        ;;
        *)
        echo "valor incorrecto"
        ;;
        esac

# BUCLES FOR
    Bucle que repite el comando el numero de veces indicado
    for i in 1 2 3 4 5..
    do
      echo "Bienvenido $i veces"
    done

    Bucle que repite el comando el numero de veces indicado, formato corto
    for i in{1..5}
    do
     echo "Bienvenido $i veces"
    done

    Bucle que repite el comando el numero de veces indicado con un patron de incremento par
    for i in {0..10..2}
    do
     echo "Bienvenido $i veces"
    done

    Bucle de formato java
    for (( c=1; c<5; c++ ))
    do
     echo "Bienvenido $c veces"
    done

    Bucle infinito
    for (( ; ; ))
    do
     echo "Bucle infinito"
    done

    Bucle con Break
    for i in 1 2 3 4 5
    do
     echo "Bienvenido $i veces"
    if [ $i < 3 ]
    then
     break
    fi
     echo "Bienvenido $i veces"
    done

    Recorre todo los archivos del directorio /etc hasta encontrar el archivo
    for file in /etc/*
    do 
        if [ "${file}" == "/etc/resolv.conf" ]
        then
            countNameservers=$(grep -c nameserver /etc/resolv.conf)
            echo "Total dns ${countNameservers} nameservers defined in ${file}"
            break
        fi
    done
    
# BUCLES WHILE
    number =1
    while [ $number -ne 10 ] -- mientras sea cierto se ejecuta el do
    do
        echo $number
        number = $((number + 1))
    done
 
    until [ $number -ge 10 ] -- mientras no sea falso se ejecuta el do
    do
        echo $number
        number = $((number + 1))
    done

    Permite leer linea a linea el fichero
    while read a
    do
        echo $a
    done < fichero

# BREAK Y CONTINUE
    for (( i=0; i < 10; i++ ))
    do
        if [ $1 -gt 6 ] -- nos pemite para el bucle en cuanto se cumple la condicion
            break
        fi
        echo $i
    done

    for (( i=0; i < 10; i++ ))
    do
        if [ $1 -gt 6 ] -- nos pemite saltarnos el 6 y continuar con el bucle
            continue
        fi
        echo $i
    done

# ARRAYS
    nombresArrays = (( "Jone", "Mark", "Irina", "Jone", "Hulk", "Aroa" )) -- sintaxis para definir un array
    echo "Los nombres son: ${nombresArrays[*]}"
    echo "Los nombres son: ${nombresArrays[@]}"
    echo "Item 0: ${nombresArrays[0]}"
    echo "Los indices: ${!nombresArrays[@]}"
    echo "el total de items: ${#nombresArrays[@]}"
    echo "el total de items: ${#nombresArrays[*]}"
    echo "el ultimo elemento es: ${nombresArrays[${nombresArrays[@]}-1]}"
    for nombresArray in ${nombresArrays[@]}
        do
            echo "My name is: $nombresArray" -- muestra todos los nombres
        done
    unset names[1] -- elimina el elemento de la posicion 1
    echo "Los nombres son: ${nombresArrays[*]}" 
    nombresArrays[7]="boob" -- añade un elemento nuevo al array
    nombresArrays[${nombresArrays[@]}]="bob" -- interpreta la longitud maxima del array y añade un nuevo elemento
    echo "items: ${nombresArrays[*]}"
    nombresArrays+=("Bob") -- forma simple de añadir elementos
    nombresArrays[2]="Ari" -- actualiza los valores en funcion de la posicion

# FUNCIONES
    function hola(){
        local message="Hola" -- me permite hacer que el valor de esta variable solo existe dentro de la funcion
        echo "Hola yo soy $1, tengo $2 años"
    }
    hola "Gonza" 50
    
# ARGUMENTOS
    ./arguments.sh 10 20 30 Argumento -- sintaxis de argumentos
    echo $1 $2 $3 $4 -- muestra los argumentos especificados
    echo $@ -- muestra todos los argumentos
    echo $# -- cuenta los argumentos
    args=("$@) -- guarda todos los argumentos en una variable, se convierte en una array
    echo "Result: ${args[0]} - $args{args[1]} , $args{args[2]}"

# INPUT
    while read line
    do     
        echo $line
    done "${1:-/dev/stdin}" -- permite leer lo que escribe el usuario por terminal al momento de escribirlo 

# STANDAR OUTPUT Y STANDAR ERROR
    output -- es aquello que nos muestra por terminal cuando el comando es correcto
    ls 1>file-txt -- permite guardar el resultado del comando en un fichero 1
    ls >file.txt -- permite guardar el resultado del comando en un fichero por defecto
    ls >& file.txt -- permite guardar el resultado del comando en un fichero

    error -- es aquello que nos muestra por terminal cuando el comando es incorrecto
    ls -123 2>file.txt -- permite guardar el resultado de error del terminal a un fichero
    ls 1>fichero.txt 2>&1 -- permite guardar el resultado de error del terminal mediante parametro al fichero
    ls -123 >& file.txt -- permite guardar el resultado de error del terminal a un fichero

# EXPORTAR VARIABLES
    firts.sh
    MESSAGE="hola mundo"
    export MESSAGE
    ./second.sh

    second.sh
    echo "Contenido del script 1: MESSAGE"

# COMPARACIONES CON STRINGS
    echo ${name,,} -- convierte el nombre en miniscula
    echo ${name^^} --convierte el nombre en mayuscula
    echo ${name,,[AEIOU]} -- convierte en minuscula las vocales
    echo ${name^^[aeiou]} -- convierte en mayuscula las vocales

# NUMBERS
    echo $(( 10 + 20 )) -- sintaxis para operar aritmetica
    echo $(( x - y )) --sintaxis para operar aritmetica con variables

# CURL
    permite descargar contenido a partir de un URL
    echo "Ingresa tu url"
    read url
    curl -T $url permite ver informacion del elemento a descargar

# DEBUGGING
    bash -x nombreScript.sh -- permite recorrer el archivo paso a paso
    set -x -- permite aplicar donde queremos que empiece a debuggear y donde queremos terminar lo escribimos otra vez

# VARIOS
    brute force attack jhon the ripper -- forzado de hash
    echo "Hola1234" | sha512sum -- generador de hash 
