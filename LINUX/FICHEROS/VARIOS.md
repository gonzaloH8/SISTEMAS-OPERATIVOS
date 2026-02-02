# ENLACES
- [Documentacion Ampliado(Meteorologia)](https://wttr.in/:help)

# UNAME
    uname -- nuestra el nombre del Kernel
    uname -o .. muestra el nombre del SO
    uname -a -- nuestra el nombre del Kernel, SO, arquitectura del sistema, host, procesador
    uname -m -- sabras si la CPU tiene soporte para virtualizacion

# WHO
    who -- lista los usuarios conectados en el sistema en tiempo real
    who -a -- informa de la fecha y hora del ultimo arranque del sistema por parte de algun usuario
    who -H -- lista de usuarios logeados, sesiones de terminal a las que estan conectados
    whoami -- muestra por pantalla el nombre del usuario que acaba de ejecutar el comando

# DMICODE
    dmicode -s system-manufacturer -- puedes ver el fabricante del PC, ya sea Asus,HP,Dell,Lenovo,etc
    dmicode -s processor-manufacturer -- muestra el nombre del fabricante de la CPU, INTEL o AMD
    dmicode -s -- listado completo de todos los posibles inputs que puede introducir como opciones

# LSHW
    lshw -- lista de todos los componentes de hardware detectados, fabricante, version firmware,etc
    lshw -short -- arbol con todos los dispositivos detectados y su ruta de hardware
    lshw -c video -- componentes hardaware de clase video. tarjeta, tarjeta graficas detectadas, etc
    lshw -c network -- componentes de clase netwprk. tarjetas de red ethernet y adaptador wireless

# DATE
    date -- fecha actual del SO, segun el estandar CEST
    date -u -- imprime la fecha actual segun el estandar UTC

# CAL
    cal -- muestra el calendario de un mes o año especificados
    cal -y 2019 -- muestra el calendario del año especificado

# CURL
    curl wttr.in -- consulta la prevision meteorologica de los proximos 3 dias
    curl wttr.in/paris -- consulta la prevision de una zona en concreto

# VARIOS
    sudo -l -- cambia de $ a #
    sudo + comando. -- permite ejecutar un comando con permisos de administrador de manera puntual
    sudo su o bash -- permite hacer un cambio de sesion de usuario, sin la necesidad de cerrar la sesion del usuario actual
    man + comando -- guia completa del comando
    clear -- limpia la pantalla sin borrar el contenido, hace scroll hacia abajo
    history -- imprime por pantalla un listado de los ultimos comandos usados
    exit -- cierra sesion de terminal actual del usuario logueado en ella. Tambien para pasar de root a usuario 
    q -- permite salir del editor de texto
