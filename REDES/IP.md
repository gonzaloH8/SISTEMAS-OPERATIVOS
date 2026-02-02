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


# IP
- Direccionamiento IP: es la parte encargada de asignar de forma correcta a cada equipo una dirección IP, de forma que los equipos puedan comunicarse correctamente entre sí.
  - Al crear una VPC, se le asigna un bloque IPv4 de CIDR (un rango de direcciones IPv4 privadas).
  - No se puede cambiar el rango de dirección después de crear la VPC.
  - El tamaño de bloque de CIDR IPv4 más grande es /16.
  - El tamaño de bloque de CIDR IPv4 más pequeño es /28.
  - También se admite IPv6 (con un límite de tamaño de bloque diferente).
  - Los bloques de CIDR de las subredes no pueden superponerse.
- IP Pública o Externa: es la que está conectada a Internet, y es única en Internet.
- IP Privada o Interna: es la que está en la red del domicilio, con el resto de aparatos , la IP de cada aparato es distinta.
- IP Elástica: es una dirección de IPv4 estática y pública que está diseñada para el cómputo en la nube dinámico.
- IP Estática: direccion que permanece siempre igual. Ideal para un servidor web,  un servidor FTP. Se puede obtener una direccion estatica de si ISP
- Redes: perdemos dos direcciones: Dirección IP y BroadCast, teniendo disponibles 254 direcciones
- Subredes: perdemos 4 direcciones: 2 Dirección IP y 2 BroadCast, disponibles 252 direcciones
- Subredes AWS perdemos 5 direcciones, teniendo disponibles 251 direcciones.
  - Direcciones de red 
  - Enrutador local de la VPC (comunicaciones internas).
  - Resolución del sistema de nombres de dominio (DNS).
  - Uso futuro
  - Dirección de difusión de red
  - Subred Pública: tiene acceso a la puerta de enlace de internet
  - Subred Privada: no tiene acceso a la puerta de enlace de internet
- NAT: permite convertir varias direcciones IP en una sola dirección IP. Enmascara la dirección privada en una dirección pública.
- IPv4: son de 32 bits
- IPv6: son de 128 bits. Compuestas por 8 números y 4 letras. Cada grupo tiene 16 bits en formato hexadecimal. EJ: 2600:1f18:22ba:8c00:ba86:a05e:a5ba:00FF

# COMPONENTES FISICOS DE RED EN INTERNET
- Access Point: maquinas independientes conectados en red con una antena, tansmisor y un adaptador integrados.
- Router: establece la mejor ruta para permitir que los paquetes se transmitan a sus destinos. Almacena datos en las redes a la q estan conectadas y tambien se utiliza para convertir tramas de LAN a WAN
- Hub: conecta componentes LAN con protocolos identicos. Actua como repetidor, amplificando las señales.
- Bridge: conectada dos o mas host o segmentos de red juntos y opera a nivel de enlace de datos. Se funcion es la de almacenar y reenviar tramas entre los diferentes segmentos q conecta el puente.
- Gateway: Proporcionan traduccion entre tecnologias de red como la interconexion de sistemas abiertos(OSI) y el protocolo de internet(TCP/IP)
- Switch: dispositivo multipuerto q opera en el enlace de datos, pasando datos de un segmento a otro de acuerdo con la direccion MAC de destino de las tramas en la red y eliminando la conexion una vez finalizada.
- Modem: convierte señales digitales(modulaciom) en señales analogicas(desmodulacion) de direferentes frecuencias
- Brouter: combina funciones de puente y enrutador

# SEGURIDAD EN REDES
- Cortafuegos: es un software o hardware q impide el tráfico sospechoso entre o salga de una red, al tiempo que permite el paso de tráfico legítimo. Tipos:
- Control de acceso a la red(NAC): autentican y autorizan a los usuarios para determinar quien puede entrar en la red y que puede hacer dentro.
- Sitemas de deteccion y prevencion de intrusiones(IDPS): se implemente detras de un firewall para analizar el trafico entrante en busca de amenazas a la seguridad. Son eficaces contra los ataques de fuerza bruta(DoS, DDoS)
- Redes privadas virtuales(VPN): red privada virtual, se utiliza para proteger la identidad de un usuario cifrando sus datos y enmascarando su direccion IP y ubicacion. Se conecta a un servidor seguro que se conecta a Internet en su nombre
- Zero Trust Network Acess(ZTNA): los usuarios estan limitados a usar solo los recursos autorizados y deben ser controlados cada vez que acceden a un nuevo recurso.

# VPC
Es una red virtual que está aislada de forma lógica de otras redes virtuales en la nube de AWS. Está dedicada a su cuenta. pertenecen a una única región de AWS y puede abarcar varias zonas de disponibilidad.
Tabla de Enrutamiento(21): contiene un conjunto de reglas (o rutas) que puede configurar para dirigir el tráfico de red de su subred.

ESTRUCTURA DE UNA IP
192.168.1.10/24
Cada grupo consta de 8 bits
/24 indica la máscara de la dirección IP. A su vez indica en la direccion cual es para equipos y cual para dirección

TABLA DE DIRECCIONES IP
Clase A ==> 10.X.X.X ==> Nº Redes 1
Clase B ==> 172.16.X.X A 172.31.X.X ==> Nº Redes 16
Clase C ==> 192.168.X.X A 192.168.255.X ==> Nº Redes 256

# OPERACIONES IP
    Cogiendo la dirección ip y la máscara, se comparan los valores y si son iguales son 1 y si son distintos 0
    192.168.1.10/24
    11000000 - 11010100 - 00000001 - 1101010 IP
    111111111 - 111111111 - 111111111 - 0000000 => Mascara 24
          AND(True 1- False 0)
    11000000 - 11010100 - 00000001 - 0000000 => Identificador de Red
    
    192.168.1.10/25
    11000000 - 11010100 - 00000001 - 11010100 => IP
    111111111 - 111111111 - 111111111 - 10000000 => Mascara 25
          AND(True 1- False 0)
    11000000 - 11010100 - 00000001 - 10000000 => Identificador de Red 128
    192		168		1		128

Pág: 44 SEGURIDAD 50 
127.0.0.1:80 => Permiten el acceso HTTP entrante desde todas las direcciones IPv4
127.0.0.1:443 => Permiten el acceso HTTPS entrante desde todas las direcciones IPv4
127.0.0.1:22 => Permiten el acceso SSH entrante a las instancias de Linux  desde direcciones IP IPv4 de su red (a través de la puerta de enlace de Internet)

# REDES PUBLICAS
  Clase A: 10.0.0.0
  Clase B: 172.16.0.0 a 172.32.0.0
  Clase C: 192.168.0.0 a 192.168.0.0

# REDES PRIVADAS

