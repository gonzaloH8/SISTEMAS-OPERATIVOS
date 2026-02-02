# PRACTICA
Fichero USUARIOS_NUEVOS.TXT con este formato, solo leer lineas q contienen INFO-USER y crear cuentas de usuario con esa info(DESHABILITAR LAS CUENTAS)
INFO-GRUPO##:nombre-grupo1
INFO-USER##:usuario1:password1:comentarios_cuenta
INFO-USER##:usuario2:password2:comentarios_cuenta
INFO-USER##:usuario3:password3:comentarios_cuenta
INFO-GRUPO##:nombre-grupo2
INFO-USER##:usuario1:password1:comentarios_cuenta
INFO-USER##:usuario2:password2:comentarios_cuenta
INFO-USER##:usuario3:password3:comentarios_cuenta

# PRACTICA
Obtener para el usuario q ha iniciado sesion (variable de entorno USERNAME) estas propiedades de la cuenta
- SID -- (Get-LocalUser -Name $env:USERNAME).SID.Value.split('-')[0]
- ¿puede cambiar su password? -- (Get-LocalUser -Name $env:USERNAME).UserMayChangePassword
- Ultima vez que cambio su password -- (Get-LocalUser -Name $env:USERNAME).PasswordLastSet.Value
- ¿requiere contraseña para acceder al sistema? (Get-LocalUser -Name $env:USERNAME).PasswordRequired
- fecha bloqueo de la cuenta -- (Get-LocalUser -Name $env:USERNAME).AccountExpires

# PRACTICA
Fichero USUARIOS_NUEVOS.TXT con este formato, solo leer lineas q contienen INFO-USER y crear cuentas de usuario con esa info(DESHABILITAR LAS CUENTAS)
Los grupos(mostrar un mensaje cuando se genera el grupo) y dentro de ese grupo los usuarios q le pertencen(mostrar mensahe cuando se genere la cuenta de usuario, crear las cuentas de usuario DESHABILITADA)
INFO-GRUPO##:nombre-grupo1
INFO-USER##:usuario1:password1:comentarios_cuenta
INFO-USER##:usuario2:password2:comentarios_cuenta
INFO-USER##:usuario3:password3:comentarios_cuenta
INFO-GRUPO##:nombre-grupo2
INFO-USER##:usuario1:password1:comentarios_cuenta
INFO-USER##:usuario2:password2:comentarios_cuenta
INFO-USER##:usuario3:password3:comentarios_cuenta

clear-host
[string]$FicheroUsuarios="ruta del fichero"
Get-Content -Path $FicheroUsuarios | ForEach-Object{
[string]$linea=$_
¿como puedo saber si la linea comienza por INFO-GROUP? necesito una exp.regular o patron
if($linea -match "INFO-GRUPO"){
[string]$nombreGrupo=$linea.split(':')[1].Replace('-','');
New-LocalGroup -Name $NombreGrupo
write-host "Grupo con nombre $nombreGrupo creado correctamente..."
}else{
    [string[]]$camposUser=$linea.split(':');
    [string]$nombreUsuario=$camposUser[0]
    [string]$passwdUsuario=$camposUser[1]
    [string]$comenUsuario=$camposUser[2]
    $passwordHash=ConvertTo-SecureString "1234" -AsPlainText -Force
    New-LocalUser -Name $nombreUsuario -Disabled $true -Disabled $true -Description "$comenUsuario" -password "$passwordHash"
    Add-LocalGroupMember -Name $nombreGrupo -Member $nombreUsuario
    write-host "Usuario con nombre: $nombreUsuario .. dado de alta en grupo: $nombreGrupo"
}
}

# PRACTICA
fichero USUARIOS_NUEVOS.txt con este formato, leer fichero linea a linea e ir creando los GRUPOS(mostrar un mensaje cuando genere el grupo) y dentro de ese grupo los usuarios q le pertencen(mostrar mensaje cuando se genere la cuenta de usuario; crear las cuentas de usuario DESHABILITADO por defecto)
GRUPO:nombre_grupo1###USUARIOS:usuario1:password1,usuario2:password2,usuario3:password3
GRUPO:nombre_grupo2###USUARIOS:usuario4:password4
GRUPO:nombre_grupo3###USUARIOS:usuario5:password5,usuario6:password6
