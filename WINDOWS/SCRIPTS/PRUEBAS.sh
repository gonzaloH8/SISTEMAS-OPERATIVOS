# notepad
Clear-Host
do{
    Write-Output "1º Haceso a elementos del proceso"
    Write-Output "2º Haceso a elementos del proceso"
    Write-Output "3º Haceso a elementos del proceso"
    Write-Output "4º Haceso a elementos del proceso"
    Write-Output "5º SALIR DEL SCRIPT"

    $opcion= Read-Host -Prompt "Dime una opcion: "

    switch($opcion){
    1{
        $proceso = Read-Host "Dime el proceso a gestionar: "
        $resultado= (Get-Process -Name $proceso).Name
        Write-Output "El resultado es: $resultado "
    }

    2{
        $proceso = Read-Host "Dime el proceso a gestionar: "
        [System.Diagnostics.Process]$procesoClase = Get-Process -Name $proceso
        Write-Output "El resultado es: $procesoClase.Name " 
        
    }

    3{
        $proceso = Read-Host "Dime el proceso a gestionar: "
        Get-Process -Name $proceso | Select-Object -Property Name
    }
    
    4{
    
    }

    5{
        Write-Output "HAS SALIDO DEL SCRIPT"
    }

    }

}while($opcion -ne 5)
