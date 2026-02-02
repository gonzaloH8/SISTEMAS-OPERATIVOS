# ENLACES
- [FECHAS](https://learn.microsoft.com/es-es/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.5)

# COMANDOS
    Get-Date -- muestra la fecha y hora actuales del sistema
    Get-Date -DisplayHint Date -- argumento date Date para obtener solo la fecha
    Get-Date -Format "dddd MM/dd/yyyy HH:mm K" -- personalizar el formato de la salida. salida tipo String
    Get-Date -UFormat "%A %m/%d/%Y %R %Z" -- especificadores de formato UFormat para personalizar el formato de la salida
    (Get-Date -Year 2020 -Month 12 -Day 31).DayOfYear -- (Year, Monthy Day, DayOfYear)

    # FORMATOS DE FECHAS FORMAT
    dddd	Día de la semana: nombre completo
    MM	Número de mes
    dd	Día del mes : 2 dígitos
    yyyy	Año en formato de 4 dígitos
    HH:mm	Hora en formato de 24 horas: sin segundos
    K	Desplazamiento de zona horaria de coordenadas horarias universales (UTC)

    # FORMATOS DE FECHAS UFORMAT
    %A	Día de la semana: nombre completo
    %m	Número de mes
    %d	Día del mes : 2 dígitos
    %Y	Año en formato de 4 dígitos
    %R	Hora en formato de 24 horas: sin segundos
    %Z	Desplazamiento de zona horaria de coordenadas horarias universales (UTC)
