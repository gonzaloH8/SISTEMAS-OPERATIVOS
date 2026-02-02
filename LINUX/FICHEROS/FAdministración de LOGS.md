# ADMINISTRACION LOGS SISTEMA: rsyslog(remote system logger daemon)
Un LOG es un fichero(por defecto, no tiene por que, pueden almacenarse en una BD) donde el sistema operativo, va a ir registrando aspectos de su funcionamiento en tiempo real; se registran acciones como: 
- Inicio sesion de usuarios, cierre sesion, intento de conexion, cambio de contraseña,....
- Aspectos del funcionamiento de servicios (si se modifica un servicio, si se para, si se deshabilita, si el servicio al funcionar quiere registrar su accion...)   
- Aspectos del hardware (drivers dispositivos q no funcionan, deteccion de dispositivos montados,...)    
                                
# COMO FUNCIONA EL SERVICIO
INPUT-MODULES(modulos de entrada de registros)
OUTPUT-MODULES (rsyslog.service) fichero de configuracion de reglas de registro
SERVIDOR-EXTERNNO (modulos de registro de mensajes) ficheros LOG, BD-mysql                                                   

# ARCHIVO EN CUARENTENA
- Como input-modules siempre por defecto van a ser otros servicios los q mandan mensajes a rsyslog para q los registre en los LOG; rsyslog a estos servicios los clasifica por grupos:
    - servicios globales:            grupo daemon
    - servicios de autentifcacion:   grupo auth
    - servicios de prog.tareas:      grupo cron
    - servicios de impresion:        grupo lpt
