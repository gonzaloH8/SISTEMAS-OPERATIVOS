# ENLACES
- [DD mas informacion](https://keepcoding.io/blog/que-es-y-como-usar-el-comando-dd-en-linux/)

# PARTICIONES(permisos de admin)
    mkefs -- formatea todo
    FDISK
        -m muestra el menu de opciones de este comando
        -l -- permite ver las particiones
        -d -- borra una partición
        -F -- lista el espacio libre no particionado
        -l -- lista los tipos de particiones conocidos
        -n -- añade una nueva partición
        -p -- muestra la tabla de particiones
        -t -- cambia el tipo de una partición
        -v -- verifica la tabla de particiones
        -i -- imprime información sobre una partición
        -w --  escribe la tabla en el disco y sale
        -q -- sale sin guardar los cambios
   
    sudo -l -- cambia de $ a #
    sudo bas -- cambiamos de usuario a administrador
    
    dumpe2fs /dev/particion -- ves la informacion de la particion
    dumpe2fs -h /dev/sad2 -- lees la informacion de la particion maestra o principal 0
    dumpe2fs -o superblock=inodo
    dumpe2fs -o superblock=32768 -o blocksize=4096 /dev/sda1 | less -- sale reducido   
    
    debugfs -- contenido de inodo. tiene sus propios comandos
    open /dev/sda2 -- abre la particion y permite empezar a ejecutar los comandos de debugfs
    cat <inodo> -- permite visualizar el contenido
    imap <inodo> -- permite consultar la info del inodo
    if=/dev/sda1 bs=4096 skip=48089362 count=1 -- contenido de los clusters de datos del inodo ded forma directa(RAW)
            bs(blocksize): tamaño del bloque
            skip: tamaño del cluster
            count: numero de contenido a ver

    dd -- permite realizar copias de seguridad, clonar discos y particiones, tranferencia de datos
        info dd -- permite consultar toda la informacion del comando

    df -h -- comprueba el espacio en disco

    losetup -- 
    losetup -f -- para saber cual esta libre

    parted/fdisk /dev/loop0 -- accedemos al creador de particionamientos
    n -- añadimos una nueva particion
    p -- añadimos particion y la seleccionamos como primaria
    w -- guardamos los cambios
    q -- salimos del fdisk

    mke2fs -t ext4 /dev/loop0p1 -- permite formatear la particion recien creada

    Por defecto el lugar donde se montan es en los directorio /mnt o /media
    mount -- permite montarlo dentro del sistema de ficheros existente en la maquina fisica
    mount -t ext4 /dev/loop0 /mnt/
    cd /mnt -- vemos que se ha creado correctamente nuestro dispositivo virtual

    fdisk /dev/sdb -- hace la particion
    mkfs -t ext4 /dev/sda1
    mkdir /mnt/disco2
    mount -t ext4 /dev/sdb1 /mnt/disco2
    editar /etc/jstab
