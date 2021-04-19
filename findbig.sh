#!/bin/bash

#comentario

declare -a ficheros
declare -a fichero_info

sort(){
	ordenado=0
	while [[ ordenado -eq 0 ]]; do
		ordenado=1
		for (( i = 0; i < $((${#ficheros[@]} - 1)); i++ )); do
			fichero_1=${ficheros[i]}
			set -- $fichero_1
			size_1=$2

			fichero_2=${ficheros[((i + 1))]}
			set -- $fichero_2
			size_2=$2
			if [[ size_2 -gt size_1 ]]; then
				tmp=${ficheros[i]}
				ficheros[i]=${ficheros[((i + 1))]}
				ficheros[((i + 1))]=$tmp
				ordenado=0
			fi

		done
	done
	
}

inspeccionar_directorio(){
	carpeta=$1
	USER=$2

	texto=$(find $carpeta | xargs stat --printf="%n,%s,%U;")
	
	IFS=';' read -r -a ficheros_desc <<< $texto
	for (( i = 0, k = 0; i < ${#ficheros_desc[@]}; i++)); do
		IFS=',' read -r -a fichero_split <<< ${ficheros_desc[i]} # ruta/completa/fichero.ext tamano user
		if [[ ${fichero_split[0]} != "." ]]; then
			fichero_info=()
			if [[ $USER = ${fichero_split[2]} ]]; then
				if [[ -f ${fichero_split[0]} ]]; then
					fichero_info=( $(basename ${fichero_split[0]}) ${fichero_split[1]}) # ruta/nombre_fichero tamano
					ficheros[k++]=${fichero_info[@]}
				fi
				
			fi
		fi
	done
}

if [[ $# -gt 2 ]] || [[ $# -lt 1 ]]; then
	echo "Numero de argumentos invalido"
	echo "USO: . findbig.sh N [user]"
	return 
fi

N=$1
USER=$(whoami)
if [[ $# -eq 2 ]]; then
	USER=$2
fi

ficheros=()
fichero_info=()

inspeccionar_directorio . $USER
sort
for (( i = 0; i < ${#ficheros[@]} && i < $N; i++ )); do
	fichero_1=${ficheros[i]}
	set -- $fichero_1
	nombre_1=$1
	echo $nombre_1
done

