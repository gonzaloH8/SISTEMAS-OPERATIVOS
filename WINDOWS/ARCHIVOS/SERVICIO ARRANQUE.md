# PROCESO DE ARRANQUE DE SISTEMAS WINDOWS
  Si tenemos un dispositivo de almacenamiento con uno o varios windows instalados(en varias particiones)
  MBR ---- PARTICION WIN-11 ------- PARTICION UBUNTU ------- PARTICION WIN-10

  MBR: primer sector resevado para el GESTOS DE ARRANQUE del ultimo SO instalado --> SI ESTA DAÑADO no podria arrancar ningun sistema, por falta de acceso
  - BOOTMGR.EFI -- tiene una especia de Base de Datos donde tiene almacenado en q particiones hay sist.windows instalados: (a este almacen de datos del boot-manager, se le llama BCD)
    - 1 particion (num.claster comienza) - win 11
    - 2 particion (libre)
    - 3 particion (num.claster comienza) - win 10
Una vez que seleccionas un sistema windows a arrancar desde el menu que te ofrece el gestor de arranque
Salta al primer sector de la particion del sistema windows elegido.
P.E si escogemos windows 11
MBR ---> BOOTMGR.efi
WINLOAD.EFI --- fichero situado en el primer sector. gestor de arranque propio de ese sistema windows (ojo, cambia en cada version de windows). Se encarga de cargar el kernel de Windows
Si es CRITICO salta BSoD(Pantalla azul)

Si todo va bien, se carga el kernel de windows en memoria comienza la fase del arranque
- KERNEL-MODE o RING-0, comienza con la carga del kernel: NtOsKRNL.EXE -- si esta dañado este fichero no puede cargarse y ejecutarse el modulo principal del sistema y te salta BSoD; si va bien se ejecuta y carga los diferentes modulos o subsistemas principales para hacer el sistema funcional
  - Para habilitar dispositivo I/O (reconocimiento de drivers del HW,..) carga una dll(Libreria de vinculos dinamicos) con funciones para habilitar estos drivers, denominada: HAL.dll (Hardaware-Abstraccion-Layer) Si esta dañada salta BSoD
  - En paralelo:
    - Inicializa PROCESS-MANAGER (arranca dispatcher/scheduler para empezar a crear procesos e hilos --> el process manager crea un proceso inicial "Idle" a partir del cual crea el resto de procesos)
    - Inicializa SECURE-REFERENCE-MONITOR (modulo o subsistema encargado de los procesos de acceso al sistema de ficheros: autorizacion, y tambien de la autentificacion de usuarios) -- se encarga de crear un usuario inicial SYSTEM
    - Inicializa OBJECT-MANAGER (subsistema encargado de crear todos los objetos q necesitan el resto de susbsistemas o modulos, igualmente de destruirlos)
    - Inicializa MEMORY-MANAGER (modulo encargado de adjudicar memoria RAM a los diferentes procesos q crea el process-manager)
    - Inicializa STORAGE-MANAGER (modulo encargado del REGISTRO DE WINDOWS, almacen de datos de configuracion global del kernel para todos los sistemas)OJO al modificar el registro, hacer backup siempre
Una vez que los sistemas estan OK, cargan en memoria un fichero SMSS.EXE llamado Session-Manager, encargado de crear las sesiones para que los usuarios interactuen con el sistema
El kernel entra en estado Wait y toma el control el Session Manager, comenzando la siguiente fase del arranque: -- si esta dañado, BSoD y proceso de arranque se para
  - USER-MODEL o RING-3: el sesion manager se encarga de crear la sesion para q un usuario use el sistema, para ello
      - crea un proceso para ejecutable: CSRSS.EXE -- habilita el entorno grafico, sin el el usuario no puede interactuar graficamente con el sistena --> una vez cargado ejecuta
          - WinINIT.EXE -- encargado de lanzar servicios del usuario --> definido en el registro de Windows
          - Leer variables de entorno para el usuario --> definido en el registro de Windows
          - Ejecuta WINLOGON.EXE ---> pantalla de inicio encargada de recoger credenciales de acceso(login + password)
      - El SESSION-MANAGER a la vez q ejecuta el CSRSS.EXE, carga en memoria el ejecutable  LSASS.EXE (Local Security Authenticator SubSystem) se encarga de recoger el login + password del WinLogon y comprobar que existe en su almacen de datos: WinLogon(Login + Password) ---> hash(password)[LSASS.EXE]--> base de datos de credenciales. LANZA SHELL-GRAFICA escritorio para el usuario(EXPLORER.EXE)
