# PRACTICA ENTORNO GRAFICO
  En entorno grafico crear un fichero "prueba.txt" y una carpeta prueba. 
  Ver su SD(boton derecho sobre fichero ==> propiedades), su DACL(pestaña seguridad ==> opciones avanzadas)
  Comprobar q para el usuario q ha creado el fichero tiene control total.
  Crear un nuevo usuario llamado "prueba"
  Añadir una nueba regla ACE a la DACL del fichero "prueba.txt" q permita al usuario PRUEBA solo LECTURA del fichero "prueba.txt"
  Comprobar q la regla se añadido ok.... intentar ver el contenido del fichero "prueba.txt" con usuario PRUEBA ¿te deja? intenta modificar el fichero añadiendo contenido,¿te deja?
  Si no quieres cerrar sesion actual y abrir sesion con usuario PRUEBA puede ejecutar comandos en nombre de otro usuario con comando del antiguo simbolo del sistema de Windows;

# PRACTICA COMANDOS POWERSHELL
Añadir al fichero prueba.txt esta regla ACE a su DACL
  - grupo Todos, tenga permiso de LECTURA solo(Allow, permitir permiso) ==> usando la segunda sobrecarga constructor
  - Añadir la regla a la DACL del fichero, necesitas metodo .SetAcessRule(reglaACE) del SD del fichero
  - Eliminar la regla añadida

# CREAMOS LA REGLA USANDO LA SEGUNDA SOBRECARGA DEL CONSTRUCTOR
$grupo="Todos"
$permisos=[System.Security.AccessControl.FileSystemRights]::Read
$acceso=[System.Security.AccessControl.AccessControlType]::Allow
$nuevaACE=[System.Security.AccessControl.FileSystemAccessRule]::new($grupo, $permisos, $acceso)

# AÑADIMOS LA NUEVA REGLA
$ficheroSD=Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt
$ficheroSD.SetAccessRule($nuevaACE,...) ==> clon de la DACL (shadow-copy). No es la DACL real del fichero, es un clon. hay que machacar la original, para eso sirve la Set-Acl
Set-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt -AclObject $ficheroSD -- añadimos la regla

# ELIMINAMOS LA REGLA CREADA
$reglaACE=(Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt).Access | Where-Object ($_.Identity -eq "Todos") -- Si esta mal filtro seria null
$ficheroSD=Get-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt
$ficheroSD.RemoveAccessRule($reglaACE,...) -- clon de la ADCL modificada, no es la real.. hay que machacarla la original con comando Set-Acl
Set-Acl -Path C:\Users\Gonza_s\Desktop\Prueba.txt -AclObject $ficheroSD -- eliminamos regla
