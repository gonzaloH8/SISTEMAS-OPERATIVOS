
# PRACTICA
Script q te muestre solo el nombre de todas las tareas programadas, despues pedir el nombre de una tarea(comprobar q existe), si existe
  Autor, Descripcion, Accion a ejecutar, Trigger

Get-ScheduledTask | sort-Object {  $_ TaskName } | ForEach-Object (Write-Output $_Taskname )
[String]$nombre = read-host -Promt "Introduce nombre tarea"

# PRACTICA
Crear desde powershell tarea programada en /mistareas/(path) ===> LaunchNotepad(nombre) q ejecute el Notepad.exe(indicar ruta), todos los lunes a las 16:15, el usuario es el q inicia sesion
1) crear objeto ScheduledTaskAction: $Action= ""
2) Crear objeto ScheduledTaskTrigger: $Disparador=""
3) crear objeto ScheduledTaskPrincipal: $usuario=
Una vez tienes esos objetos, creas tarea
Register-ScheduledTask -TaskPath "/mistareas"
                        - TaskName "LaunchNotepad"
                        - Action $accion
                        - Trigger $Disparador
                        - Principal $Usuario

<# Crear desde powershell tarea programada en /mistareas/(path) ===> LaunchNotepad(nombre) q ejecute el Notepad.exe(indicar ruta), todos los lunes a las 16:15
Get-Help Register-ScheduledTask -Examples
Get-ScheduledTask -TaskPath "\Microsoft\MisTareas\" -TaskName "LaunchNotepad"
#>

$disparador = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 16:15
$usuario = New-ScheduledTaskPrincipal -UserId "$env:USERNAME"
$accion = New-ScheduledTaskAction -Execute "C:\Windows\System32\Notepad.exe"
Register-ScheduledTask -TaskPath "\Microsoft\MisTareas\" -TaskName "LaunchNotepad" -Action $accion -Trigger $disparador -Principal $usuario

# PRACTICA 2
1) Crear un objeto ScheduledTaskAction para q ejecute las tres aplicaciones usando como accion un script q ejecute dichas aplicaciones
Te creas un script aparte en un directorio Windoes al que todos los usuarios puedan acceder: C:\Windows\Temp ===> LanzarApss.ps1 q contenga
        Start-Process -FilePath "C:\Windows\System32\Notepad.exe"
        Start-Process -FilePath "C:\User\$env:USERNAME\AppData\Local\Microsoft VS Code\Code.exe"
        Start-Process -FilePath "C:\Program Files\Mozila Firefox\firefox.exe"
   La accion de la tarea ejecuta este sctipt
          
1) crear objeto ScheduledTaskAction: $Action= "New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument "C:\Windows\Temp\LanzarApps.ps1"
2) Crear objeto ScheduledTaskTrigger: $Disparador=New-ScheduledTaskTrigger -AtLogon
3) crear objeto ScheduledTaskPrincipal: $usuario= New-ScheduledTaskPrincipal -UserId "$env:USERNAME"
4) Una vez tuenes esos objetos, creas tarea
Register-ScheduledTask -TaskPath "\Microsoft\mistareas"
                        -TaskName "AppsLogon"
                        -Action $accion
                        -Trigger $Disparador
                        -Principal $Usuario
