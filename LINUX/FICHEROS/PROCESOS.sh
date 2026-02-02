# ENLACES
 - [MANUAL](https://www.linuxtotal.com.mx/index.php?cont=info_admon_012)

# ESTADO DE EJECUCION DE UNA APLICACION
    CTRL + Z permite pausar 
    nombre_aplicacion -- ejecuta la aplicacion en primer plano
    nombre_aplicacion & -- ejecuta la aplicacion en segundo plano
    nohup nombre_aplicacion & -- version mas corta
    bg %numero_id_comando_background -- permite ejecutar la aplicacion en 2º plano
    jobs -- permite ver las aplicaciones en 2º plano
    fg %1 -- vuelve la aplicacion al 1º plano
    top -- permite ver los procesos en tiempo real
    trap comando_ejecutar nombre_señal -----> permite ejecutar un comando/s cuando se produce una determinada señal  
    app firefox: /usr/bin ---> firefox 7.7KB --> BCP-firefox

# PROCESOS
    pidof nombre_app -- te muestra los PID de los threads del BCP de esa aplicacion
    sudo pidof nombreDelProceso -- permite conocer el PID del proceso indicado 
    sudo pstree -- ves toda la informacion de los procesos y subprocesos en forma de arbol
    sudo top -- muestra en tiempo real los procesos en ejecucion
    sudo apt install htop -- version mejorada de top
    
    Opciones de selecion de procesos:
    ps --help all | less -- te muestra toda la ayuda de procesos
    ps -p pid -- informacion del proceso con ese pid
    ps -C app -- informacion del proceso con ese nombre
    ps -u Usuario -- informacion de TODOS LOS PROCESOS que ha lanzado ese usuario
    ps -g grupo -- informacion de TODOS LOS PROCESOS que ha lanzado ese grupo
    ps -e -- te muestra procesos y subprocesos
    ps -axjf -- muestra la lista de procesos de forma jerarquica
    
    Opciones formato de informacion de salida del proceso:
    sudo ps -- te muestra una foto con todos lo procesos ejecutandose en tu sistema e informacion sobre ellos
    ps -f -- full-format, te da esta info: PID, PPID, usuario, grupo, %cpu, tiempo de ejecucion, estado, ejecutable
    ps -ef te muestra procesos y subprocesos con mayor informacion
    ps -o opcion1,opcion2,opcion3,... -- sirve para personalizar la informacion del BCP a mostrar de cada proceso(man ps)
    ps -u profesor -o pid,ppid,%cpu,%mem,status,pri,nice,cmd -- mostraria procesos del usuario PROFESOR, y de cada proceso muestro esta info

    TODA LA INFORMACION QUE MUESTRA UN PROCESO
     %C     pcpu     %CPU -- hilos que esta usando el proceso en la cpu
     %G     group    GROUP -- grupo al que pertenece el usuario
     %P     ppid     PPID -- Identificativo del padre proceso
     %U     user     USER -- usuario que ha ejecutado la aplicacion
     %a     args     COMMAND
     %c     comm     COMMAND
     %g     rgroup   RGROUP
     %n     nice     NI -- bondad del proceso
     %p     pid      PID -- identificador del proceso
     %r     pgid     PGID -- identificador de grupo de proceso
     %t     etime    ELAPSED
     %u     ruser    RUSER
     %x     time     TIME -- te muestra el inicio de ejecucion de la aplicacion
     %y     tty      TTY -- terminal asociada al proceso. Si no existe aparece ?
     %z     vsz      VSZ -- tamaño de memoria virtual de un proceso

    nice -n + 1 firefox -- lanza la aplicacion con la prioridad que tu indiques en primer plano
    renice -n valor_bondad -p pid_proceso -- cambias el valor de la prioridad (alterando su bondad) en PROCESOS EN EJECUCION
   
  # SEÑALES
    SIGHUP (1): cuelgue del terminal o muerte del proceso controlador
    SIGTERM (15): mata el proceso permitiéndole terminar correctamente
    SIGKILL (9): mata el proceso sin permitirle terminar
    SIGSTOP (19): para el proceso
    SIGCONT (18): continúa si parado
    SIGINT (2): interrupción de teclado (Ctrl-C)
    SIGTSTP (20): stop de teclado (Ctrl-Z)
    SIGQUIT (3): salida de teclado (Ctrl-\)

    sudo kill PID-delproceso o kill -9 PID-delproceso -- permite matar le proceso indicado
    sudo killall nombreDelProceso -- puedes matar el proceso conociendo el nombre
    kill -l -- ves todos las señales de kill
    sudo kill -9 -p `pidof firefox`-- cierra la aplicacion
    sudo kill -9 -p 1 -- borra el proceso principal preguntando
    kill -s SIGTERM `pidof firefox`
    init 0 -- borra el proceso principal sin preguntar(no hacer nunca)

# CHRT
    chrt -- permite ver caracteristicas de los algoritmos de planificacion del scheduler; tambien permite cambiar procesos de un algoritmo a otro
    chrt -p num_prioridad -- muestra la prioridad de la aplicacion
    chrt -m -- ver algoritmos y sus prioridades
    chrt -f --pid 10 75 -- cambiar un proceso a SCHED_FIFO y que tenga prioridad 10, para BCP con pid del proceso 175
