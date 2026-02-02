# COMANDOS MAS USADOS
    ping -n 5 8.8.8.8 -- representa el DNS de Google. Nos permite saber si funciona correctamente la conectividad
    ipconfig | find "IPv4" -- nos muestra por salida todos los adaptadores de red instalados en el equipo
    ipconfig /all | find "Descripción" -- nos muestra la descripcion de los adaptadores de red instalados en el equipo
    hostname | > echo %userdomain%-- muestra el nombre del host actual
    ipconfig /all | find "Dirección física" | > getmac -- obtiene las direcciones MAC(Media Access Control) que tienen asociadas los adaptadores de red.
    ssh -- herramienta para iniciar sesión en una máquina remota y para ejecutar comandos.
    scp -- copia archivos a través de una conexión de red segura y cifrada.

  # COMANDOS ESPECIALES
    > arp /a -- contiene una o más tablas que se utilizan para almacenar direcciones IP y sus direcciones físicas Ethernet o Token Ring resueltas.
    nslookup -- comando-nombre_computadora|ip-nombre|direccion_servidor. Ej: > nslookup openwebinars.net 8.8.8.8
    nbtstat -- Muestra las estadísticas del protocolo NetBIOS sobre TCP/IP (NetBT), las tablas de nombres NetBIOS para la computadora local, las computadoras remotas y la caché.
    netstat -- Muestra las conexiones TCP activas, los puertos en los que la computadora está escuchando, las estadísticas de Ethernet, la tabla de enrutamiento de IP, las estadísticas de IPv4 (para los protocolos IP, ICMP, TCP y UDP) y las estadísticas de IPv6 (para IPv6, ICMPv6, TCP sobre IPv6 y UDP sobre protocolos IPv6)
    net use -- conecta, elimina y configura conexiones a recursos compartidos, como unidades asignadas e impresoras de red.
    shutdown  -- permite apagar o reiniciar computadoras locales o remotas
    > tracert -- rastrea rutas hots
    > pathping -- proporciona información sobre la latencia de red y la pérdida en saltos intermedios entre un origen y un destino
    telnet -- Abrir comunicación con un equipo remoto que ejecuta el servicio del servidor telnet
    route -- Manipula tablas de enrutamiento de red
    netsh -- permite, ya sea de forma local o remota, mostrar o modificar la configuración de red de una computadora en ejecución.
    winrm -- Herramienta de la línea de comandos de Administración remota de Windows.
    wget -- puede seguir los enlaces HTML en una página web y descargar los archivos de forma recursiva
    > ftp -- Transfiere archivos hacia y desde una computadora que ejecuta un servicio de servidor de Protocolo de transferencia de archivos (FTP)
