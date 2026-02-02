# TAREAS PROGRAMADAS SCHEDULED TASKS EN WINDOWS
En Windows hay un servicio q se encarga de periodicamente el pool de tareas programadas(almacen de taeras q se encuanetran en el REGISTRO DE WINDOWS) y las va lanzando si se corresponde por la programacion q tienen definido.
Este servicio se llama scheduled: ==> se paras/deshabilitas el servicio, automaticamente estas tareas dejan de ejecutarse
Get-Service -Name scheduled ==> debe estar activo
EL POOL DE TAREAS esta organizado en forma de arbol (hay una herramienta administrativa para ver dichp pool_) **TASKSCHD.msc** el programador de tareas /raiz del arbol del poll o 'Biblioteca del programador de tareas' ==> contenedor(carpeta) ==> tarea1/tarea2
Ej: Microsoft\Windows\ChkDsk ==> ProactiveScan\SysparRepair
Todo este POOL de tareas realmente esta almacenado en el REGISTRO DE WINDOWS en estas claves
HKEY_LOCCAL_MACHINE\Software\Microsoft\Windows
NTCurrenVersion\schedule\Task\Cache ==> TREE: se almacena todo el arbol de tareas, cada tarea tiene una clave o carpetita q incluye un valor con Object-ID de esta tarea: ID(42241111)EJ: para tarea ProactiveScan
{7f60864A-8CF4-48D0-91A2-7DCA116055F}
Teniendo esos ID las caracteristicas de cada tarea(propiedades) vienen definidas en esta clave
regedit(editor de REGISTRO)

# PROPIEDADES O CARACTERISTICAS DE UNA TAREA PROGRAMADA
Metadatos de la tarea / datos descriptivos de la tarea: autor, nombre de la tarea, descripcion, ultima vez q se ejecuta la tarea
Conjunto de disparadores/triggers: q son el conjunto de valores de cuando se cumplen hacen q el servicio ejecute la tarea(programacion de la tarea) pueden estar basados en tiempo(fecha y hora, dia de la semana, semana del mes) o bien en eventos del sistema(Inicio de session, cierre de session)
La accion es el programa ejecutable o script a lanzar en la tarea cando se cumplen los disparadores
Usuario q lanza la tarea(windows lo llama principal)

Clase(TypeName): Microfosft.Management.Infrastructure.CimInstance#Root/Microsoft/TaskSchedulet/MSFT_ScheduledTask
                            | NameSpace()                               |NameSpace                |ClassName
NameSpace -- alias q guarda las clases y otros objetos
cmd Windows ?

# COMANDOS
        Get-Help Get-ScheduledTask - Example -- ayuda sobre el comando
        Get-Help Register-ScheduledTask -Examples -- vemos ejemplos de uso del comando
        Get-ScheduledTask -TaskPath "microsoft/misTareas" -TaskName "LaunchNotepad" -- permite ver si se ha guardado la tarea programada
        Get-ScheduledTask [-opciones] -- para recuperar las tareas programadas del pool o la info de una determinada tarea
                -TaskPath "/ruta/arbol-pool" -- indica la ruta del archivo que ejecuta la tarea
                -TaskName "nombre_tarea" -- nombre de la tarea a ejecutar
                -Action -- ejecuta New-ScheduledTaskAction(guardar este comando en variable)
                -Trigger -- ejecuta New-ScheduledTaskTrigger(guardar este comando en variable)
                -Principal -- ejecuta New-ScheduledTaskPrincipal(guardar este comando en variable)
        Register-ScheduledTask -- permite registrar la tarea
        New-ScheduledTaskTrigger [-opciones] -- determina la fecha y horario de ejecucion de la tarea
        New-ScheduledTaskPrincipal [-opciones] -- indica el usuario que va a ejecutar la tarea
        New-ScheduledTaskAction [-opciones] -- indicar la ruta del archivo-ejecutable o aplicacion-ejecutable que va a efectuar la accion
        New-ScheduledTaskSettings[-opciones] -- OPCIONAL. representa el entorno config de la tarea
        UnRegister-ScheduledTask -TaskPath "\Microsoft\MisTareas\" -TaskName "LaunchNotepad" -- borra una tarea programada y te pide confirmacion
        UnRegister-ScheduledTask -TaskPath "\Microsoft\MisTareas\" -TaskName "LaunchNotepad" -Confirm:$false -- borra una tarea programada sin preguntarte

        Get-scheduledTask -TaskPath "\Microsoft\MisTareas\" -TaskName "LaunchedNotePad" -- Info de la tarea programada por nosotros paa ejecutar el Notepad todos los dias a las 19:00 
        Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" -TaskName "Scheduled Start" -- Info de la tarea programada para el servicio "Windows Update"(arrancalo si esta parado)
