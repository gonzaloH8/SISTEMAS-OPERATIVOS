
# PRACTICA ---- 15-10-2024
# Vamos a generar una accion para que el servicio corn.service origine un mensaje que recoje syslog
# 1) comprobar que en un fichero /etc/rsyslog.d/50-default.conf existe esta regla
#        cron.*          /var/log/cron <=== crear este fichero si no existe
#    si se modifica el fichero de reglas, hay que reiniciar servicio <=== OJO!!!
#    sudo systemctl restart rsyslog.service                
# 2) vemos las ultimas lineas del fichero log donde rsyslog manda mensajes del servicio: en una consola
# sudo tail -f /var/log/cron -- fichero donde esta los mensajes creados por el servicio cron, mostrando todas las acciones
# 3) con tu usuario, editas fichero de tareas automaticas:
#     crontab -e <====== el servicio cron.service manda mensaje a rsyslog.service para que registre accion        
#     el mensaje tendria que aparecer en la otra consola donde estas viendo el log
# añadimos tarea:
# */2 * * * * touch /tmp/prueba_log_$(date '+%Y-%m-%d--%H:%M')<=== Creamos un fichero en /tmp con la fecha de creacion
#    Cuando sales del la edicion del fichero <==== mensaje tambien enviado a rsyslog
#    Cuando se ejecuta la tarea<====== mensaje tambien enviado a rsyslog
# Como mandar mensajes personalizados a rsyslog: (muy util en scripts)
# logger -p origen.importancia_mensaje -t tag_mensaje "TEXTO MENSAJE"
#            |<--- origen tiene que venir de.en fichero de reglas cron, auth, authpriv, kern, null...daemon
# ej
#         logger -p cron.info .t "[MI MENSAJE]" "... este es un mensaje propio creado con logger, deberia aparecer en log"

# PRACTICA --- 17-10-2024
    1º PASO) generar un script propio que mande mensaje(como si fuera un servicio) cada minuto para que rsyslog los intercepte(llamarlo miscript.sh):
    #!/bin/bash
        clear
        while true
        do
            fecha=$(date '+%Y-%m-%d__%H:%M') # poner la comilla invertida es mas eficaz que el $(.....)<=== subshell
            echo "..mandando mensaje al log a las $date..."
            logger -p daemon.info -t "[miscript.sh]" "mensaje mandado por script: miscript.sh a las $fecha..."
            sleep 1m
        done
    (cambiar permisos: chmod a+x miscript.sh)
    2º PASO) en el fichero de reglas de rsyslog: /etc/rsyslog.d/50-default.conf
        Modificamos el archivo con : nano 50-default.conf
                añadimos esta regla:
                    daemon.info     /tmp/miscript.log
            grabamos cambios y reiniciar el servicio¡¡¡¡:
                    sudo systemctl daemon-reload
                    sudo systemctl restart rsyslog.service
            comprobamos el estado: sudo systemctl status rsyslog.service 
    3º PASO) ejecutamos el script: ./miscript.sh
    4º PASO) comprobamos si rsyslog a recibido los mensajes del script y los ha almacenado en fichero /tmp/miscript.sh
            tail -f /tmp/miscript.log

    miscript.sh ====> rsyslog.service recibe mensaje¿Donde lo almacena? ====> destino mensaje /tmp/milog
                cada        /etc/rsyslog.d/50-default.conf
                minuto          1º regla, la cumple ¿no?
                genera          2º regla, la cumple SI: daemon.info /var/log/milog
                mensaje      
            "[miscript.sh]" mensaje mandado por script: miscript.sh a las 2024-10-17__19:45  
        
    Para filtrar y que solo aparezcan los mensajes de mi script en el fichero(no los mensajes de todos los servicios)
        :msg, contains, "micript.sh" /var/log/milog -- forma antigua para lo tecnicos. Ir a la ruta dirigida donde se generara el archivo
        if $msg contains "miscript.sh" then /var/log/milog -- forma nueva programadores. Ir a la ruta dirigida donde se generara el archivo
        tail -f /var/log/milog

# MI VERSION
#!/bin/bash
    clear
    while true
    do
        fecha=$(date '+%Y-%m-%d__%H:%M') # poner la comilla invertida es mas eficaz que el $(.....)<=== subshell
        echo "..mandando mensaje al log a las $date..."
        logger -p daemon.info -t "[miscript.sh]" "mensaje mandado por script: miscript.sh a las $fecha..."
        sleep 1m
    done

# /etc/rsyslog.d/50-default.conf -- Hacede a este archivo
# -- nano 50-default.conf -- Hacede al archivo mediante este editor de textos
# daemon.info /tmp/miscript.log -- Ingresa esta regla en el fichero 50-default.conf
# if $msg contains "miscript.sh" then /var/log/milog -- Introducelo en el archivo 50-default.conf. Filtra mensajes para que solo aparezca los del Script
# Guardar los cambios y reiniciar el servicio
    # sudo systemctl daemon-reload
    # sudo systemctl restart rsyslog.service -- reinicia el servicio
    # sudo systemctl status rsyslog.service -- verifica el estado del servicio
# Ejecutamos el script Logs.sh
# tail -f /tmp/miscript.log -- vemos el texto del script

# PRACTICA
   #!/bin/bash
# rsyslog templates -- plantillas visitar la pagina
# crear plantillas rsyslog almacene el mensaje que manda el script 
# y añada la direccion IP donde se manda el mensaje y el nombre del equipo
# Buscar rsyslog templates

# COPIAR EN EL FICHERO RSYSLOG ETC/RSYSLOG.D/50-DEFAULT.CONF
# template(name="customFormat" type="string" string="%TIMESTAMP% %hostname%: %msg%\n")

clear

    while true
    do
        IP_LOCAL=$(hostname -I | awk '{print $1}') # GENERAR LA IP
        logger -t miscript.sh "IP: $IP_LOCAL - Este es un mensaje desde el script"
        sleep 1m
    done

PRACTICA
creamos un Script para que genere mensajes aleatorios en fichero /tmp/milog.log
#!/bin/bash
clear
echo "llenando el fichero /tmp/milog.log"
[ ! -e /tmp/milog.log ] && touch /tmp/milog.log
while true
do
    clear
    ls -lh /tmp/milog.log*
    dd if=/dev/urandom bs=1024 count=10000 | tr -dc '[a-zA-Z0-9]' >> /tmp/milog.log
    sleep 1s
done

- creamos reglas de rotacion para este fichero: /etc/logrotate.d ----> fichero milog

/tmp/milog.log
{
    su root root
    rotate 3
    size 5M
    compress
    missingok
    notifempty
    postrotate
       [ -e /tmp/milog.log.3.gz ] && cp /tmp/milog.log.3gz /tmp/BACKUP___MILOG.3.gz.$(date '%Y-%m-%d__%H:%M')
    endscript
}


- en dos terminales:
      1º terminal lanzais script
      2º terminal sudo logrotate -f /etc/logrotate.d/milog -- rota solo el fichero indicado. Ejecutarlo 3
