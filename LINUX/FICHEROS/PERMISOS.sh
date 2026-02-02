# ENLACES
- [MANUAL](https://www.ionos.es/digitalguide/servidores/know-how/asignacion-de-permisos-de-acceso-con-chmod/)

# COMANDOS
    chmod u=rwx,g=r,o=fichero
    chmod a+rwx fichero -- añade permisos de lectura, escritura y ejecucion al usuario
    chmod a-rwx fichero -- retira permisos de lectura, escritura y ejecucion al usuario
    chmod 640 fichero -- otorga permisos a usuarios, grupo y otros

# Permisos simbolicos:
    r: permisos de lectura
    w: permisos de escritura
    x: permisos de ejecucion
    	u(usuarios): u=rwx
    	g(grupos):g=rwx
    	o(otros): o=rwx
    	a(todos): a=rwx
     
# Permisos Octal
    0 = Sin Permisos
    1 = Ejecucion
    2 = Escritura
    3 = Escritura y Ejecucion
    4 = Lectura
    5 = Lectura y Ejecucion
    6 = Lectura y Escritura
    7 = Lectura, Escritura y Ejecucion

# OPERADORES
    + -- asignacion de mas derechos
    - -- retirada de derechos
    = -- actualizacion de derechos
