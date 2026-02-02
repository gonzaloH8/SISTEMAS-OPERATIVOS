
# ====================PRACTICA=======================
# Introduce el nombre de tu usuario en el fichero /etc/cron.deny
#    sudo /etc/cron.deny <== en una linea metes el nombre de tu usuario
# Comprueba el contenido del fichero: cat /etc/cron.deny
# Intenta programar una tarea cron con ese usuario:
#  cron -e <== te abrira el editor. intenta meter una tarea, cuando la intentas almacenar no te permitira GUARDAR LOS CAMBIOS
#  */2 * * * * touch /tmp/prueba_TAREA_CRON_ `date +\%Y'-'\%m'-'\%d__\%H':'\%H'`
# Introduce ahora el nombre de tu usuario en fichero /etc/cron.allow
#  sudo /etc/cron.allow <= en una linea metes nombre de tu usuario
#Comprueba el contenido del fichero: cat /etc/cron.deny
#                                    cat /etc/cron.allow
# Intenta programar la tarea cron con ese usuario¿deja?
# si te deja en el directorio /tmp va a crear cada 2 minutos una serie de ficheros llamados:
#    prueba_TAREA_CRON

# ==================PRACTICA====================
# #!/bin/bash
# clear
# tengo que programar asi el script en crontab -e: 
# */5 15-17 * * 1,2,4 /home/gonzalo/Escritorio/Practicas/cron_tarea.sh
# se ejecuta cada 5min, de 15 a 17h los LUNES,MARTES,JUEVES(cualquier mes y todos los dias del mes, del 1 al 31)
# lo que hace es copiar el directorio "Documentos" del usuario gonzalo en /tmp
# */5 15-17 * * 1,2,4 cp -r /home/profesor/Documentos/* /tmp

# ===============PRACTICA==================
# Programar tarea para que se ejecute a las 23:00, cada 15 dias siempre y cuando sea viernes, cada dos meses
# Minutos/00, Horas/23, Dia_Mes/1-31/15, Mes-1-12/2, Dia_Semana 5
# Programar tarea para que se ejecute cada dos horas, todos los dias, todos lo meses, solo LUNES Y VIERNES
#  *-*/2-*-*-1,5
# Programar tarea para que se ejecute cada 15 minutos, cada hora, todas los meses, solo de LUNES A VIERNES
# */15-*-*,*,1-5

# Como usuario normal, como creo TAREAS PROGRAMADAS (ficheros crontab usuarios):
# las tareas del sistema /etc/crontab, solo puede modificar /añadir/quitar tareas el roat (ver permisos)

# 17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly -- si cd / && acaba bien ejecuta el siguiente comando
# 25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
# 47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
# 52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
