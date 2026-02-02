# PRACTICA 
<# Pedir por teclado el nombre de un proceso y mostrar del mismo esta informacion:
Nombres del proceso, id, prioridad, fecha de inicio o creacion del proceso, numero de threads
¿Que tipo de dato se almacena en cada propiedad: string, float, numberm decimal? acudimos al comando get-member
#>
Clear-Host

do{
Write-Output "1º Muestra las propiedades de la aplicacion de forma simple"
Write-Output "2º Muestra las las propiedades de la aplicacion mediante su clase"
Write-Output "3º Permite acceder directamente a las propiedades y metodos del objeto Get-Process"
Write-Output "4º Permite recorrer el objeto de la clase y buscar aquel proceso deseado y mostrar la info deseada"
Write-Output "5º SALIR"

$opcion = Read-Host "Elige una opcion: "

switch($opcion){
    1{
        [string]$process = Read-Host -Prompt "Dime el nombre del proceso: "
        Get-Process -Name $process | Select-Object -Property name, id, basePriority, StartTime, Threads
    }
    2{
        [string]$process = Read-Host -Prompt "Dime el nombre del proceso: "
        [System.Diagnostics.Process]$nombre=Get-Process -Name $process
        $nombre | Select-Object -Property name, id, basePriority, StartTime, Threads
    }
    3{
        [string]$process = Read-Host -Prompt "Dime el nombre del proceso: "
        (Get-Process -Name $process)
    }
    4{
        
        [System.Diagnostics.Process[]]$proceso=Get-Process
        $proceso | Where-Object { $_.Name -eq "Notepad" } | ForEach-Object { Write-Output $_.id }
    }
    5{
        Write-Output 'SALIR'
    }   
}
}while($opcion -ne 5)

# SCRIPT
<#
Script para cambiar prioridad de procesos ejecutandose
#>
clear
try{
[string]$proceso=read-host -name "Introduce el nombre de un proceso"

write-host "-----------------" -BackgroundColor Red -ForegroundColor Yellow
write-host "INFO DEL PROCESO" -BackgroundColor Red -ForegroundColor Yellow
write-host "-----------------" -BackgroundColor Red -ForegroundColor Yellow
Get-Process -Name $proceso -ErrorAction Stop | Select-Object ProcessName, Id, PriorityClass

write-host "-----------------" -BackgroundColor Red -ForegroundColor Yellow
Write-Host "POSIBLES VALORES DE PRIORIDAD" -BackgroundColor Red -ForegroundColor Yellow
write-host "-----------------" -BackgroundColor Red -ForegroundColor Yellow
write-host $([System.enum]::GetValues([System.Diagnostics.ProcessPriorityClass])) <# Te muestra los valores del proceso #>

[string]$nuevaPrioridad=read-host -name "Introduce nueva prioridad de la lista de arriba"
Write-Host ".... cambiando la prioridad..."
(Get-Process -name $process -ErrorAction Stop).PriorityClass=[System.Diagnostics.ProcessPriorityClass]::$nuevaPrioridad

}
catch [System.Exception]{
Write-Output "..excepcion..." $_E
}
