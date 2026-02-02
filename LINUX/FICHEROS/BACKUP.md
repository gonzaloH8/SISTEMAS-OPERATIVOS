# COPIAS DE SEGURIDAD ====> programacion de tareas
Un backup es una copia de seguridad de ficheros de usuario(s)/sitema, de tal forma que si hay un determinado fallo puedes restaurar el sistema o bien los doc, del usuario(s) a como estaban en el momento de hacer el backup.
(Ataque de cifrado de contenido)

tipos de backup
A lo largo del mes se crea una planificacion de backups
- **backup totales:** es una copia de todos los ficheros/directorios de usuario(s)/sistema como si no se hubiese realizado antes ninguna copia nada. 
        Al menos una vez a la semana hacer un backup total(generalmente a primera hora del lunes)
- **backup incrementales:** copia de ficheros/directorios que han sido modificados desde el ultimo backup. Estos backup siempre se apoyan en un backup anterior, ya se total o incremental
Entre semana, realizar backup incremental.
Ejemplo: si se cae todo el viernes a ultima hora, para restaurar los datos hay que hacer. Se parte del ultimo backup total y a partir de ahi se recupera los backup incrementales
Almacenamientos de NAS profesionales/domesticos

# COMANDOS
    empaquetador tar a los ficheros que crea como backup se les llamar tar-files
    backup total
    1) CREAR UN BACKUP TOTAL A UN FICHERO COMPRIMIDO
        tar -c -v -z -f /ruta/fichero_tar_backup.tar.gz  /ruta_copiar/ -- crear una copia comprimida de tipo tar
        tar -- indica como se ha creado este fichero
        gz -- indica que esta comprimido
            tar -z comprime
            tar -c obligatoria para crear un backup
            tar -v te muestra los procesos de copiado
            -f /ruta/fichero -- indica la ruta y el nombre del fichero de backup o tar-file
    2) VER EL CONTENIDO
        tar -t -v -z -f /tmp/backup_documentos.tat.gz -- muestra el contenido del fichero creado
            tar -t list backup -- permite ver el contenido del backup
            tar -v modo detallado del contenido del fichero backup
            tar -f /ruta/fichero indicas el fichero tar que quieres ver
    3) RESTAURAR EL CONTENIDO el contenido de un BACKUP: 1º te debes situar en el directorio donde quieres extraer el backup      
        cd /ruta/_extraccion
        tar -x -v -z -f /ruta/fichero_backup.tar.gz /ruta/extraccion
        -x -- EXTRACT BACKUP
        -v -- modo detallado de la extraccion fichero por fichero
        -z -- si esta comprimido con gzip, lo descomprime
        -f /ruta/fichero -- fichero q quieres extraer
    4) BACKUP INCREMENTAL
        con TAR para poder hacer backups incrementales, exige tener referencia un fichero de "snapshot"     
        (instantanea de ficheros/directorios copiados) para crear este fichero debes usar opcion -g /ruta/fichero_snap
            1º) cuando haces un backup total, te creas el fichero snapshot asi
                tar -c -v -z -f /ruta/fich_backup_total.tar.gz -g /ruta/fichero_snap /ruta_a_hacer_backup
            2º) haces un backup del mismo directorio a copiar usando ese fichero snap creado en el backup total del paso anterior. 
                De tal forma que antes de copiar un fichero o directorio consulta el fichero snap y mira a ver si lo tiene q copiar o no
                tar -c -v -z -f /ruta/fich_backup_incremental_num.tar.gz -g /ruta/fichero_snap /ruta_a_hacer_backup

# BACKUP DE CPIO
CPIO es un empaquetador mucho mas potente que tar. funciona pasandole la lista de ficheros que quieres empaquetar mediante un pipe(tuberia | ) 
El resultado del empaquetamiento por defecto te lo muestra por pantalla, si lo quieres almacenar en un fichero tienes que redireccionar la salida hacia el fichero que quieras
Con CPIO no hay una opcion explicita para crear backups incrementales

Funcionamiento de cpio para crear una copia o backup
lista_ficheros | cpio -o -- crear el fichero del backup > /ruta/fichero_backup.cpio
pude ser ls
el mas se suele usar es find /ruta_busqueda [-opciones de busqueda] [accion_sobre_elementos_encontrados]
  |-----------------------------------------------------|
  | -> mirar pagina de manual
- -type f|d|l|p|s <==== find busca elementos dentro de ruta_busqueda del tipo esp
- -user nombre <==== busca elementos que pertenezca a ese usuario
- -group grupo <=== busca elementos que pertenezcan a ese grupo
- -perm permisos <=== busca elementos que cumplan con ese patron
- -regex "patron" <==== busca elementos que cumplan con ese patron
- -amin [+|-]numero <==== minutos de acceso al fichero
- -atime [+|-]numero <==== dias de acceso al fichero
- -anewer /ruta/fichero_ref <==== busca elementos q se haya ACCEDIDO antes o igual q el fichero de referencia
- -cmin [+|-]numero <===== minutos de creacion/modificacion
- -ctime [+|-] <==== dia de creacion/modificacion
- -cnewer /ruta/fichero

Estas opciones se pueden combinar con op.logicos AND [-a] o OR(-o)
EJ: find /home/pablo -type f .regex "*\.txt$" -ctime +2 <== busca en /home/pablo, ficheros cuyo nombre acabe en .txt y cuya fecha de modificacion sea de al menos 2 dias
en directorio documents, ficheros, con extension pdf o docx o txt o doc, de tamaño superior a 15M, fecha de creacion de hace una semana o menos
find /home/Documents -type f -regex "*\.[pdf|docx|txt|doc]$" -size +15M -atime -7
find /home/pablo/documents -type f size 15M -ctime -7 -regex "*\.[pdf|docx|txt|doc]$" | cpio -o -v > /tmp/backup_doc_office.cpio -- guarda la salida del comando en el fichero

