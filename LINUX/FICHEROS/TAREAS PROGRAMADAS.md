# ENLACES
  - [GENERADOR DE TIEMPO ](https://crontab-generator.org/)
  - [GENERADOR DE TIEMPO ](https://crontab.guru/)
  - [GENERADOR DE TIEMPO ](https://www.freeformatter.com/cron-expression-generator-quartz.html)
  - [DOCUMENTACION](https://geekland.eu/planificar-tareas-con-cron-y-anacron-en-linux/)
  - [MANUAL](https://www.linuxtotal.com.mx/?cont=info_admon_006)

# ESTRUCTURA DE CRON.SERVICE
  **MINUTOS:** valor 0-59 representa el minuto en el cual quieres que se ejecute la tarea
  **HORAS:** valor 0-23, representa la hora en el cual quieres que se ejecute la tarea
  **DIA_MESs:** valor 1-31, representa los dias del mes en el cual que se ejecute la tarea
  **MES:** valor 1-12, representa el mes en el cual quieres que se ejecute la tarea
  **DIA_SEMANA:** 0(Domingo)-6, representa el dia_semana en el cual quieres que se ejecute la tarea
  [usuario_ejecuta_tarea]
  comando(s)_a_ejecutar
ejemplo:
25 8,15,23 1-31/3 1,6,7 * comando a ejecutar

# COMANDOS
    Formarto: MINUTOS  -  HORAS  -  DIA_MES  -  MES  -  DIA_SEMANA
    * : Este valor representa todos los valores para ese campo(se ejecutara de forma aleatoria entre los valores de ese campo)
    , : Este valor indica que los representados son incluidos. 1,5
    - : Este valor indica que los reprentados son rangos: 1-5
    / : Rangos de incremento: valorIncial/Incremento 1/5
    run-parts -- Aplica al directorio /etc/cron.hourly la funcionalidad de ejecutar todo aquel archivo ejecutable que se encuentre en su interior
    test -x ruta(pregunta si existe el fichero que le sigue y este tiene permisos de ejecucion, si es true se ejecuta)
    El contenido del fichero de tareas programadas /etc/crontab
    crontab -e          -- Ejecuta nano donde podras hacer las tareas programadas
    crontab -l          -- Te muestra el contenido del fichero de programacion de tareas
    crontab -ir         -- Pregunta antes de borrar, si no existe -i la borra si preguntar
    crontab -r          -- Borra el fichero de programacion de tareas  
    crontab -t          -- Permite ver los errores(debug)
    crontab -u usuario  -- permite manejar los crontrab de otros usuarios
    crontab -h          -- permite generar una serie de cadenas de teto ya configuradas

# VARIABLES RESERVADAS
    @reboot: ejecuta una vez y nada mas iniciarse el equipo
    @yearly -- ejecuta una sola vez al año: 0 0 1 1 *
    @monthly -- ejecuta una vez al mes y el primer dia 0 0 1 * *
    @weekly -- todas las semanas, el primer minutos de la primera hora de la semana 0 0 * * 0
    @daily -- todos los dias a la 12 de la noche 0 0 * * *
    @midnigth -- tiene el mismo efecto que el anterior
    @hourly -- todas las horas durante su primer minuto 0 * * * *

# DENEGACION DE PERMISOS SOBRE LAS TAREAS PROGRAMADAS
    sudo nano /etc/cron.deny
    nombre_usuario -- le deniega permisos sobre cron
    all -- deniega permisos a todos los usuarios que no sean administradores
    sudo service cron restart -- reiniciamos cron para confirmar que se guardaron los cambios

# PERMISOS SOBRE LAS TAREAS PROGRAMADAS
    sudo nano /etc/cron.allow
    nombre_usuario -- le deniega permisos sobre cron
    all -- deniega permisos a todos los usuarios que no sean administradores
    sudo service cron restart -- reiniciamos cron para confirmar que se guardaron los cambios

SI UN USUARIO no aparece en ninguno de los ficheros, depende de la distrubucion linux(en ubuntu, por defecto ES PERMISIVA y si le deja programar tareas) 
SI UN USUARIO APARECE EN ABMOS, por politica de cron.allow directamente se le permite

# HERRAMIENTAS PARA CRON
  - **Crontab Guru:** editor rapido y sencillo. Facilita alertas en tiempo real acerca de errores o incovenientes. Ofrece consejos y trucos para dudas.
  - **Cron Job Generator:** podemos crear y programar comandos para que se ejecuten a una hora determinada.
  - **EasyCron:** nos permite programar tareas para llamar a URL especificas en diferentes intervalos de tiempo y momentos concretos. Nos facilita un panel de usuario y programar labores de acuerdo a fecha y hora.
  - **Cron Maker:** aplicacion completa
  - **Logs en Cron:** nos da la posibilidad de almacenar en un archivo. /vat/log/syslog

# HERRAMIENTAS PARA ANACRON
Es un servicio que surgio como respaldo del servicio CRON, se penso para ejecutar las tareas que el servicio CRON no ha podido lanzar(por caidas del sistema, fallos en el servicio CRON.SERVICE,...)
El servicio anacron: anacron.service
Para ver el estado: systemctl status anacron.service
anacron.service <=== se activa cada HORA, el resto del tiempo esta desactivado. Solo existe un fichero, usable para todos los usuarios /etc/anacrontab
/var/spool/anacron/identificador <=== aparecera la fecha de ejecucion por ultima vez la tarea: YYYYMMDD
Para saber si toca ejecutar, consulta fichero: /var/spool/anacron/ <----cron.daily contiene la fecha actual hace la diferencia dentre fechaActual-fechaContenida = 0

    sudo nano /etc/anacrontab
    diaria: 1 o @daily
    semanal: 7 o @weekly
    mensual: 30 o @monthly
    periodica: 2

    retardo_ejecucion: numero entero = minutos
    identificador: nombre_cualquiera(identificable en los logs)
    comando: tarea a ejecutar
    
    Ejemplo: 7 10 backup.weekly /bin/bash /home/joan/scripts/backup.sh
