# ENLACES
- [MANUAL](https://santi-gf.github.io/usuarios-grupos/)
  
# USUARIOS
Por defecto en linux la info de los usuarios esta en un fichero: /etc/passwd
Las contraseñas se almacenan en un fichero al q solo tiene acceso el root, q se llama /etc/shadow
Cada linea del fichero es una cuenta de usuario: dos tipos de usuarios o cuentas:
- **Usuarios de sistema:** cuentas de usuario q no pueden usarse para iniciar sesion usadas por servicios.
    - UID: 0
    - Grupo: root con GID 0
    - Directorio: /root
    - Shell: /bin/bash
    - Comentarios: root
- **Usuarios normales:** cuentas de usuario con las que puedes iniciar sesion e intercambiar con el SO
    - UID: 1000
    - GID: grupo con 1000
    - Comentarios: gonzalo
    - Directorio: /home/gonzalo
    - Shell: /bin/bash
Formato: nombre_usuario : x : user_id : group_principal_id : comentarios : ruta/directorio : shell_interactiva

En usuario normales los UID > 1000 en cuentas del sistema UID <=1000
Los permisos son muy restrictivos ls -l /etc/shadow
Cada linea representa la informacion de una contraseña de una cuenta de usuario(tienen q coincidir el nunmero de lineas con el de /etc/passwd), tiene estos campo
nombre_usuario: has_passwd | ! | * : .... campos que indican la durabilidad de la contraseña, etc

# COMANDOS USUARIOS
    GLOBALES 
    /etc/ssh/sshd_config (PasswordAuthentication yes) -- archivo de directivas varias
    sudo pam-auth-update
    who -- muestra los usuarios logeados en el sistema
    id -- te indica el nombre de usuario con el que has iniciado session y estas trabajando
    w -- te da informacion de todos los usuarios q estan usando el sistema y lo que estan haciendo
    su + nombreUsuario -- Cambia de sesion de usuario.
    
    useradd + nombre_usuario -- añade usuario
      -c -- añade comentarios
      -s -- añade shell
    userdel + nombre_usuario -- elimina usuario 
    sudo adduser + nombreUsuario + nombreGrupo -- Añadir un usuario al grupo
    groups + nombreUsuario -- Comprobacion de en que grupos esta el usuario
    sudo deluser usuario --remove-home -- Para borrar un usuario y su carpeta personal
    sudo deluser usuario grupo --  Para borrar un usuario del grupo
    sudo deluser usuario --group grupo  -- Para borrar un grupo y su carpeta personal
    sudo passwd -u nombre_de_usuario -- permite desbloquear la cuenta
    sudo passwd -S nombre_de_usuario -- comprueba si la cuenta esta bloqueada
    exit -- Para abandonar esta sesion y recuperar la anterior

# COMANDOS GRUPOS
    /etc/group -- formato nombre_grupo : x : GID :
        GID(Group-identifier):, numero exclusivo q identifica al grupo para grupos de sistema este numero es inferior a 1000
    /etc/gshadow -- formato nombre_grupo: hash_password | ! | * : usuario1, usuario2, ...
        si aparece un * el grupo esta deshabilitado(no se puede acceder a el)
        si aparece una ! password del grupo ha expirado, el root o el administrador del grupo tiene q reactivarla, cambiandolo.

    sudo usermod + nombre_usuario -- modifica una cuenta de usuario existente
    sudo usermod -g alumnos1DAW-A gonzalo -- modifica el grupo del usuario gonzalo
    sudo usermod -G grupo1,grupo2 usuario  -- Establecer grupos secundarios
    sudo usermod -a -G sinsinf usuario --  Añadiendo al grupo sisinf, sin borrar los anteriores
    sudo usermod g nuevogrupo -G anteriorgrupo usuario -- Cambio de grupo principal de un usuario, manteniendo el anterior como secundario
    sudo usermod -d /home/nuevousuario -- Cambio de directorio personal
        -m --  Copia del contenido del antiguo directorio personal se añade
    usermod -g GID | nombre_grupo_principal nombre_usuario -- modifica el grupo del usuario con ese GID

    groupadd -opciones nombre_grupo ====> comando para crear un grupo (GID)
    groupdel -opciones nombre_grupo ====> comando para borrar un grupo
    groupmod -opciones nombre_grupo ====> modificas caracteristicas del grupo. Permite cambiar el GID
    groups nombre_usuario =====> te indica los grupos en los que esta incluido el usuario 
    newgrp nombre_grupo <==== cuando un usuario pertenece a mas de un grupo, para cambiar de grupo. Si tiene contraseña te la pedira antes de poder cambiar
    
    CAMBIO DE PERMISOS A USUARIOS
    sudo chown nuevopropietario fichero_o_directorio -- Cambio de propietario
    sudo chown nuevopropietario: nuevogrupo fichero_o_directorio -- Cambio de propietario y grupo
    sudo chown: nuevogrupo fichero_o_directorio -- Cambio de grupo   
    
# PASSWORD
    /etc/passwd -- archivo donde se enencuentran las passwd
    pam_passwdqc.so -- host de comprobacion de autentificacion de password predeterminada
    man shadow -- ves la documentacion de las password
    passwd usuario -- cambia de forma interactiva la password de un usuario
    echo "nombreUsuario:passwd" | sudo chpasswd -- cambia la password de ese usuario sin preguntar ===> MUY UTIL PARA SCRIPTS
    echo "$grupo:$pass" | sudo chgasswd -- aplica una contraseña al grupo
    
    echo "nombreGrupo:password" | chgpasswd <==== cambias la password sin preguntar, directamente
    gpasswd nombre_grupo <==== forma interactiva de cambio de password
    gpasswd - A user1,user2,... -M user1,user2.... nombreGrupo ==> lista de admins grupo y lista de miembros de grupo. Sirve para modificar roles en un grupo
    gpasswd -d user1,user2,... nombreGrupo ===> para borrar ususarios de un grupo
    gpasswd -a user1,user2,... nombreGrupo ===> para añadir usuarios a un grupo
