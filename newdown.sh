#!/bin/sh

# Implementa un script newdown.sh de shell en sh para Linux que recibe un único parámetro optativo (número de días)
# que imprima los tres últimos (o menos) ficheros, uno por línea que se hayan creado o modificado en el día actual
# (si no recibe parámetros es equivalente a recibir 1) o en los últimos N días (donde N es el parámetro) en el
# directorio Descargas en el directorio casa del usuario. Utiliza ctime para determinar cuándo se modificó el
# fichero. En caso de recibir más de un parámetro, se imprimirá el uso por la salida de error y saldrá con error. 
# No es necesario considerar un error que el parámetro N no sea un número y en ese caso el programa actuara de una
# forma no especificada.

declare -a ficheros

#Funcion para ordenar los ficheros por fecha.
sort(){
	ordenado=0
	while [[ ordenado -eq 0 ]]; do
		ordenado=1
		for (( i = 0; i < $((${#ficheros[@]} - 1)); i++ )); do
			fichero_fecha_1=${ficheros[i]}
			set -- $fichero_fecha_1
			fecha_1=$2

			fichero_fecha_2=${ficheros[((i + 1))]}
			set -- $fichero_fecha_2
			fecha_2=$2

			if [ $fecha_1 -lt $fecha_2 ]; then
				tmp=${ficheros[i]}
				ficheros[i]=${ficheros[((i + 1))]}
				ficheros[((i + 1))]=$tmp
				ordenado=0
			fi

		done
	done
}


#Funcion para recoger todos los ficheros del directorio indicado.
inspeccionar_directorio(){
	i=0
	carpeta=$1
	fecha_limite=$2
	fichero_fecha=()
	for file in `ls $carpeta`; do
		if [[ -f $file ]]; then
			fecha=$(date -r $file +'%s')
			if [ $fecha -gt $fecha_limite ]; then
				fichero_fecha=($(realpath $file) $fecha)
				ficheros[i++]=${fichero_fecha[@]}
			fi
		fi
		
	done
}

# Comprobacion del numero de argumentos.
if [[ $# -gt 1 ]]; then
	echo "Usage: newdown [N]"
	return 
fi


N=1
if [[ $# -eq 1 ]]; then
	N=$1
fi

fecha_limite=$(date +'%s')
fecha_limite=$(($fecha_limite-$(($N*86400))))

#cd /home/$(whoami)/Downloads
ficheros=()
inspeccionar_directorio . $fecha_limite
sort

for (( j = 0; j < 3 && j < ${#ficheros[@]}; j++ )); do
	fichero_fecha_1=${ficheros[j]}
	nombre_1=${fichero_fecha_1%% *}
	echo $nombre_1
done