- Los mensajes originados por estos grupos se almacenan en un OUTPUT-MODULE determinado en funcion del fichero de configuracion de reglas de rsyslog:  **/etc/rsyslog.conf**
- Como OUTPUT-MODULE son el destino donde rsyslog va a almacenar los mensajes q mandan estos servicios, por defecto siempre en ficheros LOG (se suelen almacenar en **/var/log/**  
- rsyslog almacena los mensajes en los output-modules en funcion de TEMPLATES (plantillas); por defecto tiene definida una plantilla general, pero puedes personalizarlas y usarlas
- Como OUTPUT-MODULE puedo usar aparte de ficheros LOG lo siguiente: (man rsyslog.conf)
  - @x.y.z.w[;nombre_plantilla_personalizada] <--- mandas los mensajes al servidor con ip: x.y.w.z por TCP
  - @@x.y.z.w[;nombre_plantilla_personalizada] <---mandas los mensajes al servidor con ip: x.y.w.z  por UDP (mas rapida q tcp, pero menos segura)
  - ^/ruta/nombre_script <------- mandas los mensajes a ese script para q los procese... (los recibe como parametros)                      
  - | /ruta/comando ... <------- mandas los mensajes mediante esa tuberia a ese comando...              
  - stop <--------------------- no se registran en ningun lado, se descartan
  - :om-nombre_modulo, parametros_config_modulo <---- manda mensajes a ese modulo con esos parámetros                                  
            
# FICHERO CONFIGURACION RSYSLOG:
Fichero de texto plano, se divide en 3 secciones:
- 1º Seccion se definen los im-modules y om-modules con los q va a trabajar el servicio rsyslog
- 2º Seccion (directivas globales) o parametros de funcionamiento del servicio:
    $instruccion  valor
    $instruccion  valor
    ....
- 3º Seccion reglas de registro de mensajes por parte del servicio o vienen definidas por la directiva:    
        $IncludeConfig  /ruta/directorio/ficheros.config
                        ----------------
                           |---> reglas de registro

consulta fichero: /etc/rsyslog.conf ===> $includeConfig /etc/rsyslog.d/*.conf -- Este parámetro permite incluir otros archivos en el archivo de configuración principal. lee 50-default.conf 

# VARIABLES DE RSYSLOG
    $includeConfig -- directorio

# FORMATO DE LAS REGLAS DE REGISTRO                                  
     origen_im[, origen2_im,...].importancia_mensaje [;...] 

    REGLAS PREDETERMINADAS EN EL SISTEMA
    filtro(origen)               acciones(destinos) lugar donde se registran los mensajes
    kern.*				        -/var/log/kern.log <=== NO LA CUMPLE(filtra mensajes originados por kernel)
    mail.*			        	-/var/log/mail.log<==== NO LA CUMPLE(filtra mensajes originados por serv.mail)
    mail.err        			/var/log/mail.err
    *.*;auth,authpriv.none		-/var/log/syslog<==== SI LA CUMPLE(filtra mensajes originados por cualquier servicio)
                                                        todos los mensajes originados por el servicio cron.service 
                                                        se ALMACENAN en fichero /var/log/syslog
    cron.*                      /var/log/cron   <====== SI LA CUMPLE(filtra mensajes originados por cron.service)
                                                        todos los mensajes originados por cron.service 
                                                        se ALMACENAN en fichero /var/log/cron                                 
    auth,authpriv.*			    /var/log/auth.log <==== no la cumple(filtro de mensajes originados serv.autentificacion)
    *.emerg				        :omusrmsg:*(usuario)   <===== SOLO SE CUMPLE (si el mensaje producido por el servicio tiene la importancia de "emerg" 
                                                        y lo registra en el modulo de salida "outmsg", manda mensaje al terminal)    
                                                        importancia_mensaje:  emerg > alert > crit > err > warn > notice > info > debug
                                                        
    cron.service(ejecuta un programa) ===> rsyslog.service(lo recibe) ===> /var/log/fichero.log -- guarda lo recibido por el rsyslog.service(mensajes de ejecucion)                                    
                                                                                                                                                               
    Ejemplo:
        *.* ;             auth,authpriv.none                        -/var/log/syslog
         |                         |                                         |         
        todos              salvo (.none)                         se registran en este fichero LOG
        los                mensajes grupo servicios              el [-] delante del fichero significa q los mensajes
        servicios          de autentificacion                    no se registran de forma inmediata en el fichero sino
        q generan                                                q se almacenan temporalmente en buffer de memoria RAM
        cualquier                                                y luego se volcaran mas adelante
        mensaje

# COMANDOS
    /etc/rsyslog.d/ -- directorio donde se importan las reglas
        20-ufw.conf (reglas de registro para servicio firewall)
        50-default.conf (reglas resto de servicios) -- reglas de servicio y destino de servicio(donde se guardan las acciones del servicio)
    servicio -- cron,
    destino (/var/log/nombre_fichero) -- fichero donde se guardaran los mensajes de accion efectuados por el servicio
    rsyslog.service -- encargado de la gestion de los LOGS
    sudo systemctl restart rsyslog.service -- reinicio del servicio rsyslog
    systemctl status rsyslog.service -- vemos el estado del servicio

    logger

# DEFINICION DE PLANTILLAS DE FORMATO DE SALIDA DE MENSAJES
- [PLANTILLAS](https://www.rsyslog.com/doc/configuration/templates.html)
- [PROPIEDADES DE RSYSLOGpropiedades de rsyslog](https://www.rsyslog.com/doc/configuration/properties.html#message-properties)
- [FORMATOS FECHA](https://www.rsyslog.com/doc/configuration/property_replacer.html#property-options)
- [VER](https://www.rsyslog.com/doc/configuration/properties.html#message-properties)
Para crear una plantilla, la forma mas rápida es definirla en el fichero de /etc/Rsyslog.conf y después ya usarla con el nombre que la identifica en el fichero de reglas. Para definirla, 2 formas:  
- 1º forma tradicional o LEGACY:
    $template TEMPLATE_NAME,"text %PROPERTY% more text" donde:
        - $template es la directiva de plantilla que indica que el texto que la sigue define una plantilla.
        - TEMPLATE_NAME es el nombre de la plantilla. Utilice este nombre para hacer referencia a la plantilla.

Todo lo que se encuentre entre las dos comillas (“…”) es el texto de la plantilla real. Dentro de este texto, se pueden utilizar caracteres especiales, como \n para nueva línea o \r para retorno de carro. Otros caracteres, como % o ", deben ser escapados si desea utilizar esos caracteres de forma literal.
El texto especificado entre dos signos de porcentaje (%) especifica una propiedad que le permite acceder a contenidos específicos de un mensaje de syslog.(son variables predefinidas:

**SINTAXIS 1º**
    - Propiedades
        - msg: almacena el mensaje generado por el servicio
    - Operadores
        - contains: chequea si en la propiedad contiene el valor q pones
        - isequal: chequea si la propiedad es exactamente igual al valor
        - startswith: chequea si la propiedad comienza con el valor
        - regex: chequea si la propiedad cumple con el patron indicado

    :propiedad, [!]operador,         valor                   Fichero de salida
        |           |                  |                              |
      :msg,     contains,   "authentication failure"    /var/log/sesiones_fallidas.log -- forma de tecnico de sistemas
    -----------------------------------------------     -------------------------------
        \--si el mensaje generado por                     \--> se registra en este fichero
          algún servicio contiene
          "authentication failuer"
    if $msg contains "miscript.sh" then /var/log/milog  -- forma de programador  
          
**SINTAXIS 2º**
- TEMPLATE
    - name: especifica el nombre de la plantilla. Debe ser unico
    - type: especifica el tipo de plantilla    
        - list:
        - subarbol: útil para salidas que saben cómo procesar la estructura jerárquica, como ommongodb. template(name=”tpl1” type=”subtree” subtree=”$!”)
        - string: parámetro obligatorio string , que contiene la cadena de plantilla que se aplicará
        - complements: la plantilla se genera mediante un complemento (que se denomina "strgen" o "generador de cadenas"). El formato es fijo a medida que se codifica, es inflexible. 
    - constant: se utiliza para imprimir texto literal, pensada para la salida de texto
        - valor: el valor constante a utilizar
        - outname: el nombre del campo de salida (para salidas estructuradas)
        - formato: puede estar vacío o ser jsonf
    - PROPERTY
        - name: el nombre de la propiedad a la que se accederá
        - outname: el nombre del campo de salida (para salidas estructuradas)
        - dateformat: el formato de fecha a utilizar
        - date.inUTC: la fecha se mostrará en UTC
        - caseconversion: permite convertir el texto a mayúsculas y minúsculas. Los valores admitidos son “lower” y “upper”
        - controlcharacters: especifica cómo manejar los caracteres de control. Los valores admitidos son “escape”(los escapa), “space”(reemplaza por un solo espacio), y “drop”(elimina de la cadena).
        - securepath: se utiliza para crear rutas de acceso adecuadas para su uso en plantillas de archivos dinámicos. Los valores admitidos son “drop” y “replace”.
        - Format: especifica el formato en función de un campo. Los valores admitidos son:
            - “ csv ”: para usar cuando se generan datos csv
            - “ json ”: que formatea el contenido json correctamente (pero sin un encabezado de campo)
            - “ jsonf ”: que se formatea como un campo json completo
            - “ jsonr ”: que evita el doble escape del valor pero lo hace seguro para un campo json
            - “ jsonfr ”: que es la combinación de “jsonf” y “jsonr”.
        - position.from: obtiene la subcadena a partir de esta posición (1 es la primera posición)
        - position.to: obtiene la subcadena hasta esta posición. 
        - position.relativeToEnd: la posición de origen y destino es relativa al final de la cadena en lugar del inicio habitual de la cadena.
        - fixedwidth: cambia el comportamiento de position.to para que rellene la cadena de origen con espacios hasta el valor de position.to si la cadena de origen es más corta. “on” o “off”
        - compressspace: comprime varios espacios (carácter US-ASCII SP) dentro de la cadena en uno solo. position.from y position.to NO se ven afectadas por esta opción
        - field.number: obtener la coincidencia de este campo
        - field.delimiter: valor decimal del carácter delimitador para la extracción de campo
        - regex.expression: expresión a utilizar
        - regex.type: ya sea ERE o BRE
        - regex.nomatchmode: qué hacer si no tenemos ninguna coincidencia
        - regex.match: coincidencia para usar
        - regex.submatch: subcoincidencia a utilizar
        - droplastlf: elimina un LF final, si está presente
        - mandatory: indica que un campo es obligatorio. Si se configura como “activado”, este campo siempre estará presente en los datos que se pasan a las salidas estructuradas, incluso si está vacío. Si se                         configura como “desactivado” (valor predeterminado), los campos vacíos no se pasarán a las salidas estructuradas. Esto es especialmente útil para las salidas que admiten esquemas dinámicos (como ommongodb).
        - spifno1stsp: opciones expertas para el procesamiento de plantillas RFC3164
        - datatype: SOLO para el formato “jsonf”; permite configurar un tipo de datos Los mensajes de registro se registran como tipos de datos de cadena de forma nativa.
              Por lo tanto, cada propiedad dentro de rsyslog se basa en cadenas. Esta configuración, en modo jsonf, permite configurar un tipo de datos deseado. Los tipos de datos admitidos son:
            - number: el valor se trata como un número JSON y no está entre comillas. Si la propiedad está vacía, se genera el valor 0.
            - string: el valor es una cadena y está entre comillas
            - auto: el valor se trata como un número si es numérico y como una cadena en caso contrario.
            - bool: el valor se trata como booleano. Si está vacío o es 0, generará “falso”, de lo contrario, “verdadero”. Si no se especifica, se asume el tipo de datos "string".
        - onEmpty: SOLO para el formato “jsonf”; especifica cómo se manejarán los valores vacíos
            - mantener: emitir el elemento vacío
            - Saltar: ignora completamente el elemento, no emite nada.
            - null: emite un valor 'nulo' JSON

## LISTA
    template(name="tpl1" type="list") {
     constant(value="Syslog MSG is: '")
     property(name="msg")
     constant(value="', ")
     property(name="timereported" dateFormat="rfc3339" caseConversion="lower")
     constant(value="\n")
     }
     
## SUBARBOL
    set $!usr!tpl2!msg = $msg;
    set $!usr!tpl2!dataflow = field($msg, 58, 2);
    template(name="tpl2" type="subtree" subtree="$!usr!tpl2")

## STRING
    template(name="tpl3" type="string"
         string="%TIMESTAMP:::date-rfc3339% %HOSTNAME% %syslogtag%%msg:::sp-if-no-1st-sp%%msg:::drop-last-lf%\n"
        )

## COMPLEMENTS
    template(name="tpl4" type="plugin" plugin="mystrgen")

# COMANDOS PLANTILLAS 
    template(parametros) -- sintaxis simple. nombre y tipo
    TYPE=LISTAS
    template(name="tpl1" type="list") { -- sintaxis compleja
         constant(value="Syslog MSG is: '")
         property(name="msg") -- describe el acceso a la propiedad
         constant(value="', ")
         property(name="timereported" dateFormat="rfc3339" caseConversion="lower")
         constant(value="\n")
         }

## PLANTILLA PARA ARCHIVOS
    template(name="FileFormat" type="list") {
    property(name="timestamp" dateFormat="rfc3339")
    constant(value=" ")
    property(name="hostname")
    constant(value=" ")
    property(name="syslogtag")
    property(name="msg" spifno1stsp="on" )
    property(name="msg" droplastlf="on" )
    constant(value="\n")
    }

## VARIABLES RESERVADAS
[MENSAJES PROPIEDADES](https://www.rsyslog.com/doc/configuration/properties.html)

    %TIMESTAMP%: Marca de tiempo.
    %fromhost-ip%: La dirección IP desde donde se manda el mensaje. No funciona para host locales
    %FROMHOST%: 
    %hostname%: El nombre del equipo.
    %msg%: El contenido del mensaje enviado por el script.
    %$clientip%: Utiliza esta variable si estás recibiendo mensajes remotos y se puede obtener la IP.

# ROTACION DE LOGS
Uno de los problemas mas importantes de los ficheros LOG es el crecimiento indiscriminado de su tamaño por la cantidad enorme de mensajes q se almacenan en ellos por el servicio rsyslog.service (tanto es asi
q pueden hacer q el sistema operativo se caiga ==> (DoS attack => ataque de Denial of Service)

para evitarlo, se hace la ROTACION de estos ficheros gracias al servicio LOGROTATE.SERVICE al ver el estado del servicio, aparece como inactivo (o dead):

    systemctl status logrotate.service <------ depende de un timer
                                               de systemd q lo despierta
                                               cada cierto periodo de
                                               tiempo (1 vez al dia)
  
    systemctl cat logrotate.timer -- permite ver las directrices del logrotate.timer           
    [Timer]
    OnCalendar=daily <---- diaria
    AccuracySec=12h

 si es insuficiente, dos formas de evitarlo:
     - 1º modificas el timer y en variable OnCalendar estableces el periodo en q quieres levantar el servicio (man systemd.time)              
     - 2º programas una tarea cron donde fuerzas la ejecucion del servicio usando su ejecutable:
     
         systemctl cat logrotate.service <---- 
            [Service]
            ...
            ExecStart=/usr/sbin/logrotate /etc/logrotate.conf
                   -------------------  ------------------
                    |                            |
                  ejecutable            fichero de reglas de rotacion
                              
    ej: programamos tarea cron para q se ejecute todos los dias, meses
        del año, dias de la semana a las 15min de cada hora
        POR EL ROOT!!! meterlo en /etc/crontab:
        
        15 * * * *     root  /usr/sbin/logrotate -f    /etc/logrotate.conf

# FICHERO DE CONFIGURACION DE REGLAS DE ROTACION: /etc/logrotate.conf
(todos los comandos q aparecen en las reglas:  man logrotate.conf)
el fichero esta formado por:

    comandos para todos los logs:
    comando-global-1        weekly
    comando-global-2        su root adm
    comando-global-3        rotate 4
    ...
    /ruta/fichero1.log
    /ruta/fichero2.log
    ... {
        comando
        comando
        ...
    }

La rotación consiste en función de como esten definidas en esas reglas, ir haciendo:
rsyslog -- ejecuta mensajes y lo envia a Fichero.log
Fichero.log(alcanza el tamaño maximo)
Se vacia
Genera un fichero comprimido fichero.log.1.gz donde guarda el contenido de Fichero.log

Fichero.log(alcanza el tamaño maximo)
El fichero.log.1.gz(tiene ya el tamaño maximo)
Genera un fichero comprimido fichero.log.2.gz donde guarda el contenido de fichero.log.1.gz

... se elimina el que tenga mayor numero, por tener los mensajes mas antiguos

Hay un servicio encargado de esta rotacion (no todas las distribuciones linux lo incluyen): LOGROTATE.SERVICE
systemctl status logrotate.service ----> este servicio esta disparado por un timer(como anacron) no se ejecuta continuamente, sino q hay un temporizador (timer) q lo "despierta" o levanta
                                        TriggeredBy: logrotate.timer --> este se levanta el servicio una vez al dia de los ficheros log, pero el root puede forzar la rotacion
                                        systemctl cat logrotate.timer ===> OnCalendar: daily

Configuracion del servicio LOGROTATE.SERVICE
el servicio tiene un fichero central de configuracion: /etc/logrotate.conf (man logrotate.conf)
variable_conf_global[valor] -----> son variables que se aplican de forma indiscriminada a todos los fich.log en /etc/logrotate.conf 
weekly ---> rotacion por tiempo(a la semana, se rota)
su root adm --> Usuario propietario(root) grupo propietario(adm) de los ficheros rotados 
rotate 4 --> numero de rotacion definida por defecto
create ----> en cada rotacion, vacia el original->borra fichero-->crea el fichero de nuevo

Contenido de rsyslog.conf

    /var/log/syslog
    /var/log/mail.info
    /var/log/mail.warn
    /var/log/mail.err
    /var/log/mail.log
    /var/log/daemon.log
    /var/log/kern.log
    /var/log/auth.log
    /var/log/user.log
    /var/log/lpr.log
    /var/log/cron.log
    /var/log/debug
    /var/log/messages
    {
    	rotate 4 -- numero de rotacion de ficheros
        size 10M -- rota por tamaño maximo del archivo
    	weekly -- rota por semana
    	missingok -- si falta alguno fichero intermedio, lo rota igual
    	notifempty -- si el log original esta vacio, evita la rotacion
    	compress -- comprime los ficheros rotados gz(ficheros comprimidos de Linux)
    	delaycompress -- el primer fichero rotado no lo comprime, empieza a comprimir a partir del 2
    	sharedscripts -- solo ejecuta los comandos del posttrotate una vez
    	postrotate ---- comandos o script a ejecutar despues de una rotacion. Puedes ejecutar lo que quieras
    		/usr/lib/rsyslog/rsyslog-rotate
    	endscript
    }
