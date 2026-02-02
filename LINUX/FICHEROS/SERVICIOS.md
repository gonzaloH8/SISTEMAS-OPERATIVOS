# ENLACES
- [UFW ampliado](https://computernewage.com/2014/08/10/como-configurar-el-firewall-ufw-en-ubuntu/)
- [MANUAL](https://www.linuxtotal.com.mx/index.php?cont=info_admon_003#google_vignette)
   
# MOSTRAR DETALLES FICH.UNIDAD DE UN SERVICIO
El servicio de LOGS del sistema, se llama ryslog.service
    systemctl cat rsyslog.service
estructura de fich.unidad de un servicio: esta formado por secciones [nombre_seccion] y dentro de cada seccion: variable=valor
En un servicio ES OBLIGATORIO que tengan las secciones: 
    - [Unit] establece una descripcion, docmentacion, usuario que lo creo,... el servicio
    - [Service] especificas el tipo de servicio(ejecutable,variables de entorno,como reiniciar de nuevo el servicio,permisos,...)
    - [Install] se especifica las dependencias que necesita el servicio para iniciarse(p.e si necesita de otros servicios, de algun target, timers, sockets)
Ejemplo ver: /lib/systemd/system/cron.service
  
# COMANDOS
    GLOBALES
    man systemd.service -- vemos la ayuda del servicio
    UFW: servicio que se encarga de gestionar el cortafuegos del kernel en Ubuntu
    CRON: servicio de editor de texto
    ssh: servicio

    systemctl list-units --type=service  -- Para ver los fich. de unidad de un determinado tipo, p.e listar todos los servicios cargados(disponibles) en el TARGET actual(multi-user.target)
    systemctl list-units --type=target -- Para ver los targets(servicios,sockets o conexiones,paths o señales)
    systemctl cat nombre_servicio.service -- para ver como esta configurado un servicio
    sudo systemctl status -- nos permite ver todos los servicios cargados en tu sistema
    sudo systemctl status nombre_servicio -- nos permite conocer el estado de ufw, si esta activo en memoria o no.
    sudo systemctl start nombre_servicio -- nos permite iniciar el servicio. Tiene que estar habilitado, si no no lo reconocera
    sudo systemctl stop nombre_servicio -- nos permite detener el servicio. Deshabilitas
    sudo systemctl restart nombre_servicio -- nos permite reiniciar el servicio
    sudo systemctl is-enabled nombre_servicio -- comprueba si el servicio esta configurado para iniciarse en cada arranque o no
    sudo systemctl enable nombre_servicio -- permite habilitar un servicio
    sudo systemctl disable nombre_servicio -- permite deshabilitar un servicio
    
    sudo service --status-all -- permite ver un listado plano de todos los servicios
    sudo service --status-all | grep + -- permite ver los servicios que esten iniciados
    sudo service ufw status -- nos permite ver el estado de un servicio en concreto
    sudo service ufw start -- permite iniciar el servicio
    sudo service ufw stop -- permite detener el servicio
    sudo service ufw restart -- permite reiniciar el servicio

    sudo /ent/init.d/ufw status -- fichero de configuracion dentro del directorio init.d. Comprueba el estado del servicio
    sudo /ent/init.d/ufw start -- inicia el servicio
    sudo /ent/init.d/ufw stop -- para el servicio
    sudo /ent/init.d/ufw restart -- reinicia el servicio
