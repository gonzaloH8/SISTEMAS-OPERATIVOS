# ENLACES INFORMATIVOS
- [DOCUMENTACION](https://computernewage.com/2015/06/14/el-arbol-de-directorios-de-linux-al-detalle-que-contiene-cada-carpeta/#estructura-directorios)
- [DOCUMENTACION INGLES EXTENDIDA](https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/index.html)
- [COMANDOS](https://computernewage.com/2013/04/10/como-manejar-archivos-y-carpetas-desde-la-terminal-de-linux/)

# INSTALACION
- [Virtual Box( DESCARGAR MAQUINA VIRTUAL(VIRTUALBOX))](https://www.oracle.com/es/virtualization/virtualbox/)
- [DESCARGA DE UBUNTU(Ultima Version)](https://ubuntu.com/download/desktop)
- [DESCARGA DE UBUNTU(version 22)](https://releases.ubuntu.com/jammy/)
- Hacer una nueva maquina
- Nombre: Ubuntu y su version
- Aplicar SO adecuado
- Aumentar la RAM,ROM,Procesadores,Memoria de Video, Carpetas Compartidas
- Iniciar la instalacion y seleccionar try and install Ubuntu
- -------------------------------------------------------------------------
- [Instalacion de las Guest Adicctions](https://cambiatealinux.com/instalar-virtualbox-guest-additions-en-ubuntu#google_vignette)
- Insetamos las guesst adicctions(si hay problemas haremos lo siguiente)
- lsb_release -a: vemos que esta instalado la versión de Linux
- sudo apt Update -y: nor permite actualizar
- sudo apt install bzip2: instalación necesaria para las guesst adiction
- Volver a ejecutar la aplicacion de las Guest Adition
- Hacemos una isntantanea de la maquina recién instalada por si ocurre algo, seleccionamos la instantánea y damos a restaurar

# ESTANDAR DE JERARQUIA DE DIRECTORIOS O FHS
Filesystem Hierarchy Standard(FHS): es la jerarquia para los sistemas de archivos en sistemas Linux y otros derivados de UNIX
Esta siendo mantenida por la Linux Foundation. Hay distribuciones GNU/Linux que apuestan por(Gobo Linux). Todo el arbol parte de una raiz comun denominada root y que simboliza por una barra inclinada. Es usual hacer particiones donde guarden ciertos directorios como /home

## DIRECTORIO RAIZ O ROOT(Directorio personal de superusuario)
Se inicia con una /, con la que accederas a todos los directorios del sistema, particiones, etc

## BIN(Binarios de Usuario) SBIN(Binarios de sistema)
/bin: directorio estatico, donde se almacenan todos lo binarios necesarios para garantizar las funciones basicas a nivel de usuario. Solo almacenan los ejecutables de ususario.
        Ejecutables (o binarios) básicos del sistema, cuando, por ejemplo ejecutamos el comando cp en realidad ejecutamos /bin/cp.
/sbin: Los binarios necesarios para tareas administraticas gestionadas por el usuario root o superusuario del sistema.
Tambien incluye los binarios que permiten la ejecucicion de utilidades estandar de la terminal de Linux: cat, cd, cp, echo, grep, gzip, kill, ls, mv, rm, ping, su, ps, tar y vi.

        arca: Muestra la arquitectura del ordenador.
        cp: copia un archivo a otro lugar.
        gzip: comprime/descomprime
        login: Iniciar sesión como otro usuario.
        more: Muestra un archivo poco a poco (como les).
        rm: Borra archivos
        sh, bash: Interpretes de comandos.
        ls: Muestra el contenido de una carpeta.
        mount: Monta un dispositivo en una carpeta.
        rmdir: Borra una carpeta
        sleep: "Duerme" el sistema durante los segundos que le indiques.
        touch: Cambia la hora de ultimo acceso y modificación de un archivo, si no existe lo crea.
        cat: Muestra el contenido de un archivo.
        date: Muestra la hora del sistema.
        echo: muestra el contenido de variables o lo que le indiques.
        kernelversion: muestra la versión del Kernel
        ps: Muestra los procesos del usuario, con ps aux muestra todos.
        chgrp: Cambia de grupo un archivo.
        grep: Muestra líneas siguiendo un patrón.
        kill: "Mata" un proceso.
        mkdir: Crea una carpeta.
        pwd: Muestra la ruta de la carpeta en donde estamos.
        su: Cambia de usuario temporalmente.
        umount: Desmonta un dispositivo.
        chmod: Cambia los permisos de un archivo.
        ln: Crea un enlace entre archivos o carpetas.
        mv: Mueve un archivo.
        uname: Información del sistema.
        chown: Cambia el usuario de un archivo.
        dir: Parecido a ls.
        netstat: Información de la red.
        tar: Agrupa archivos en un .tar

## BOOT(Ejecutables y archivos requeridos para el arranque)
/boot: Directorio estatico e incluye todos los ejecutables y archivos que son necesarios en el proceso de arranque del sistema, y que se deben ser utilizados antes que el kernel empiece a dar las ordenes de ejecucion de los diferentes modulos del sistema. Es tambien donde se encuentra el gestor de arranque GRUB

    System.map-2.2.20-idepci: Mapa del sistema.
    boot.b: Archivo de arranque.
    vmlinuz-2.2.20-idepci: Imagen del kernel.
    config-2.2.20-idepci: Configuración del kernel.

## DEV(Archivos de informacion de todos los volumenes)
/dev: incluye todos los dispositivos de almacenamiento, en forma de archivos, conectaddos al sistema(discos duros, USB, particion, CDROM) Contiene la informacion de cada uno de los volumenes.

    /dev/sda1 - Particion principal
    /dev/sda2 - Particion extendida
    /dev/sda5 - Particion Swap
   
    /dev/sdb1 -- dispositivo externo
    /dev/sdb2 -- dispositivo externo
    /dev/sdb3 -- dispositivo externo

    fd0: Disquetera.
    hdxy: Partición nº y del disco duro nº x.
    ttyx, ptyx: Terminales del sistema tanto locales como remotas.
    ramx: Bloques de memoria ram.
    random: Dispositivo generador de números aleatorios.
    PSUC: Entrada del ratón (PS2).
    snd: Tarjeta de sonido.
    lpx: Impresora x.
    null: Salida de datos que no lleva a ninguna parte.
  
## MEDIA(Directorio de montaje de volumenes extraibles)
    /media: contiene los puntos de montaje, pero no la informacion real
    /media/User1
    /media/User2

## ETC(Archivos de configuracion del sistema y de apliaciones)
Es el encargado de almacenar archivos de configuracion tanto a nivel de componentes del sistemas operativo en si, como de los programas y apliaciones instaladas a posteriori.

    fstab: Información sobre los sistemas de archivos, aquí se configuran los dispositivos que deben montarse y sus sistemas de archivos.
    mime.types: Los tipos mime y sus extensiones, los tipos mime son las relaciones entre el tipo de archivos y su extensión.
    modules: Módulos que deben ser cargados en el inicio del sistema.
    shadow: Contraseñas encriptadas y ocultadas.
    profile: En esta archivo se configura la variable PATH, los prompt y los permisos con que serán creados los archivos (umask).
    group: Grupos que hay en el sistema.
    mtab: Dispositivos ya montados.
    protocols: Lista de protocolos de internet que soporta la maquina.
    hostname: Nombre del host.
    deluser.conf: Que se hace cuando se elimina a un usuario.
    services: Servicios de la red.
    timezone: Zona horaria.
    cat /etc/shells -- nos permite ver los shells a instalar
    cat /etc/bahts -- en caso de que no tengamos ninguno instalado
    echo $SHELL -- permite ver el que tenemos instalado

## HOME(directorio personar de las carpetas de usuario)
Es el directorio de usuarios estandar, destinado a almacenar todos los archivos de usuario(/documentos, /Imagenes, /videos, /musica, /plantillas,etc). Es usual ubicar el /home en una particion separada del resto
Tambien incluye archivos temporales de apliaciones ejecutadas en modo usuario, que sirven para guardar las configuraciones de programas,etc situadas en carpetas ocultas(Acceso a ellas CTRL + F)
Estructura
  .NombreCarpeta(Carpetas Ocultas)
  /home/user1
  /home/user2

## LIB(Bibliotecas necesarias para la ejecucion de binarios)
Incluye las bibliotecas esenciales que son necesarios para que se puedan ejecutar correctamente todos los binarios que se encuentran en los directorios /bin y /sbin, asi como los modulos del propio Kernel.
En los sistemas Operativos de 64bits, ademas de /lib existe el direcotio /lib64, referidas a las bibliotecas para aplicaciones de 64 bits

    libcap.so.1 libdb2.so.2.7.7 libnss_compat-2.3.2.so libpamc.so.0.76 libss.so.2
    iptables libcap.so.1.10 libdl-2.3.2.so libnss_compat.so.2 libpcprofile.so, etc...

## OPT(Ficheros de apliaciones externas que no se integran en /usr)
Van todos los archivos de solo lectira que son parte de programas autocontenidos. Seria algo parecido al directorio de "Archivos y Programs de Windows"

## PROC(Ficheros de informacion de procesos)
Contiene informacion de los procesos y apliaciones que se estan ejecutando en un momento determinado en el sistema, por lo que su contenido es nulo, ya que no guarda nada. Basicamente son listas de eventos del SO que se generan al momento de acceder a ellos.
- [Informacion Ampliada](https://www.linuxtotal.com.mx/index.php?cont=info_admon_016)
  
      proc/ -- el kernel cuando arranca, y los crea en memoria RAM (cuando se apaga el equipo, desaparecen)
      ls /proc -- muestra las carpetas que lo conforman y los numeros son procesos en ejecucion
      cat proc/meminfo -- info del equipo
      cat proc/cpuinfo -- muestra info del procesador de tu equipo
      cmdline: Los argumentos que son pasados al kernel durante el arranque.
      cwd: Es un enlace al directorio de trabajo de un proceso, para saber el directorio de trabajo del proceso 50 por ejemplo haríamos: cd /proc/50/cwd; /bin/pwd
      environ: Contiene el "ambiente" de un proceso, para ver el del proceso 50, haremos: (cat /proc/50/environ; echo) | tr "\000" "\n"
      exe: En Linux 2.2 y 2.4 exe es la ruta del proceso, esto sirve para ejecutar una copia del proceso, para volver a ejecutar el proceso 50 haremos: /proc/50/exe.
      fd: Es una carpeta que tiene un enlace a cada archivo que el proceso ha creado o utilizado.
      maps: Contiene las zonas de accesos a la memoria y los permisos del proceso.
      root: Apunta al sistema de archivos del root.
      status: Información combinada de stat y statm de forma mas comprensible.
      cat /proc/version -- informacion detallada de la version de Kernel utilizada, compilador GCC, nombre de quien compilo, el Kernel y fecha de compilacion

## ROOT
Vendria a ser como el directorio /home del usuario root o superusuario del sistema.
El usuario root esta en su propia carpeta colgando directamente del la raiz del sistema.

## SRV(Archivos relativos a servidores web, FTP, etc)
Sirve para almacenar archivos y directorios relativos a servidores que puedas tener instalados dentro de tu sistema, ya sea un servidor web www, un servidor FTP, CVS, etc.
En caso de tener alguno isntalado seria buena idea tenerlo publico dentro del /srv
  
    /srv/www

## SYS(Archicos virtuales con informacion de eventos del sistema)
Contiene archivos virtuales que proveen informacion al kernel relativa a eventos del sistema operativo
Estos archivos se distribuyen de forma jerarquica a diferencia del /proc

       proc(process directory) da informacion de todos los procesos que se estan ejecutando en el sist y recursos que usan
       sys (system directory) da informacion de variables de configuracion del kernel y sus modulos
       run(running apps) informacion sobre aps ejecutandose(servicios)

## TMP(Directorio de ficheros temporales)
Sirve para almacenar archivos temporales de todo tipo. Se vacia cada vez que reiniciamos el sistema
El subdirectorio /var/tmp almacena archivos temporales, pero su contenido no se borra tras el reinicio del sistema

## USR(Archivos de programas y apliaciones instaladas)
"User System Reources" y sirve para almacenar todos los archivos de solo lectura y relativos a las utilidades de usuario, incluyendo todo el software instalado a traves de los gestores de paquetes de cada distribucion

    /usr/bin
    /usr/include
    /usr/lib
    /usr/local
    /usr/sbin
    /usr/share
    /usr/src

# VAR(Archivos de variables, logs, emails de los usuarios del sistema, etc)
Contiene varios archivos con informacion del sistema, como archivos de logs, emails de los usuarios del sistema, bases de datos, informacion almacenada en la cache, informacion relativa a los paquetes de apliaciones almacenados en /opt, etc
Actua a modo de registro de sistema

# RUN 
        run/ -- directorios que no estan creados sobre el disp.fisico de almacenamiento, sino que las creas

# SRC
        src/ -- codigo fuente de software instalado por usuarios
