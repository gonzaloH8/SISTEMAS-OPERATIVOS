# AUTORIZACION
Proceso por el cual se gestiona el acceso a los recursos del sistema cuando los usuarios tienen su token de acceso(se han logueado); este proceso lo controla el modulo del kernel q generaba el acces-token para los usuarios,
el **SRM(Security Reference Monitor)**. Todos los recursos del sistema(ficheros y directorios) tienen asociado un **SD(Security-Descriptor)**, formado por:
- Metadatos del fichero/Directorio(nombre, tamaño, fechas de acceso/modificacion, usuario propietario,...) propiedades generales en la aplicacion
- **DACL:** conjunto de reglas de acceso. Cada regla de acceso se denomina ACE. Cada regla ACE representa una regla de control de permisos para un usuario/grupo(Usuario SYSTEM control total). Propiedades-Seguridad-Opciones Avanzadas-Permisos-Reglas ACE
- **SACL:** conjunto de reglas de auditoria(almacenamiento/informacion de los logs mediante el servicio ENVENTLOG cuando alguien intenta haceder a ese recurso). Propiedades-Seguridad-Opciones Avanzadas-Auditoria
- **SRM:** del access-token del usuario extre los grupos a los q pertenece el usuario y va regla por regla de la DACL comprobando si tiene o no acceso al fichero;
  si tiene acceso, carga en memoria el fichero(le dice al modulo de gestion de procesos q lo carge) y lo ejecuta; si no tiene acceso, pues se le deniega.
  Tanto en un caso como en otro, si hay alguna regla en la SACL para auditar el acceso se registra en los LOG(generalmente en log Aplication).

  Sobre carpeta(directorio) prueba en el escritorio:
  Ver su SD con su DACL y ver regla ACE para usuario propietario(ver q tiene control total)
  Añadir regla ACE para usuario PRUEBA solo de LECTURA(solo le deberia permitir ver su contenido interior, no modificarlo no situarse dentro de la carpeta)
  Como usuario PRUEBA intenta crear un fichero llamado OTRO.txt dentro del directorio PRUEBA ¿te dejaria?

Cambiar la regla ACE para el usuario prueba a:
 - Lectura(puedes ver contenido directorio)
 - Escritura(puedes crear fichero/directorios en su interior NUEVOS, no existentes)
 - Modificacion(puedes modificar el contenido del directorio, modificar ficheros/directorios existentes, su contenido, su nombre, etc)
 - Lectura y Ejecucion (puedes ver el contenido del directorio SITUANDOTE EN SU INTERIOR)

# COMANDOS
    Start-Process -FilePath "C:\Windows\system32\notepad.exe" -ArgumentList "C:\Users\prueba\Desktop\prueba.txt" -Credential "prueba" -- asi te pide la password
    
    $passwordHash=ConvertTo-SecurityString "Irina" -AsPlainText -Force
    [pscredential]$credenciales=[pscredential]::new("prueba", "Irina")
    Start-Process -FilePath "C:\Windows\system32\notepad.exe" -ArgumentList "C:\Users\prueba\Desktop\prueba.txt" -Credential $passwordHash

    Start-Process -FilePath "powershell.exe" -ArgumentList "new-item -path c:\Users\gonza_s\Escritorio\prueba\OTRO.txt " -Credential prueba -- crea un fichero

