# AUTENTIFICACION/AUTORIZACION
- [PASSWORD](https://learn.microsoft.com/es-es/powershell/scripting/learn/deep-dives/add-credentials-to-powershell-functions?view=powershell-7.5)

- gpedit.msc -- configuracion de windows -- configuracion de seguridad -- directiva de cuenta -- directiva de contraseñas
Gestion de usuarios/grupos y control acceso a recursos
Proceso de AUTENTIFICACION
Cuando el sistema arranca y finaliza la fase user-mode, se carga en memoria el fichero WinLogon.exe(encargado de ejecutar LogonUI.exe) encargado de mostrar en entorno el fomulario para q introduzca LOGIN + PASSWD
Una vez que el usuario introduce nombre y password, se le pasan al modulo LSASS.exe (Local Security Authentication System). Coge las password y saca el HASH(SHA256), y lo contrasta con un almacen de datos donde lamacena logisn/hashes
Si el almacen de datos es local(intentas iniciar sesion en un equipo de Windows sin formar parte de un dominio/red Windows) se busca la SAM, si coincide el hash almacenado para ese nombre de usuario con el hash calculado a partir de la 
password q ha introducido el usuario, se concede acceso;
¿Como? el modulo LSASS se pone en contacto con el modelo del kernel SRM(Security Reference Monitor)q genera un TOKEN DE ACCESO AL USUARIO, q es el q va a permitir al usuario hacer o no determinadas acciones en el sistema
(proceso de autorizacion)
El token de acceso(es un objeto) q esta formado por estas props: SID-usuario, SID-grupos al que pertenece, DACL, SACL
WinLogon.exe
    ||
LoginUI.exe ==> nombre: xxxxx
                password: xxxx
                    ||
                LSASS.exe ==> hash(password)+login ==> SAM: nombre | hash(NTLM) ==> ok, registro encontrado
                    |
                SRM ==> genera token-acceso usuario. Objeto con estas props:
                                                                      SID-usuario
                                                                          |
                                                                      SID-grupo-1
                                                                      SID-grupo-2
                                                                          |
                                                                      DACL(reglas de control de acceso)
                                                                          |
                                                                      SACL(reglas de registro eventos control acceso)
El SRM devuelve el token de acceso al LSASS.exe, carga el escritorio del usuario(explorer.exe) y aplica las politicas de grupo del equipo a la sesion del usuario 

HERRAMIENTA: how to dump sam windows with Mimikatz(hash en windows de llaman NTLM) Crackma

Un SID(Security-Identifier) es una clave alfanumerica q sirve al LSASS para identificar de forma unica a cada usuario/grupo del sistema, esta formado por:
S-x-x-x-xxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxx-ZZZZ
  |                          |                                |
version digitos id.a la maquina donde se encuentra          RID(Relative-Identifier)
SID                    el usuario/grupo                      num.identificativo cuanta usuario/grupo
                                                            para el admministrador RID-500
                                                            para el resto usuarios no del sistema >= 1000

# COMANDOS USUARIOS
    INFORMACION SOBRE USUARIOS
    Microsoft.PowerShell.Commands.LocalUser -- clase del objeto Get-LocalUser
    Get-LocalUser [-opciones] -- muestra info de todas la cuentas de usuarios definidas. Si quieres la info de una determinada cuenta, la puedes recuperar por nombre o por su SID
    Get-LocalUser -Name nombre_usuario
    Get-LocalUser -SID numero_sid_cuenta 

    CREACION DE USUARIOS
    New-LocalUser -- comando principal para la creacion de un usuario
                  -Name nombre_cuenta -- indicas el nombre de la cuenta
                  -FullName "nombre_completo" -- indica el nobmre completo de la cuenta
                  -Description "...description o comentarios de cuenta..." -- descripcion de la cuenta
                  -AccountNeverExpires $true | $false -- indica si la cuenta expira o no
                  -Disabled -- indica que la cuenta creada pero sin posibilidad de acceso a ella
                  -PasswordNeverExpires $true | $false -- la contraseña tiene opcion a caducarse o no
                  -UserMayNotChangePassword $true | $false -- usuario puede cambiar su contraseña o no
                  -NoPassword -- cuenta sin contraseña
                  -Password OBJETO_SECURESTRING -- establece la contraseña a ese secure-string (no admite texto plano) 
                      El comando READ-HOST tiene parametro -AsSecureString q permite leer cadenas con este formato 

    EJ: $password=Read-Host -AsSecureString -Prompt "Introduce contraseña para la cuenta PRUEBA_" 
    New-LocalUser -Name prueba -description "...cuenta de prueba..." -Password $password
                  Get-LocalUser -Name prueba -- vemos el usuario si esta creado
              
    Set-LocalUser -Name nombre_cuenta [-opcion valor] -- modificas los valores de una cuenta existente
    Set-LocalUser -SID numero_SID [-opcion valor]
    Remove-LocalUser -Name prueba -- elimina la cuenta

# COMANDOS POWERSHELL GESTION GRUPOS LOCALES
    New-LocalGroup -Name nombre_grupo[-description] comentarios grupo -- crear un grupo
    Remove-LocalGroup -Name nombre_grupo | Remove-LocalGroup -SID SID_grupo -- Borrar un grupo 
    Get-LocalGroup [-Name nombre_grupo] -- Para obtener la info de un grupo                     
    [PowerShell.Commands.LocalGroup] -- clase del grupo. Tambien puedes obtener la info del grupo a partir de la SID la ifo del del comando son objetos q pertenecen a esta clase Microsoft

# GESTION DE USUARIOS EN UN GRUPO
    Get-LocalGroupMember -Name nombre_grupo -- Para ver la lista de usuarios de un grupo
    -Member objeto_usuario -- Es un objeto usuario(en ultimas versiones si admite el nombre del usuario como string) Para quitar un usuario de un grupo existente
    Remove-LocalGroupMember -name nombre_grupo _Member objeto_usuario (tambien puedes seleccionar el grupo SID, una vez por nombre)
