# ENLACES
- [DOCUMENTACION](https://noroute2host.com/color-bash.html)
- [AMPLIACION](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

# SECUENCIA DE ESCAPE
    \e
    Formato de escritura: echo -e "Default \e[31mRed"

# CODIGOS DE ESTILO
    Negrita: \e[1m
    Subrayado: \e[4m
    Parpadeo: \e[5m

# COLOR DE FUENTE
    COLOR_POR_DEFECTO: \e[39m
    NEGRO='\e[30m'
    ROJO='\e[31m'
    VERDE='\e[32m'
    AMARILLO='\e[33m'
    AZUL='\e[34m'
    MORADO='\e[35m'
    CYAN='\e[36m'
    LIGHT_GRAY='\e[37m'
    DARK_GRAY='\e[90m'
    LIGTH_RED='\e[91m'
    LIGTH_GREEN='\e[92m'
    LIGTH_YELLOW='\e[93m'
    LIGTH_BLUE='\e[94m'
    LIGTH_MAGENTA='\e[95m'
    LIGTH_CYAN='\e[96m'
    WHITE='\e[97m'

# COLOR DE FONDO
    COLOR_POR_DEFECTO: \e[49m
    NEGRO='\e[40m'
    ROJO='\e[41m'
    VERDE='\e[42m'
    AMARILLO='\e[43m'
    AZUL='\e[44m'
    MORADO='\e[45m'
    CYAN='\e[46m'
    LIGHT_GRAY='\e[47m'
    DARK_GRAY='\e[100m'
    LIGTH_RED='\e[101m'
    LIGTH_GREEN='\e[102m'
    LIGTH_YELLOW='\e[103m'
    LIGTH_BLUE='\e[104m'
    LIGTH_MAGENTA='\e[105m'
    LIGTH_CYAN='\e[106m'
    WHITE='\e[107m'

# COLORES COMBINADOS
    NEGRITA_AMARILLO_ROJO='\e[1;43;31m'
    Texto rojo + Fondo azul: \e;31;44m
    
# CODIGOS DE RESET
    Reset de todo el formato: \e[0m
    Reset de negrita: \e[21
    Reset del color de fuente: \e[39m
    Reset del color de fondo: \e[49m
