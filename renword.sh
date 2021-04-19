#!/bin/bash

#comentario

for file in `ls ./`; do
	if file --mime-type $file | grep -q "text/plain"; then
		if [ $# = 1 ]; then
			found=1
			while read line && [[ $found -eq 1 ]]; do
				IFS=' ' read -r -a line_array <<< $line
				if [ ${line_array[0]} = $1 ] ; then
					new_name=$file.$1
					if [ $(mv $file $new_name) ]; then
						echo "fichero renombrado como" $new_name
					fi
					found=0		
				fi
			done < $file
		fi
	elif file --mime-type $file | grep -q "image"; then
		new_name=foto_$file

		if [ $(mv $file $new_name) ]; then
			echo "fichero renombrado como" $new_name
		fi
	fi

done

	
