# ADMINISTRACION DEL REGISTRO DE WINDOWS
- [REGRIPPER](https://regripper.softonic.com/)
- [Get-Item Registry](https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-entries?view=powershell-7.5)

El registro de Windows es un almacen de datos q usa el kernel y sus subsistemas para almacenar informacion util para el funcionamiento(el Object Manager, el modulo gestion servicios, el moduilo gestion procesos,..)
Sin registro, el SO no funciona(si estuviera dañado, note queda otra q reinstalar ===> a veces puede restaurarse desde copia de seguridad del registro)
El modulo de Windows encargado del registro(funcionamiento, almacenamiento) se llama CM= CONFIGURATIO MANAGER
¿Como organiza la informacion en el registro el CM?
Si la informacion en permanente(se conserva entre apagados del sistema), la info del registro se alamcena en FICHEROS HIVE/registro(extension .dat), tienen este formato
fichero hive (.dat)
----------------------------------------------------------
HIVE-HEADER | HIVE-BIN-1 | HIVE-BIN-2 | HIVE-BIN-3 | ...
----------------------------------------------------------
||
en el header se almacena los metadatos del hive(fechas de acceso, modificacion, tamaño, numero de hives-bin del fichero, num.de hives libres,...)
En los hive-bin es donde ya se almacenan los datos realmente, se almacenan en forma de arbol binario(clave-valor), se denomina bin-cells a esa pareja clave-valor del arbol

hive-bin-1
----------
header | bin-cell-1 | bin-cell-2 | ...
            |             |
        clave-valor1   clave-valor2

regedit ==> clave del registro(HKEY_CURRENT_USER) ==> fichero hive: NTUSER.dat (representa la info del config. de Windows para el usuario q ha iniciado sesion)
Toda la info de esa clave se reparte el fichero en HIVES-BIN, p.ej, la subclave ENVIROMENT q cuelga de :
HKEY_CURRENT_USER ==> ENVIROMENT ==> podria estar almacenada en HIVEN-BIN-3 dentro de este hive-bin-3, en celdas estarian las variables q conteniene
  Clave Ondrive valor C\Users\Gonza_s\OneDrive ==> bin-cell-1
  Clave Path    valor ... ==> bin-cell-2
  Clave Ondrive valor C\Users\Gonza_s\OneDrive ==> bin-cell-1
Tipos de dato que se admiten en los bin-cells del registro:
Cuando se crea una variable en el registro(un bin-cell en un hive-bin del fichero hive correspondiente), hay q asignarle un tipo de dato especifico q el CM exige, son estos
- REG_SZ = cadena de caracteres(string)
- REG_EXPAND_SZ = string pero en su interior pueden aparecer variables de entorno. Repensentadas entre los simbolos %variable%
- REG_MULTI_SZ = array/lista de cadenas(strings)
- REG_BINARY = array de bytes(boolean seria 0x00000000 true; 0x00000001 false)
- REG_DWORD = entero de 32 bits
- REG_QWORD = entero de 64 bits

# INFO DEL REGISTRO EN ENTORNO GRAFICO
Windows por defecto tiene la herramenta: REGEDIT.EXE
Para mostrar toda la info de todos los ficheros hive del sistema, y la estructura en claves principales

HKEY_LOCAL_MACHINE ==> info.config del SO en la maquina local. REGEDIT crea un enlace como HKEY_CURRENT_CONFIG a subclaves de esta clace principal: 
  HKEY_CURRENT_CONFIG\System ==> HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet
  HKEY_CURRENT_CONFIG\Software ==> HKEY_LOCAL_MACHINE\Software
HKEY_USERS ==> info.config de todas las cuentas de usuario q pueden hacer uso del sistema en la maquina; REGEDIT crea un enlace a la clave del SID del usuario q ha iniciado sesion y la nombra como:
  HKEY_CURRENT_USER ==> enlace a HKEY_USERS ==> SID HKEY_USERS\S-1-5-21-2745767942-924612591-868122150-1001
HKEY_CURRENT_CONFIG ==>
HKEY_CLASSES_ROOT ==> se definen con q aplicaciones se abren las extensiones de los ficheros y descriptores de objetos para aplicaciones instaladas()

# COMANDOS
    Get-Item -Path Registry::\KEY_nombre_clave\
    Get-ChildItem -Path Registry::\KEY_nombre_clave -- Variables clave-valor de una det. clave/subclave(carpeta del registro)
    Get-ItemProperty -Name nombre_clave -- para recuperar un determinado valor asociado a una clave
    Get-LocalUser | ForEach-Object { 
    sidIsuarios=$_.SID.Value 
    $claveReg="HKEY_USERS\sidUsuarios\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
    write-host "VALORES DE APPS EJECUTADOS POR USUARIO: " $_.NAME
    Get-ChildItem -Path Registry::$claveReg
    }

ipconfig /displaydns (muestra la lista de paginas visitadas incluso las de modo incognito) 
ipconfig /flushdns (elimina la lista DNS)
- [Get-History](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.core/get-history?view=powershell-7.5)
  DNS en powershell
  
# CREAR NUEVOS VALORES/CLAVES DENTRO DEL REGISTRO
EJ: para eliminar ficheros temporales almacenados en memoria virtual de Windows en clave registro:
KEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment(clave para administrar ficheros de memoria virtual de Windows)
Hay q crear variable con nombre "ClearPageFileAtShutdown" tipo de dato DWORD y asignarle el valor 1
Probamos a recuperar todo lo q contiene esa clave
            Get-Children -Path "Registry::KEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment"
Probamos a recuperar dicho valor:
            Get-ItemProperty -Path "Registry::KEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment" -Name ClearPageFileAtShutdown
Si no es definida, nos la creamos:
            New-ItemProperty -Path "Registry::KEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment" - Name nombre_ClearPageFileAtShutdown -Value 1  -PropertyType DWORD

#  MODIFICAR VALORES/CLAVES DENTRO DEL REGISTRO EXISTENTES        
EJ: la clave ClearPageFileAtShutdown si existe dentro de la ruta y tiene el valor 0 (por defecto) ==> cambiar valor a 1
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment
Si uso New-ItemProperty salta la excepcion de q la clave ya existe, tienes q modificarla con Set-ItemProperty
Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment" -Name ClearPageFileAtShutdown -Value 1

# PARA BORRAR VALORES/CLAVES DENTRO DEL REGISTRO EXISTENTES
EJ: quiero borrar variable ClearPageFileAtShutdown de la rama del registro
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment
   Remove-ItemProperty -Path "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Managment" -Name ClearPageFileAtShutdown

# COMANDOS  
    Para realizar estos comandos debo saber la ruta de registro, la variable a gestionar y valor a gestionar 1(existe), 0 (no existe)
    Get-Item -Path Registry::HKEY_LOCAL_MACHINE -- permite ver las propiedades en formato fila
    Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE -- permite ver las propiedades en formato columna
    Get-ChildItem -Path Registry::HKEY_LOCAL_MACHINE --
    
    CREAR NUEVOS VALORES/CLAVES DENTRO DEL REGISTRO
    New-Item -Path rama_registro -Name nombre_clave [-Value valor] -- para crear subclaves, tambien vale para variables dentro de clave            
    New-ItemProperty -Path rama_registro -Name nombre_variable -Value valor -PropertyType tipo_clave -- para crear variables dentro de una clave

    MODIFICAR VALORES/CLAVES DENTRO DEL REGISTRO EXISTENTES
    Set-Item -Path ruta_registro -Value valor -- permite cambiar el nombre de las claves/carpetas
    Set-ItemProperty -Path ruta_registro -Name nombre_Variable -Value valor -- permite cambiar el nombre de las variables

    BORRAR VALORES/CLAVES DENTRO DEL REGISTRO EXISTENTES        
    Remove-Item -Path ruta_registro -- OJO no pregunta si estas seguro de lo q haces (antes de borrar, hacer backup del registro)
    Remove-ItemProperty -Path ruta_registro -Name nombre_Variable -- para borrar variables de dentro de esas claves(carpetas)
