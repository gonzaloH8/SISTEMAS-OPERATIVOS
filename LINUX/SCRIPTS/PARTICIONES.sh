
# PRACTICA
	1- Crearnos en un dispositivo virtual un mini-disco duro, creando un fichero y asociándolo a /dev/loop0
	2- Lo intentamos particionar con: fdisk, parted, ...
	3- En una partición sobre el disp.virtual vamos a formatear una partición con ext4: mke2fs
	4- Una vez formateado lo montamos para ver el contenido: mount

# SOLUCION
    1er paso:
		Nos creamos fichero que va a funcionar como mini-disco con el comando dd
													(400 MB)
			dd if=/dev/zero of=/tmp/minidisco bs=4096 count=100000
				-----------	 -----------------	 ------  -----------
					|				|				  |		\---> num.bloques if->of
		if=input-file				of=output-file	  bs=blocksize
		disp.entrada de datos		disp.salida			bloques de bytes desde if->of
		/dev/zero---> 000000...	fichero /tmp --> minidisco

		Para comprobar que se ha creado el fichero: ls -l /tmp/mindisco
		Nos creamos el dispositvo "virtual" con este fichero (como si te crearas un miniusb de 400MB)

			losetup /dev/loop0 /tmp/minidisco
					---------  -------------
						|			\--> fichero que quieres meter dentro
			disp.virtual a usar	  
			si está ocupado y quieres
			saber cuál es el que está libre, usa losetup -f

		Vemos detalles del disco virtual con fdisk:
			
			fdisk -l /dev/loop0

    2º paso:
		Intentamos particionar el disco /dev/loop0 con fdisk (también puedes usar parted)
		Ejecutas fdisk /dev/loop0
					  ---> command: n (sirve para añadir una nueva partición)
						   command: p (sirve para añadir partición y seleccionar primaria)
								número partición: 1
								sector inicio (por defecto)
								sector fin (tamaño partición, por defecto te coge todo el tamaño del disco)
						   command: w (guardas cambios OJOOO!!!) si no quieres guardar nada:
								   q (sales de fdisk sin hacer nada)

		Ejecutas fdisk -l /dev/loop0
		para comprobar particiones

    3er paso:
		Formateas la partición recién creada (usando comando mke2fs)
	
			mke2fs -t ext4 /dev/loop0p1
			--------------
				|--> mke2fs.ext4

    4º paso:
		Para poder usarlo y guardar/leer información en él (crear ficheros, directorios,...)
		Hay que "montarlo"(anclarlo) dentro del sistema de ficheros existente en la máquina física:

		En Linux por defecto se usan los directorios: /mnt o /media

			mount -t ext4 /dev/loop0 /mnt/
				  ------- ---------- ----
					|			|	 \---> Lugar donde quieres montar el contenido o anclarlo
				tipo de sist		|
				de fich. con	   disp.a montar
				el que está
				formateada

		Si no da mensaje de error es que está listo.
		Para empezar a usarlo:
			
		(change directory)
			cd /mnt <------ Nos cambiamos al directorio donde está montado el disp.virtual y ya puedes hacer lo que quieras.

							Nos creamos un directorio:
								
								(make directory)
									mkdir ./mis_apuntes
								
							Nos creamos un fichero:
									echo "hola mundo..." > ./LEEME.txt

							Vemos si lo ha creado: ls -l
