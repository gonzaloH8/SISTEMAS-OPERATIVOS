# ENLACES 
- [Patron de Email](https://emailregex.com/)
- [Email temporales](https://10minutemail.com/)

# COMANDOS
      grep [-opciones] /ruta/fichero
      -v  -- muestra aquello que no cumple el patron
      -E, --extended-regexp     PATRONES son expresiones regulares extendidas (ERE)
      -F, --fixed-strings       PATRONES son cadenas
      -G, --basic-regexp        PATRONES son expresiones regulares básicas (BRE)
      -P, --perl-regexp         PATRONES son expresiones regulares en Perl
      -e, --regexp=PATRONES     utiliza PATRONES para encontrar coincidencias
      -f, --file=FICHERO        obtiene PATRONES de FICHERO
      -i, --ignore-case         considera iguales mayúsculas y minúsculas
            --no-ignore-case      considera diferentes mayúsculas y minúsculas
      -w, --word-regexp         coincide solamente con palabras completas
      -x, --line-regexp         coincide solamente con líneas completas
      -z, --null-data           una línea de datos termina en un byte 0, no en un carácter de nueva línea

# PATRONES
## ANCLAS
    ^ -- principio de linea o cadena
    $ -- fin de linea o cadena
    . -- en esa posicion de la expresion puede aparecer cualquier caracter
    \A -- inicio de cadena
    \Z fin de la cadena
    \b limite de palabras
    \B sin limite de palabras
    \< inicio de palabra
    \> fin de palabra
    
## CUANTIFICADORES
    * -- cero o mas repeticiones de la anterior expresion a partir de esa posicion
    + -- una o mas repeticiones de la expresion anterior en esa posicion
    ? -- cero o una repeticion de la expresion anterior.Opcional
    {n,m} -- la expresion anterior se repite mas de n-veces pero menos de n-veces
    {n} -- la expresion anterior se repite exactamente n-veces
    {n,} -- la expresion anterior se repite un minimo de veces, sin limite superior
    {,n} -- la expresion anterior se repite un maximo de veces, sin limite inferior
    [^._-$#] -- en esa posicion NO PUEDE aparecer cualquier caracter enumerado en la lista
    (expresion1 | expresion2 | ...) -- en esa posicion puede darse cualquiera de esas expresiones, es un OR
    
## GRUPOS Y RANGOS
    (...) grupo de patrones
    (?...) grupo pasivo
    [aeiou] rango de vocales. char
    (pdf|doc|txt) rango de palabras. string
    [^abc] negacion de las letras que siguen al simbolo
    [aq] letra minuscula de la a-q
    [AQ] letra mayuscula de la A-Q
    [0-9] digito del 0 al 7
    \incognita numero de grupo/subpatron "x"
      
## CLASES DE PERSONAJES
    \do personaje de control
    \s espacio en blanco
    \S no es espacio en blanco
    \d digito
    \D no es digito
    \w en esa posicion aparece una palabra, sinonimo de [a-zA-Z]+
    \W no es palabra
    \incognita digito hexadecimal
    \O digito octal
      
## SECUENCIAS DE ESCAPE
    \ escapa el siguiente caracter
    \Q inicia secuencia literal
    \MI fin de secuencia literal
      
## MODIFICADORES DE PATRONES
    i* sin distincion entre mayusculas y minusculas
    yo* varias lineas
    s * tratar la cadena como una sola linea
    x * Permitir comentarios y espacios en blanco en el patron
    mi * evaluar reemplazo
    Tu* patron no codicioso

## SISTEMA DE ARCHIVOS POSIX
    [:superior:] letras mayusculas
    [:mas abajo:] letras minusculas
    [:alfa:] todas las letras
    [:numero:] cifras y letras
    [:digito:] Digitos
    [:xdigito:] digitos hexadecimales
    [:punto:] puntuacion
    [:blanco:] espacio y tabulacion
    [:espacio:] caracteres en blanco
    [:control:] personajes de control
    [:grafico:] caracteres impresos
    [:imprimir:] caracteres impresos y espacio
    [:palabra:] cifras,letras y guiones bajos

## REEMPLAZO DE CUERDAS
    $n n-esimo grupo no pasivo
    $2 "xyz" en /^(abc(xyz))$/
    $1 "xyz" en /^(?:abc)(xyz)$/
    $` Antes de la cadena coincident
    $' despues de la cadena coincidente
    $+ ultima cadena coincidente
    $& cadena completa coincidente
      
## AFIRMACIONES
    ?= Afirmacion de anticipacion
    ?! mirada negativa hacia delante
    ?<= o ?<! mirada negativa hacia atras
    ?> subexpresion de una sola vez
    ?() condicion[si entonces]
    ?()| condicion[si entonces de lo contrario]
    ?# comentario
      
## CARACTERES ESPECIALES
    \norte nueva linea
    \r retorno de carro
    \t pestaña
    \v pestaña vertical
    \F avance de formato
    \xxx caracter octal xxx
    \xhh caracter hexadecimal hh
