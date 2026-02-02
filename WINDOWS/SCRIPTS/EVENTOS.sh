# PRACTICA
Mostrar por pantalla los ficheros log tradicionales con get-eventlog luego pedir el nombre de uno de ellos (comprobar q existe en ese listado) y si existe mostrar estas propiedades del fichero:
- Maximo tamaño
- Politica de sobreescritura de eventos definida
- Numero de eventos registrados hasta ahora

        # [System.Diagnostics.EventLog[]]$ficheroLog = Get-EventLog -List guarda en un array lo nombres de ficheros log y $ficheroLog.ForEach({ write-host $_.Log }) recorre el log
        [System.Diagnostics.EventLog]$ficheroLog = Get-EventLog -List | Where-Object { $_.Log -eq "HardwareEvents" }
        write-host "Maximo tamaño" $ficheroLog.MaximumKilobytes                                                                                                                         
        write-host "politica de Windows cuando log Application llega a su tamaño maximo.." $ficheroLog.OverFlowAction
        write-host "politica de Windows cuando log Application llega a su tamaño maximo.." $ficheroLog.Entries.Count


# PRACTICA
  EJ: si quiero recuperar todas las caracteristicas/propiedades del fichero antiguo log "Application"
   Get-EventLog -List ==> Conjunto de ficheros log tradicionales de Windows
   | Where-Object { $_.Log -eq "Application" } ==>  en la variable $_ sustituye cada objeto fichero-log y mira si cumple condicion, si es true.. se lo pasa al siguiente comando
   | Select-Object -Property * ==> cada objeto q le pasa where-object, select-object muestra todas sus propiedades
