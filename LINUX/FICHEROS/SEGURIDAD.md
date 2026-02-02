# FIREWALL
    sudo ufw status -- Comprobar estado
    sudo ufw enable -- Activar firewall
    sudo ufw disable -- Desactivar firewall

# HASH
    sha512sum -- crea un hash de una longitud de 128 caracteres
    echo $RANDOM | sha512sum | head -c 8

# REDES
    ifconfig -- muestra las interfaces activas
    ifconfig -a -- muestra las interfaces de red disponibles en tu sistema, esten en uso o no y sus paramentro basicos
    ifconfig eth0 -- permite acotar el resultado para mostrar la informacion de una interfaz determinada

# JHON THE RIPPER
    sudo snap install john-the-ripper -- instalacion de la aplicacion
    sudo apt install john -- instalacion de la aplicacion
    john --status -- estado de la aplicacion
    sudo unshadow /etc/passwd /etc/shadow > password.txt -- pasamos los contraseñas a un fichero
    john password.txt -- buscamos la contraseña
    sudo john /etc/shadow --format=crypt -- prueba de busqueda de contraseñas

    sudo passwd ana -- cambiar contraseña