# RESTAURAR EL BACKUP DE CPIO
    cpio -i [-opciones_auxiliares] < /ruta/fichero_cpio -- extraccion de contenido empaquetado
        -v ===> forma detallada
        -t ===> NO RESTAURA,solo muestra los ficheros q contiene el backup
        -d ===> crea directorios donde estaban situados esos ficheros (si no pones esta opcion te extrae todo en el directorio donde ejecutes cpio)
        --no-absolute-filenames ===> crea ficheros en directorios actual, sino la pones intenta restaurar los ficheros donde fueron recuperados en origen
            cd /home/susana/Documents
            cpio -i -v -d < /tmp/backup_doc_office.cpio
        EJ: quiero extraer el contenido del backup: /tmp/backup_doc_office.cpio hecho antes en el directorio
            mkdir /tmp/extraer_apuntes_sistemas
            cd /tmp/extraer_apuntes_sistemas
            cpio -i -v -d --no-absolute-filenames < /tmp/backup_doc_office.cpio
            ls -l
                                            
PRACTICA
    - realizar un backup de todos los scripts(*.sh) y ficheros de texto de apuntes (ficheros *.txt) q tengas en tu directorio personal (no solo en Documents) que pertenezcan solo a tu usuario con CPIO
    y el fichero de copio almacenamiento en /tmp <==== llamarlo: backup_sistemas_fecha_hora.cpio
    comprobar que se ha creado en /tmp
    intentar extraerlo en directorio /tmp/extraer_apuntes_sistemas <==== crear directorio si no existe

# CREACION DE BACKUPS CON RSYNC (Remote Syncronization Daemon tool) 
una de las herramientas mas potentes para hacer copias de seguridad tanto en sistemas linux(herramientas nativa) como en sistemas windows es muy eficaz
- sirve para hacer backups totaltes como incrementales (a nivel local como a nivel remoto)
- solo copia fragmentos de ficheros/directorios q se han modificado realmente y encima la transferencia de los datos modificados se realiza con un algoritmo de compresion muy potente, y es muy rapido
- permite el borrado de ficheros/directorios que se han borrado en origen (mantiene sincronizados ficheros/directorios en origen con ficheros/directorios en destino del backup),ademas permite guardar estos ficheros/directorios borrados temporalmente en otro destino como medida de seguridad
    Uso de RSYNC de forma local
    `rsync [-opciones] /ruta/directorio_origen_SRC /ruta/directorio_copia_destino_DEST
        ------
            | 
        -a ----> Copia todo de forma recursiva y mantiene permisos, usuario propietario y grupo propietario de cada elemento que copia .equivale a poner : -r -l- p -t -g -o -D
        -v ----> te muestra todas las operaciones del comando
        --no-wole-file ---> evita que se tansfieran de origen a destino todos los ficheros "completos", solo aquellos partes q se han modificado de los mismos (es mas rapido)
        --delete ----> borra en DESTINO los elementos que has borrado en ORIGEN (mantiene perfectamente sincronizados ambos)
        --backup     ---->
        --backup-dir ----> cuando borras en DESTINO algun elemento, rsync lo almacena en el directorio q pongas en --backup-dir`

# PRACTICA
vamos a mantener sincronizados backup con rsync : SRC origen   ---> /home/gonzalo/Documents
                                                  DEST destino ---> /tmp/backup_rsync (crear directorio)
1 copia: rsync -a -v --no-whole-file /home/gonzalo/Escritorio/Practica /tmp/backup_rsync
    nos metemos en /tmp/backup_rsync y vemos su contenido (deberia estar todo los documentos)
    En documents
        - Creamos un directorio llamador "Prueba"---> meter 4 ficheros
        - En documents ------> crear un fichero LEEME.txt
    Ejecutamos rsync
        2º copia: rsync -a -v --no-whole-file /home/gonzalo/Escritorio/Practica /tmp/backup_rsync
        nos metemos en /tmp/backup_rsync y vemos su contenido (deberia estar todo los documentos)
        una vez que este comprobado q esta el nuevo contenido copiado
        borrar ficheros de Documents/pruebas ----> fich1.txt y fich2.txt
    3º ejecutamos rsync
        rsync -a -v --no-whole-file /home/gonzalo/Escritorio/Practica /tmp/backup_rsync
        comprobar que ha sido borrado en destino /tmp/backup_rsync
    4º rsync -a -v --no-whole-file --delete --backup -backup.dir=/tmp/fihceros_borrados /home/gonzalo/Escritorio/Practicas /tmp/backup_rsync                           
            
Uso de RSYNC de forma remota(cliente <===> servidor de backups)

contenedor docker mirar ¡¡¡ IMPORTANTE
sniffer del trafico
sandbox

# PRACTICA (investigar): ¿Como hago la copia con rsync de lo que hemos hecho en local /home/gonzalo/Escritorio en un servidor externo (ubuntu-server, con ip ) en /tmp/backup_rsync del servidor?
cliente ubuntu-desktop                                        servidor ubuntu-server
        ||                    rsync+ssh(con cifrado)                    || usuario: _remoto
    /home/gonzalo/Escritorio-----------> /tmp/backup_rsync ¿dame tu clave publica? me certifico de quien es mediante certificado digital
    ¿comando srync?
        |                            |
    cifrado con la clave        sniffer del trafico
    privada                     
    rsync -a -v -z --no-whole-file /home/gonzalo/Escritorio _remote@ubuntu_server:/tmp/backup_rysnc -- sin cifrar
                                                                                                       cifrado opcion -e "ssh...."
                                                                                                       y para generar claves ssh-keygen
