
PRACTICA
#!/bin/bash
# crear un grupo llamado "alumnos1DAW-A" con GID: 6666
# poner password de acceso al grupo con chgpasswd: Hola1234
# añadir al grupo el usuario de tu cuenta
# comprobar en fichero /etc/group y etc/gshadow
# con tu cuenta comprueba en q grupo estas ahora: id
# cambiate al grupo "alumnos1DAW-A" y vuelve a comprobar en q grupo estas con: id
clear

sudo groupadd alumnos1DAW-A
sudo groupmod alumnos1DAW-A -g 6666
echo "alumnos1DAW-A:Hola1234" | sudo chgpasswd
sudo usermod -g alumnos1DAW-A gonzalo
cat /etc/group | cat /etc/gshadow
id

PRACTICA
#!/bin/bash
# en un array voy a meter los nombres de los grupos a crear
# quiero recorrer el array y por cada nombre recuperado del array hacer un grupo
# en bash se crea así el array:
# 1º forma: nombre_variable=(valor1, valor2, valor3, ...)
# 2º forma: declare -a nombre_variable
# vas asignando valores: nombre_variable [posición]
# para recorrer un array necesito un bucle for con una variable que tome el 
# índice 0 del array hasta la posición final
# el número de elementos menos 1; el número de elementos de un array en bash
# te lo da ${#nombre_variable[*]}
clear

grupos=( alumnos1DAW-A alumnos1DAW-B alumnos2DAW-A alumnos2DAW-B )
# declare -a grupos=(alumnos1DAW-A alumnos1DAW-B alumnos2DAW-A alumnos2DAW-B)

for (( indice=0; indice <= ${#grupos[@]}-1; indice++ ))
do
    echo "en la posición $indice del array ... está el valor: ${grupos[$indice]}"
    sudo groupdel  ${grupos[$indice]}

done

# Este script declara un array llamado grupos con nombres de grupos, y utiliza un bucle for para recorrer cada elemento del array, imprimiendo su posición e índice en la consola.
