# PRACTICA
Quiero recuperar del registro esta informacion:
- ¿Dispositivos usb conectados?
  - HKEY_LOCAL_MACHINE\SYSTEM\DriverDatabase\DriverPackages
  - HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\STORAGE
- ¿url visitados en navegador?
  - HKEY_LOCAL_MACHINE\SOFTWARE\Google
  - HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox
- ¿Aplicacion ejecutado recientemente por el usuario? RunMRU o MRU
  - HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs
  - HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU
  - HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU

# PRACTICA
- El historico del portapapeles de Windows se almacena en HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System se puede deshabilitar poniendo variable AllowClipboardHistory ==> DWORD a 1
   - 1 Comprobar si esxiste esa variable en esa clave
   - 2 Si existe, recuperar su valor y mostrarlo
   - 3 Preguntar si deshabilitar historico portapapeles, si es q "SI" poner su valor a 1 (creando variable si no existe o modificar su valor a 1 si existe)
  
- Para deshabiltar mensaje de bienvenida de Windows y las sugerencias cuando inicia sesion un usuario, en clave del registro HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System para poner variable DisableFirstLogonAnimations ==> DWORD a 1
   - 1 Comprobar si esxiste esa variable en esa clave
   - 2 Si existe, recuperar su valor y mostrarlo
   - 3 Preguntar si deshabilitar historico portapapeles, si es q "SI" poner su valor a 1 (creando variable si no existe o modificar su valor a 1 si existe)

- Buscar en el registro donde se almacena el nombre de la papelera de reciclaje y cambiar el nombre a "KK DE VAKA"

# RESULTADO
function CheckClave( [string]$pathclave, [string]$nombreVar, $valor ){
try{
    write-host -BackgroundColor Red -ForegroundColor Yellow "1º Mostrando clave..."
    Get-ItemProperty -Path "$pathclave" -Name "$nombreVar"

    write-host -BackgroundColor Red -ForegroundColor Yellow "2º Recuperando valor variable en clave..."
    Get-ItemProperty -Path "$pathclave" -Name "$nombreVar"

    write-host -BackgroundColor Red -ForegroundColor Yellow "3º ¿Cambiar valor de variable...?"
    [string]$respuesta=read-host -Prompt ""

    if($respuesta -ieq "si"){
        Set-ItemProperty -Path "$pathclave" -Name "$nombreVar" -Value $valor
    }
   }catch{
    Write-Output "No se ha encontrado la variable $nombreVar"
    }
   }

CheckClave "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" "AllowClipboardHistory" 1
CheckClave "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "DisableFirstLogonAnimations" 1
      
