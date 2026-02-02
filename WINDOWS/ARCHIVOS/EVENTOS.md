# ADMINISTRACION LOGS (EVENTOS) EN WINDOWS
- [GET-WINEVENT](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-7.5)
- [FilterHashTable](https://learn.microsoft.com/es-es/powershell/scripting/samples/creating-get-winevent-queries-with-filterhashtable?view=powershell-7.5)
Con el comando antiguo de gestión de logs puedes acceder a los eventos de los ficheros .EVTX tradicionales, no los modernos
Hay un servicio encargado de recoger los eventos que se producen en el sistema y registrarlos que se llama:
EventLog:

    Get-Service -name EventLog <----- servicio lanzado por usuario SYSTEM, en el arranque del sistema y siempre esta Running                                

Funcionamiento:

    Proveedor-1     Proveedor-2     Proveedor-3 <== aplicaciones software, servicios sistema, ...
        |               |               |           q originan eventos
    eventos         eventos          eventos
    --------------------------------------------------------------------------------------------------
    servicio (session-1)   (session-2)      (session-3) <---- bufferes en RAM de almacenamiento de eventos
    EventLog controlador   controlador      controlador       procesados por controladores ejecutandose en
             (thread-1)     (thread-2)      (thread-3)        diferentes hilos del proceso del servicio
        ---------------------------------------------------
                |               |               |
            consumidor-1    consumidor-2    consumidor-3 <==== disp.finales de almacenamiento de los eventos
                                                               procesados por cada controlador; por defecto son
                                                               ficheros (.evtx = XML-EventFile Binary) 
                                                               en este directorio: c:\Windows\System32\WinEvt\Logs                                                                                             

Los eventos no se guardan en segundo plano, se guardan en formato XML comprimido a binario, para poder ver estos ficheros windows da una herramienta (visor):

    EventVwr.msc <---Event-Viewer (Visor de eventos)

# FORMATO FICHEROS .EVTX(consumidores de eventos)
No son ficheros de texto plano, son ficheros binarios y tienen esta estructura:
- File-Header ==> ZONA RESERVADA DEL FICHERO (no se pueden almacenar eventos) ocupa 4kb SE GUARDA: nombre fichero, tamaño max, tamaño actual, fecha del ultimo registro, numero de chunks, tamaño libre, hash de comprobación.
    - Chunk-header-1 -|
    - Chunk-data-1 ---| CHUNK-1 <===  en cada chunk se registran los eventosde un determinado proveedor cada eventos cupa 64kb (6 Clústeres de datos); en el chunk-header
    - Chunk-header-2 -|               se almacena info del chunk: numero de eventos grabados, espacio
    - Chunk-data-2 ---| CHUNK-2       libre del chunk, tamaño del chunk, donde almacenar siguiente evento dentro del chunk(direccion)

            ej:                             proveedor:            servicio EventLog     consumidor: Security.evtx
            usuario inicia sesión ===> servicio lsass genera ---> (controlador) =====> File-Header: chunk-5 (libre)
                                        evento inicio OK                                    |
                                                                                        CHUNK-HEADER-5: puedes registrar
                                                                                        evento en cluster num.X
                                                                                             |
                                                                                        chunk-data-5:
                                                                                        clusterX: evento(64Kb)
                                                                                        (siguiente cluster libre: x+1)

Cuando se llega al limite de registro de eventos en los chunk (no se puede almacenar mas), hay varias políticas de actuación en Windows, por defecto el servicio EVENTLOG sobrescribe

# COMANDOS PARA VER FICHEROS .EVTX
Comando antiguo empleado en versiones de windows anteriores a 10 (windows server anteriores a la 2008)

¿Que tipo de valores se pueden poner en la propiedad -OverflowAction de la clase System.Diagnostics.EventLog?
Esta propiedad es importante porque define la politica q sigue windows cuando el fichero .evtx(log) se llena de eventos por defecto es: "OverwriteAsNeeded" ==> 

[System.Diagnostics.EventLog]$ficheroLog = Get-EventLog -List | Where-Object { $_.Log -eq "Application" }
write-host "politica de Windows cuando log Application llega a su tamaño maximo.." $ficheroLog.OverFlowAction

Otros valores:
- OverflowAction ==>
- OverwriteAsNeeded ==> sobreescritura de lo que ya existe, machacando antiguos eventos existentes
- DoNotOverWrite ==> cuando se llega al maximo tamaño del fichero, no se almacena ni un evento mas hasta q el fichero se vacia manualmente o por una tarea programada
- OverwriteOlder ==> cuando esta definida esta politica, necesitas a la vez propiedad MinimumRetentionDays(Nº dias) por que el servicio EventLog SOLO SOBREESCRIBE aquellos eventos que hayan sido registrados en una fecha superior al valor de esa propiedad (de retencion en dias en log). Para cambiarla la propiedad: $ficheroLog.OverflowAction=[System.Diagnostics.OverflowAction]::DoNotOverWrite Es un valor enumerado

# COMANDOS ANTIGUOS
    Get-Service -name EventLog -- servicio lanzado por usuario SYSTEM, en el arranque del sistema y siempre esta Running
    [System.Diagnostics.EventLog] -- nombre de la clase
    Get-EventLog | Get-Member -- te muestra los objetos, propiedades y metodos de la clase
    Get-EventLog -list | Get-Member -- te muestra los objetos, propiedades y metodos de la clase
    Get-EventLog -list -- te muesta ficheros .evtx "tradicionales" de windows (no aparecen todos los ficheros q aparecen en el visor)   
    Get-EventLog -List | Select-Object -Property Log -- muestra la lista de nombres de logs
    Get-EventLog -List | Where-Object { $_.Log -eq "Application" } | Select-Object -Property * -- permite ver todas las propiedades de application
    Get-EventLog -List | Where-Object { $_.Log -eq "Nombre_Fichero_log" } -- Para ver los detalles de un determinado fichero log necesitas filtrar (no hay ninguna opcion del comando para seleccionar por nombre)
    Get-eventlog -LogName Security -Newest 4 -InstanceId 4624 -After ([System.datetime]::today) -- recuperar los 4 ultimos eventos LOGON id 4624 producidos en el dia de hoy s
    [System.Diagnostics.EventLogEntry] -- clase de los objetos recuperados
    Get-EventLog -Log Application -Newest 1 | Get-Member -- para saberlo recuperas un evento de cualquier log, y se lo pasas a Get-Member
    Get-Eventlog -LogName nombre_fichero_Evtx
                 -Newest numero -- recupera el numero de eventos especificado mas recientes de ese log
                 -After fecha -- recuperas eventos posteriores/anteriores a la fecha especificada
                 -Before fecha --
                 -IntanceId id_eventos -- recuperas eventos con ese id
                 -EntryType nivel_severidad -- recuperas eventos con ese grado de severidad
                 -Message "mensaje" -- recuperas eventos que incluyen ese mensaje en descripcion

# COMANDOS ACTUALES
    [System.Diagnostics.Eventing.Reader.EventLogConfiguration] -- clase
    Get-WinEvent -ListLog * | Get-Member -- muestra la clase, propiedades y metodos del objeto 
    Get-WinEvent -ListLog * -- muestra todos los ficheros log disponibles
    
    Get-WinEvent -ListLog Application -- muestra los datos de un log reducida en formato fila(propiedad --- valor )
        LogMode -- tipo de log
        MaximumSizeInBytes -- maximo tamaño del log en bytes
        RecordCount -- 
        LogName -- nombre del log

    Get-WinEvent -ListLog nombre_evento | Select-Object -Property LogMode -- muestra la propiedad y su valor en formato fila(propiedad --- valor )
    Get-WinEvent -ListLog nombre_evento | Select-Object -Property * -- muestra todas las propiedades de un evento log en formato fila(propiedad --- valor )
        FileSize -- tamaño actual del archivo de log de cada registro
        IsLogFull -- Muestra si cada registro de eventos está lleno o no (true or false)
        LastAccessTime -- muestra el ultimo acceso al evento
        LastWriteTime --muestra la fecha del la ultima vez que se escribio algo en el evento
        OldestRecordNumber --
        RecordCount --
        LogName -- devuelve el nombre del evento
        LogType --
        LogIsolation --
        IsEnabled -- indica si esta habilitado
        IsClassicLog --
        SecurityDescriptor --
        LogFilePath -- 
        MaximumSizeInBytes -- tamaño maximo del archivo en bytes
        LogMode -- modo del log(circular)
        OwningProviderName -- 
        ProviderNames -- 
        ProviderLevel --
        ProviderKeywords --
        ProviderNames --
        ProviderLevel --
        ProviderBufferSize --
        ProviderMinimumNumberOfBuffers --
        ProviderMaximumNumberOfBuffers -- 
        ProdiverLatency --
        ProviderControlGuid --

    Get-WinEvent -ListLog System | Format-List -Property LogMode -- muestra la propiedad del objeto en formato columna(propiedad : valor )
    Get-WinEvent -ListLog System | Format-List -Property * -- muestra todas las propiedades del objeto en formato columna(propiedad : valor )
    
    Get-WinEvent -Path "C:\Logs\mi_registro.evtx" -- permite leer eventos desde un archivo exportado
    Get-WinEvent -LogName nombre-fichero_evtx -- especifica el nombre del registro de eventos o un archivo
                 -FilterXML filtro_XML -- Permite aplicar un filtro en formato XML para seleccionar eventos específicos
                     EJ: $xmlFilter = @"
                        <QueryList>
                          <Query Id="0" Path="Security">
                            <Select Path="Security">
                              *[System[(EventID=4625)]]
                            </Select>
                          </Query>
                        </QueryList>
                        "@
                        Get-WinEvent -LogName Security -FilterXML $xmlFilter
                 -FilterXPATH filtro_XPATH -- Usa una expresión XPath para filtrar eventos en el registro de eventos
                     EJ: Get-WinEvent -LogName Security -FilterXPath "*[System[(EventID=4625)]]"
                 -FilterHashTable filtro_hastable -- Usa una tabla hash para definir criterios de filtrado, como ID de evento, fuente, usuario, etc. (coleccion clave-valor)
                     EJ-1: Get-WinEvent -FilterHashtable @{LogName="Security"; ID=5379} Uso mas simple y usado
                     EJ-2: $filter= @{LogName="Security"; ID=5379} | Get-WinEvent -FilterHashtable $filter 
    
# EVENTOS QUE SE REGISTRAN EN LOS .EVTX
Son objetos que mandan los diferentes proveedores (aplicaciones, servicios, etc) el servicio EventLog para que los registre en los ficheros .evtx (consumidores)
   
    Proveedor
        |
    mensaje (evento)
    ----------------------
    servicio    ||                              al ser objetos como props:
    EVENTLOG  (sesion)                          - ID o Eventlog: generado por el servicio Eventlog en función
    |---> Objetc-Manager (Kernel)                            del tipo de mensaje recibido por el proveedor
          genere objeto Event =======>      - fecha de creación de evento
           ||                               - fecha de registro evento
    ---------------------                       - proveedor que ha originado el evento
          |                                 - grado de importancia/severidad del evento
      consumidor                            - mensaje descriptivo del evento
      fichero .evtx                         ...

si abrimos el visor grafico de eventos: EVENTVWR.MSC

Cuando seleccionas en el panel de la izquierda un determinado fichero .evtx, en el panel central te aparecen todos los eventos almacenados en el fichero. Si haces doble-click sobre uno de ellos, te aparecen todas las
propiedades del objeto evento.
Filtrar eventos en un fichero . evtx: en el visor de evento, una vez seleccionado un fichero .evtx del panel izquierdo, en el panel derecho, te aparecen herramientas para filtrar/seleccionar eventos del mismo en función de sus propiedades: puedes seleccionar por ID, por fecha, por grado de importancia, ... Estos filtros hechos sobre los objetos EVENTOS son filtros XPATH 
