# ENLACES
- [Get-Service](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.management/get-service?view=powershell-7.5)

# ADMINISTRACION DE SERVICIOS
El modulo encargado en el kernel de Windows de la gestion se llama Service Constrol Manager(SCM), es un ejecutable que se encuentra en donde estan todos los ficheros del sistema C:\Windows\System32 -> services.exe
El SCM va lanzado los servicios recuperados del REGISTRO en una clave especial HKEY_LOCAL_MACHINE\System\Control\Services -> dentro de esta clave por cada servicio hay definida una carpeta o subclave

En ella se definen las caracteristicas del servicio
  - El ejecutable del servicio
  - Parametros
  - Variables de entorno
  - Usuario con el que se ejecuta el servicio -> cuenta del sistema y estan registrados a:
      - System
      - LOCAL-SERVICE(cuenta para servicios internos del SO)
      - NETWORK-SERVICE(Cuenta para servicios con conexiones al exterior)
  - Modo de arranque del servicio: Automatico(Manual| Disabled)

# FORMA DE VER LOS SERVICIOS EN INTERFACE-GRAFICO
1) Foma
Administrador de tarea -> pestaña Servicios(te muestra los detalles del proceso asociado al servicio cuando lo lanza el SCM)
Registro de windows: clave Service
SCM -> servicio1(lee ejecutable) ==> process manager genera un proceso para ese ejecutable
       servicio2
       servicio3

 2) Forma Inicio => Ejecutar: services.msc (herramienta administrativa para ver de forma grafica la descripcion de cada servicio, aparece la informacion que hay en el registro sobre cada servicio):
    - nombre, Descripcion, Estado, Usuario ejecuta servicio
Si haces doble-click sobre un servicio(o boton-derecho => propiedades) te aparece la info detallada del servicio, pudiendo modificar valores q automaticamente
se reflejarian en la clave del registro correspondiente

# COMANDOS POWESHELL PARA LA GESTIOS DE SERVICIOS
    Get-Service | Get-Member -- permite ver la clase del objeto(service)
    $servicio=Get-Service -Name wuauserv | Get-Member -InputObject $servicio -- permite ver la clase del objeto(service)
    [System.ServiceProcess.ServiceController] -- clase de Get-Service
    Get-Service -- permite ver los servicios en ejecucion

    PROPIEDADES DEL COMANDO
     -Name nombre_servicio -- permite ver el proceso de ejecucion de un app concreta

    FORMATOS DE LAS PROPIEDADES DE UN SERVICIO
    Get-Service -Name $servicio | Format-List -Property *
    Get-Service -Name $servicio | Format-Table -Property *

    PROPIEDADES DEL OBJETO
      (Get-Service -Name nombre_servicio).Status -- te da el estado del servicio
      (Get-Service -Name nombre_servicio).DisplayName -- indica la empresa o dominio de la aplicacion

    METODOS DEL OBJETO
      (Get-Service -name wuauserv).Start -- arranco un servicio
      (Get-Service -name wuauserv).Stop -- paro un servicio
      Suspend-Service -name nombre_servicio -- suspension del servicio
      Remove-Service -Name $nomServ -Confirm -- eliminacion del servicio