# COMANDOS DE GESTION DACL\SACL
    [System.Security:AccessControl.FileSystemAccessRule] -- Cada regla ACE es un objeto de la clase: System.Security:AccessControl.FileSystemAccessRule
    get-ACL -Path C:\ruta\nombre_fichero -- te devuelve todas las reglas ACE de la DACL de ese fichero o directorio 
    (Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt).Access -- obtenemos la informacion de permisos que tiene el archivo
    (Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt).Access[] | get-member -- acceso a sus propiedades,clase y metodos

    FileSystemRights : FullControl -- tipo de permiso sobre el archivo
    AccessControlType : Allow | Deny -- define si tiene permitido o no el acceso
    IndetityReference : NT ATHORYTY\SYSTEM -- identificador del usuario
    IsInherited : True -- indica si el archivo ha obtenido los permisos de una carpeta superior o no. true S false N
    InheritanceFlags : None | ContainerInherit | ObjectInherit -- No se heredan los permisos a otros archivos o carpetas dentro del mismo directorio.
    PropagationsFlags : None | ContainerInherit | ObjectInherit -- La propagación de los permisos no está restringida

    AÑADIR UNA NUEVA REGLA ACE A DACL
    [System.Security.AccessControl.FileSystemAccessRule]::new -- accedemos al listado de metodos disponibles para la creacion de un objeto que cree una regla ACE
    $grupo="Todos" -- string
    $permisos=[System.Security.AccessControl.FileSystemRights]::Read -- clase de la sobrecarga 2 que nos permite dar el tipo de permisos sobre el archivo
    $acceso=[System.Security.AccessControl.AccessControlType]::Allow -- clase de la sobrecarga 2 q nos permite si permitimo o no el acceso al archivo
    [System.Security.AccessControl.FileSystemAccessRule]::new($grupo, $permisos, $acceso) -- definimos a la clase principal las propiedades al nuevo objeto de ACE
    
    $ficheroSD.SetAccessRule($nuevaACE,...) -- creamos un clon del DACL
    Set-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt -AclObject $ficheroSD -- machaca el original y añade la regla
    
    $ficheroSD.RemoveAccessRule($reglaACE,...) -- clon de la ADCL modificada
    Set-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt -AclObject $ficheroSD -- eliminamos regla

# COMANDOS PARA GESTIONAR DACL/SACL DESDE POWERSHELL
Administracion DACL y reglas de acceso a recursos ACE
Obtencion de reglas ACE de la DACL
  get-ACL -Path C:\ruta\nombre_fichero ==> te devuelve todas las reglas ACE de la DACL de ese fichero o directorio Cada regla ACE es un objeto de la clase: System.Security:AccessControl.FileSystemAccessRule
EJ: obtener reglas ACE de acceso(DACL) de fichero prueba.txt q esta en el escritorio
  (Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt).Access
  (Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt).Access[] | get-member -- acceso a sus propiedades,clase y metodos

Para arreglar una nueva regla ACE a la DACL de un fichero/directorio, me tengo que crear un objeto de la Clase System.Security.AccessControl.FileSystemAccessRule, y hay dos formas de hacerlo:
- usando el comando powershell: New-Object
- usando/ejecutando el constructor de la clase: [System.Security.AccessControl.FileSystemAccessRule]::new -- esta sobrecargado
    - System.Security.AccessControl.FileSystemAccessRule new
        (System.Security.Principal.IdentityReference identity,
         System.Security.AccessControl.FileSystemRights fileSystemRights,                 
         System.Security.AccessControl.AccessControlType type)
      
    - System.Security.AccessControl.FileSystemAccessRule new
      (string identity, -- identificar del usuario/grupo
       System.Security.AccessControl.FileSystemRights fileSystemRights, -- que permisos quieres dar
       System.Security.AccessControl.AccessControlType type) -- si permites o deniegas
      
    - System.Security.AccessControl.FileSystemAccessRule new
      (System.Security.Principal.IdentityReference identity,
       System.Security.AccessControl.FileSystemRights fileSystemRights,                 
       System.Security.AccessControl.InheritanceFlags inheritanceFlags,
       System.Security.AccessControl.PropagationFlags propagationFlags,
       System.Security.AccessControl.AccessControlType type)
    
    - System.Security.AccessControl.FileSystemAccessRule new
      (string identity,
       System.Security.AccessControl.FileSystemRights fileSystemRights,
       System.Security.AccessControl.InheritanceFlags       
       inheritanceFlags,
       System.Security.AccessControl.PropagationFlags propagationFlags,
       System.Security.AccessControl.AccessControlType type)    
