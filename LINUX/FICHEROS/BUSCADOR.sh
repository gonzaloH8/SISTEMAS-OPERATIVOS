# COMANDOS
    FIND
    ESTRUCTURA: find /ruta_busqueda [-opciones de busqueda] [accion_sobre_elementos_encontrados]
    -type f|d|l|p|s <==== find busca elementos dentro de ruta_busqueda del tipo esp
    -user nombre <==== busca elementos que pertenezca a ese usuario
    -group grupo <=== busca elementos que pertenezcan a ese grupo
    -perm permisos <=== busca elementos que cumplan con ese patron
    -regex "patron" <==== busca elementos que cumplan con ese patron
    -amin [+|-]numero <==== minutos de acceso al fichero
    -atime [+|-]numero <==== dias de acceso al fichero
    -anewer /ruta/fichero_ref <==== busca elementos q se haya ACCEDIDO antes o igual q el fichero de referencia
    -cmin [+|-]numero <===== minutos de creacion/modificacion
    -ctime [+|-] <==== dia de creacion/modificacion
    -cnewer /ruta/fichero
