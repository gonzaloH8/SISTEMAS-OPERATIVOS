# EJERCICIOS
- [TAREA PROGRAMADA](https://sistemasyoperativos.com/2019/12/19/examen-practico-powershell-enunciados-y-soluciones/)
- [VARIOS](https://mypowershellsite.wordpress.com/) 

# POWERSHELL
    El IDE para programar en powesherll: Powershell_ise.exe --- ejecutar como administrador
    Ver --- Activar panel de Script -- Atajo Control + R

# COMANDOS GENERALES
- [GET-MEMBER](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-7.4)
- [COMODINES](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7.5)

      <# comentarios #>
      Get-Help nombre_comando -Examples o -Full -- Para ver la ayuda de cualquier comando
      Get-Member -- Obtiene los miembros, propiedades, metodos de los objetos
      Start-Process -FilePath "powershell" -Verb RunAs -- inicia powershell como administrador
      Clear-host -- limpia el script

      COMODINES
      $_ -- imprime los valores anteriores. 1,2,3 | %{ Write-Host $_ } 
      $PSItem -- hace lo mismo que $_

# COLORES
    write-host "-----------------" -BackgroundColor Red -ForegroundColor Yellow
    write-host "INFO DEL PROCESO" -BackgroundColor Red -ForegroundColor Yellow
    
# MANEJANDO LA INTERFAZ GRAFICA DE POWERSHELL
    SIMBOLOS
        Caja rosada -- metodos
        Ventana blanca con escritura -- propiedades
        Banco azul -- propiedades propias del comando
        Asiento azul + banco morado -- nombres a los que se puede aplicar el comando
    f9 sobre una linea de un script guardado permite controlar el proceso de ejecucion
    f11 permite ir linea por linea en el script(funcionalidad de debug)

# OPERADORES
- [OPERADORES](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4)
- [REGULAR EXPRESIONS](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-7.5)

      -eq -- igualdad
      -ne -- no es igual a, sin distinción de mayúsculas y minúsculas
      -gt -- mayor que
      -ge -- mayor que o igual a
      -lt -- menor que
      -le -- menor que o igual a
    
      ? -- coincide con cualquier carácter individual
      * -- coincide con cualquier número de caracteres
    
      -like -- la cadena coincide con el patron regex
      -notlike -- la cadena no coincide con el patron regex

      -match regex sin distinción de mayúsculas y minúsculas.
          $nombre = "cadena de string" $nombre -match (\w) (\w) (\w)
      -notmatch regex sin distinción de mayúsculas y minúsculas no coincidente
      -replace -- reemplaza las cadenas que coinciden con un patrón regex. 

      -contains coincidencia sin distinción de mayúsculas y minúsculas
      -notcontains sin distinción de mayúsculas y minúsculas no coincidente

      -is -- los objetos son del mismo tipo
      -isnot -- los objetos no son del mismo tipo

      -in -- el valor esta en una coleccion
      -notin -- el valor no esta en una coleccion

      -not invierte la solucion del condicional
      ! -- invierte la solucion del condicional

      -and -- obliga a las dos o mas condiciones a ser true
      -or -- obliga a una de las dos condiciones sea true
    
# VARIABLES
    [string]$variable=valor -- tipo cadena
    [number]$variable=valor -- tipo numero
    [date]$variable=valor -- tipo fecha    
    [System.Diagnostics.Process] -- tipo clase del objeto
    (get-process -name notepad).basePriority -- permite el acceso a metodos
    $data = @('Zero','One','Two','Three')
    
# EXPRESIONES REGULARES
    'book' -match 'oo' -- busca si los caracteres se encuentran en la cadena de texto
    'big' -match 'b[iou]g' -- busca si en la cadena de texto conincide con cualquiera de las conbinaciones del []
    [0-9] -- indica numeros
    /d -- inidca numeros abreviado
    [a-zA-Z0-9] -- indica letras
    /w -- indica letras abreviado
    . indica que coindice con cualquier caracter
    /s -- espacio en blanco
    \ -- escape de caracter
    * -- cero o mas veces
    + -- Una o mas veces
    ? -- Cero o una vez
    {n,m} -- minimo n, maximo m
    {n} -- coindice con este numero exacto
    {n,} -- coindice con este numero o mas
    ^ -- Inicio de cadena
    $ -- fin de cadena
    \t -- tabula la linea
    \n -- salto de linea
    \r -- retorno de carro 

# STRING
- [WRITE-HOST](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.utility/write-host?view=powershell-7.4)
- [READ-HOST](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-7.4)

      Write-Output -- muestra los objetos del proceso. 
      Write-Information -MessageData "Processes starting with 'P'" -- permite dar un mensaje descriptivo de lo que se va a hacer
      Write-Host "texto" -- escribe un texto por consola 
      Read-Host "Please enter your age" -- permite que el usuario escriba una respuesta e imprima el resultado
              -Prompt
    
# CONDICIONAL
- [IF](https://learn.microsoft.com/es-es/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.4)
- [SWITCH](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-7.4)

        if( $condicion ){retorno}
        elseif( $condicion ){}
        else{}
    
        $condicion=0
        switch ( $condicion )
        {
            1{contenido}
            2{contenido}
            3{contenido}
        }
    
        CONTINUACION DE LINEA
        if ($null -ne $user -and
        $user.Department -eq 'Finance' -and
        $user.Title -match 'Senior' -and
        $user.HomeDrive -notlike '\\server\*'
        )
        {
            # Do Something
        }
        GUARDANDO TODA LA CONDICION EN UNA VARIABLE
        $needsSecureHomeDrive = $null -ne $user -and
        $user.Department -eq 'Finance' -and
        $user.Title -match 'Senior' -and
        $user.HomeDrive -notlike '\\server\*'
    
        if ( $needsSecureHomeDrive )
        {
            # Do Something
        }

        CONTROL DE ERRORES(COmprueba la existencia de una carpeta y si no existe la crea)
          if ( -not (Test-Path -Path $folder) )
        {
            New-Item -Type Directory -Path $folder
        }

# BUCLES
- [FOR](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_for?view=powershell-7.4)
- [DO](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_do?view=powershell-7.4)
- [WHILE](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_while?view=powershell-7.4)
- [FOREACH](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.5)

      DO-WHILE
      do{
      }
      while()

      FOR
      for($i=1; $i -le 10; $i++){Write-Host $i}

      FOREACH
      foreach ( $node in $data )
      {
       Write-Host "Item: [$node]"
      }
      foreach ($<item> in $<collection>){<statement list>}

      $logs.ForEach({ Write-Host $_.Log })

# FUNCIONES
    function Get-Version {
        $PSVersionTable.PSVersion
    }

# FUNCIONALIDADES

## LECTURA DE UN FICHERO
- [Out-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.5)
- [Get-Content](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-7.5)

        [string]$FicheroUsuarios="ruta del fichero"
        Get-Content -Path $FicheroUsuarios | ForEach-Object{content}
        Get-Process | Out-File -FilePath .\Process.txt -- guarda la salida del comando en el fichero
        Get-Content -Path .\Process.txt -- vemos el interior del fichero
    
## ORDENA LOS FICHEROS DE LA CARPETA POR NOMBRE
    $fileList = Get-ChildItem -Path ./work_items
    $fileList | Sort-Object -Descending -Property Name

## MENU
    localoniu@outlook.es 
    do{
    Write-Output "1º Mostrar Servicios del sistema: nombre y descripcion solo ===> pedir el nombre servicio, y mostrar detalles de ese servicio"
    Write-Output "2º Parar servicio ==> pedir el nombre del servicio, comprobar q este running y pararlo"
    Write-Output "3º Arrancar servicio ===> pedir el nombre del servicio, comprobar q este sttoped y arrancarlo"
    Write-Output "4º Deshabilitar Servicio ===> pedir el nombre del servicio, 1º pararlo y luego deshabilitarlo"
    Write-Output "5º SALIR"

    $opcion = Read-Host "Elige una opcion: "
    
    switch($opcion){
        1{
            Write-Output 'Uno'
        }
        2{
            Write-Output 'Uno'
        }
        3{
            Write-Output 'Uno'
        }
        4{
            Write-Output 'Uno'
        }
        5{
            Write-Output 'SALIR'
        }   
    }
    }while($opcion -ne 5)

# ARRAYS
    VARIABLES Y SUS ACCESOS
    $data = @('Zero','One','Two','Three') -- inicializacion de un array
    $data[0] -- acceso un valor del array
    $data[0,2,4] -- acceso multiple de los valores del array
    $data[1..3] -- acceso multiple secuencial de los valores del array
    $data[3..1] -- acceso multiple secuencial de los valores del array al inverso
    $data[2] = 'dos' -- actualizar los valores de un array
    $data = Write-Output Zero One Two Three

    METODOS
    $data.count -- metodo de contabilzacion de valores dentro de un array por su posicion

# GESTION DE ERRORES/ DEBBUG
- [TRY_CATCH](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.4)
- [DEBBUG](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/about/about_debuggers?view=powershell-7.5)

        try{
          
      }cath[System.UnauthorizedAccessException]{
          $ErrMsg  = 'You do not have permission to configure this log!'
           $ErrMsg += ' Try running this script with administrator privileges. '
           $ErrMsg += $_.Exception.Message
           Write-Error $ErrMsg
      }catch [System.Exception]{
        Write-Output "..excepcion..." $_E
        }

      Set-PSBreakpoint -- establece puntos de interrupción en líneas, variables y comandos.
      Get-PSBreakpoint -- obtiene puntos de interrupción en la sesión actual.
      Disable-PSBreakpoint -- desactiva los puntos de interrupción en la sesión actual.
      Enable-PSBreakpoint -- vuelve a habilitar los puntos de interrupción en la sesión actual.
      Remove-PSBreakpoint -- elimina puntos de interrupción de la sesión actual.
      Get-PSCallStack -- muestra la pila de llamadas actual.
      stop / t -- para la depuracion

      s -- ejecuta la siguiente instrucción y, a continuación, StepIntose detiene.
      v, StepOver -- ejecuta la instrucción siguiente, pero omite las funciones y las invocaciones
      Ctrl+Break: (Interrumpir todo en ISE) Divide en un script en ejecución dentro de la consola de PowerShell o Windows PowerShell ISE.
      o, StepOut -- realiza pasos fuera de la función actual; subir un nivel si está anidado
      c, Continue: continúa ejecutándose hasta que se complete el script o hasta que se alcance el siguiente punto de interrupción
      l, List: muestra la parte del script que se está ejecutando. De forma predeterminada, muestra la línea actual, cinco líneas anteriores y 10 líneas posteriores
      l <m>, List: muestra 16 líneas del script a partir del número de línea especificado por <m>
      l <m> <n>, List: muestra <n> las líneas del script, empezando por el número de línea especificado por <m>.
      q, , StopExit: deja de ejecutar el script y sale del depurador
      k, Get-PsCallStack: muestra la pila de llamadas actual.
      <Enter>: repite el último comando si era Step (s), StepOver (v) o List (l). De lo contrario, representa una acción de envío
      ?, h: muestra la Ayuda del comando del depurador
      salir del depurador, puede usar Stop (q)

        VARIABLES PREDETERMIANDAS DEL DEBBUG
      $_
      $Args
      $Input
      $MyInvocation
      $PSBoundParameters
  
# ACCION SOBRE OBJETOS
- [Where-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.5)
- [Select-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object?view=powershell-7.5)
- [ForEach-Object](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.5)

      Select-Object -Property nombre_propiedades -- permite seleccionar las propiedades del objeto
      Get-Service | Where-Object {$_.Status -eq "running"} -- permite hacer un filtrado mediante una condicion
      Get-Service | Where-Object Status -EQ "Stopped" -- Otra forma de permitir hacer un filtrado mediante una condicion
      Get-Service | where-Object { $_.Status -eq "Running"} | ForEach-Object {Write-Output $_.Name} -- muestra los nombres que cumplan con la condicion del Where-Object
      $fileList | Sort-Object -Descending -Property Name
      $data.Where({$_.FirstName -eq 'Kevin'}) -- otra forma
      $data | Where FirstName -eq Kevin -- otra forma

# VARIABLE DE ENTORNO
    Get-ChilItem $env: -- muestra todas las variables de entorno
    Write-Output $env:variable -- muestra el contenido de la variable
    $env:variable = "Valor personal" -- permite modificar una variable temporalmente
    if ($env:OS -eq "Windows_NT") { Write-Output "Estás en Windows"} -- ejemplo de Scripts

    SISTEMA Y CONFIGURACION GENERAL
    $env:COMPUTERNAME -- contiene el nombre del equipo o servidor actual. Util para saber que maquina esta ejecutando un script    
    $env:OS -- define el SO. Muestra Windows_NT en Sistemas de Windows
    $env:PROCESSOR_ARCHITECTURE -- indica la arquitectura del procesador
    $env:NUMBER_OF_PROCESSORS -- especifica el numero de nucleos de procesador disponibles en la maquina
    $env:PROCESSOR_IDENTIFIER -- describe el procesador, incluyendo su modelo y familia
    $env:USERNAME -- muestra el nombre del usuario que ejecuta la sesion actual
    $env:USERDOMAIN -- contiene el nombre del dominio o grupo de trabajo al que pertenece el usuario
    $env:USERPROFILE -- ruta del perfil de usuario actual. C:\Users\Usuario

    DIRECTORIOS Y RUTAS
    $env:PATH -- Contiene una lista de directorios donde el sistema busca ejecutables. Si no se encuentra no se ejecutara
    $env:SystemRoot -- Ruta base del sistema operativo (generalmente C:\Windows).
    $env:TEMP o $env:TMP -- Directorio temporal utilizado para almacenar archivos temporales de aplicaciones y scripts.
    $env:WINDIR -- Indica el directorio de instalación de Windows (normalmente igual a C:\Windows).
    $env:HOMEPATH -- Ruta relativa al directorio principal del usuario (complementa $env:USERPROFILE).
    $env:HOMEDRIVE -- Letra de la unidad donde se encuentra el directorio principal del usuario.

    RED Y CONFIGURACION DE SESION
    $env:LOGONSERVER -- Especifica el servidor que autenticó al usuario en la red.
    $env:SESSIONNAME -- Define el nombre de la sesión actual (por ejemplo, para sesiones de escritorio remoto).
    $env:APPDATA -- Ruta donde las aplicaciones almacenan datos específicos del usuario.
    $env:LOCALAPPDATA -- Ruta donde las aplicaciones almacenan datos locales (no sincronizados en red).

    SEGURIDAD Y CONFIGURACION AVANZADA
    $env:PSModulePath -- Contiene las rutas donde PowerShell busca los módulos disponibles.
    $env:ALLUSERSPROFILE -- Ruta al directorio donde las aplicaciones almacenan datos comunes para todos los usuarios.
    $env:ProgramFiles -- Directorio donde están instalados los programas (generalmente C:\Program Files).
    $env:ProgramFiles(x86) -- Directorio específico para programas de 32 bits en sistemas operativos de 64 bits.
    $env:CommonProgramFiles -- Ruta para archivos compartidos entre aplicaciones (por ejemplo, bibliotecas).

    CONFIGURACION DE USUARIO Y LOCALIZACION
    $env:LANG -- Define el idioma y la configuración regional, como en_US.UTF-8 o es_ES.UTF-8.
    $env:CLASSPATH -- Utilizado principalmente por Java para indicar rutas de bibliotecas y clases.
    $env:PSExecutionPolicyPreference -- Establece la política de ejecución de scripts en PowerShell.
