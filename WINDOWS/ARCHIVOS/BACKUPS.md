# BACKUPS WINDOWS

Se pueden hacer copias de seguridad de todo el sistema (RESTORE POINTS), de volumenes o unidades de almacenamiento(SHADOW-COPIES) o copias de directorios determinados de los usuarios(backups documentos)

# PUNTOS DE RESTAURACION
Un punto de restauracion es una instantanea de todo el sistema (copia de como esta todo el sistema operativo) antes de realizar una tarea critica:
  - Actualizacion automatica severa a traves del servicio Windows-Update
  - Instalacion de drivers nuevos de origen incierto (no contrastado por Windows)
  - Instalacion/desinstalacion de apliaciones que puedan suponer bloqueo del sistema
De forma grafica
  - Configuracion ==> sistema ==> informacion ==> Proteccion del sistema ==> configuracion de proteccion (por defecto esta desactivada), es necesario activarla.
Solo deja hacer un punto de restauracion cada 24 horas, pero este intervalo de tiempo se puede modificar accediendo a clave del registro
Editor de registro: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
Creas variable: SystemRestorePointCreationFrequency valor: DWORD numero_minutos

# COMANDOS
    Enable-ComputerRestore  -- habilita la creacion de puntos de restauracion
      EJ: Enable-ComputerRestore -Drive "C:\", "D:\" -- habilitamos creacion de puntos de restauracion en discos C: y D:
          Enable-ComputerRestore -Drive "C:\" -- Activamos la C
    Disable-ComputerRestore -- deshabilita la creacion de puntos de restauracion
      EJ: Disable-ComputerRestore -Drive "C:\", "D:\" -- deshabilitamos creacion de puntos de restauracion en discos C: y D:
          Disable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -- crea un punto de restauracion, es obligatorio especificar un nombre para el punto de restauracion y motivo por el cual quieres crear el punto de restauracion (RestorePointType)
        APPLICATION_INSTALL APPLICATION_UNISTALL MODIFY_SETTINGS DEVICE_DRIVER_INSTALL CANCELLED_OPERATION
      EJ: Checkpoint-Computer -RestorePointType APPLICATION_INSTALL ` -Description "punto de restauracion 04/03/2025"
      Salta error de q tienes q poner clave en el registro q hemos puesto arriba
      HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore   Variable: SystemRestorePointCreationFrequency valor: DWORD 1

    New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" `
                     -Name "SystemRestorePointCreationFrequency" `
                     -Value 1 ` -- indica minutaje
                     -Property DWORD
    Ahora ejecuto comando y funciona
      Checkpoint-Computer -RestorePointType APPLICATION_INSTALL ` -Description "punto de restauracion 04/03/2025"
      
    Get-ComputerRestorePoint -- sirve para enumerar los puntos de restauracion que tienes y para obtener detalles de un determinado punto de restauracion(opcion -RestorePoint numero_punto_restauracion)
     EJ: Get-ComputerRestorePoint -RestorePoint 4 -- obtenes informacion de un punto de restauracion concreto
     EJ: Get-ComputerRestorePoint -RestorePoint 4 | Get-Member -- para saber la clase del objeto System.Management.ManagementObject#root\default\SystemRestore
                                                                                                   espacio de nombres wmic                        clase wmic
     El comando Get-ComputerRestorePoint sirve para ver el resultado del volcado de un punto de restauracion(una vez volcado, reiniciado el sistema, abres powershell y ejecutas comando con esta opcion) -LastStatus                                                                                                 
      EJ: Get-ComputerRestorePoint -LastStatus
    Restore-Computer -- vuelca el punto de restauracion indicado del listado q te saca Get-ComputerRestorePoint
      EJ: Restore-Computer -RestorePoint numero_sequence

    Como hacer backups de directorios/ficheros desde powershell, sin usar herramientas o aplicaciones

# BACKUPS DE ARCHIVOS Y DIRECTORIOS
La unica manera de hacer el backup totales/incrementales de directorios o ficheros es manejando comandos para la gestion de ficheros/directorios

# COMANDOS
    Get-ChildItem -Path unidad:\ruta -- recuperar los ficheros de un directorio
    Get-itemProperty -Path unidad:\ruta -- recuperas todas las props del objeto del objeto (si quieres una determinada propiedad con -Name nombre_propiedad)
      EJ: Get-itemProperty -Path C:\Users\Gonza_s\Desktop\Prueba.txt -Name length
      Get-childItem -Path $env:HOMEPATH\Documents\ -- Contenido del directorio Documents de usuario ha iniciado sesion
      Get-ItemProperty -Path $env:HOMEPATH\Desktop\prueba.txt -name LastWriteTime -- Fecha ultima modificacion fichero "prueba.txt" q se encuentra en el escritorio usuario ha inicidado sesion
      New-Item -Path unidad:\ -Name nombre -ItemType Directory|File -- crea un nuevo direcotorio/fichero
        EJ: New-Item -Path C:\Windows\Temp -Name backups -ItemType Directory
      Copy-Item -Path unidad:\ruta\dir_origen -Destination unidad:\ruta_destino [-Recurse] -- copia directorios/ficheros en otro punto
        EJ: vamos a hacer backup total del directorio "Desktop" (Escritorio) usuario ha iniciado sesion en el directorio destino C:\Windows\Temp\backups
            Copy-Item -Path $env:HOMEPATH\Desktop -Destination C:\Windows\Temp\backups -Recurse
      Compress-Archive -Path C:\Windows\Temp\backups -DestinationPath C:\Windows\Temp\backups_06-03-2025.zip -- comprimimos la carpeta y sus ficheros en un zip

      FECHAS
      $fecha= Get-Date -UFormat "%d_%m_%Y_%H%m"
      Compress-Archive -Path C:\Windows\Temp\backups -DestinationPath C:\Users\Gonza_s\Desktop\$($fecha).zip


# BACKUPS_INCREMENTAL
Para hacer backups incrementales de un determinado directorio, tiene q seleccionar LOS ELEMENTOS Q HAN CAMBIADO en el directorio de destino de backups(direct.backup total) con respecto al directorio original es decir, tendria q comparar(usando comando COMPARE-OBJECTS)
elementos en directorio <=====> elementos en directorio
C:Windows\Tem\backups            $env:HOMEPATH\Desktop\prueba2
comando -- Compare-Object -Reference $(Get-ChildItem -Path C:\Windows\Temp\backups) -DifferenceObject $(Get-ChildItem -Path $env:HOMEPATH\Desktop\prueba2 -Recurse) -IncludeEqual
=> no existe en destino/Refence y si existe en el DiferenceObject
>= no existe en origen/Diference y si existe en Reference
== Existe en ambos            
