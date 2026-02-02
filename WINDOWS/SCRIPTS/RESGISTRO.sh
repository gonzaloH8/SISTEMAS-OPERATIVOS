# MENU
do{
Write-Output "1º Mostrar todos los servicios"
Write-Output "2º Muestra la propiedades de una aplicacion"
Write-Output "3º Si la aplicacion esta parada, activala"
Write-Output "4º Si la aplicacion esta corriendo, parala"
Write-Output "5º Desactiva una aplicacion"
Write-Output "5º SALIR"
$opcion = Read-Host "Elige una opcion: "   
    switch($opcion){
        1{
            Get-Service
        }
        2{
            $servicio = Read-Host "Dime una aplicacion: "
            Get-Service -Name $servicio
        }
        3{
            $servicio = Read-Host "Dime una aplicacion: "
            (Get-Service -Name $servicio).Start
        }
        4{
            $servicio = Read-Host "Dime una aplicacion: "
            (Get-Service -Name $servicio).Stop
        }
        5{
            $servicio = Read-Host "Dime una aplicacion: "
            Suspend-Service -name $servicio 
        }
        6{
            Write-Output "SALIR"
        }   
    }

}while($opcion -ne 6)

# PRACTICA 1
# Mostrar la lista de los nombres de los servicios en estado "running"(solo los nombres), una vez mostrado el listado pedir el nombre del servicio a PARAR y pararlo. comprobar el nuevo estado de dicho servicio

# 1º FORMA
[System.ServiceProcess.ServiceController[]]$servicios=get-service
foreach($serv in $servicios){
    if(([System.ServiceProcess.ServiceController]$serv).Status -eq "Running"){
    $serv | Select-Object -Property Name
    }
}

[string]$aparar=read-host -Prompt "Nombre del servicio a PARAR de la lista de arriba:_"
Stop-Service -Name $aparar

# 2º Forma usando comando powershell: Foreach-Object/where-Object. La variable $_ representa cada objeto que se esta procesando de la lista pasada atraves de la tuberia
$servicios | where-Object { $_.Status -eq "Running"} | ForEach-Object {Write-Output $_.Name}

# 3º Forma usando metodos de listas .forEach() y .where() ===> programacion funcional
[string] $aparar=read-host -Prompt "Nombre del servicio a PARAR de la lista de arriba"

# PRACTICA 2
# Mostrar un menu de esta forma:
# ADMIN SERVICIOS
1º Mostrar Servicios del sistema: nombre y descripcion (solo) ===> pedir el nombre servicio, y mostrar detalles de ese servicio
2º Parar servicio ==> pedir el nombre del servicio, comprobar q este "running" y pararlo
3º Arrancar servicio ===> pedir el nombre del servicio, comprobar q este "sttoped" y arrancarlo
4º Deshabilitar Servicio ===> pedir el nombre del servicio, 1º pararlo y luego deshabilitarlo
5º SALIR



# PRACTICA
Servicios
  winDefend -- antivirus de Windows
  wuauserv -- actualizador del sistema
¿Que propiedades de la clase me definen?:
- Decripcion ¿Es de lectura o escritura/lectura? -- no hay con este comando
- Nombre del servicio ¿es de lectura o de lectura/escritura? -- string ServiceName {get;set;} (Get-Service -name wuauserv).ServiceName
- Estado del servicio ¿es de lectura o de lectura/escritura? -- System.ServiceProcess.ServiceControllerStatus Status {get;} devuelve una enumeracion (Get-Service -name wuauserv).Status
- Forma de arranque ¿es de lectura o de lectura/escritura? -- System.ServiceProcess.ServiceStartMode StartType {get;} (Get-Service -name wuauserv).StartType
- Usuario con el se lanza servicio ¿es de lectura o de lectura/escritura? -- no hay con este comando
- Ejecutable del servicio ¿es de lectura o de lectura/escritura? -- no hay con este comando
Probarlo con servicio "wuauserv" el acceso a dichas propiedades
$servicio=Get-Service -name wuauserv
$servicio.ServiceName -- ejecuto el metodo del servicio
Get-Service -name wuauserv | Get-Member -- veo los valores del servicio

(Get-Service -name wuauserv).Start -- arranco un servicio
(Get-Service -name wuauserv).Stop -- paro un servicio

Deshabilitar un servicio: (no lo podrias arrancar hasta que no lo vuelvas a habilitar)
  Suspend-Service -name nombre_servicio -- suspension del servicio
