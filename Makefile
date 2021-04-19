all: PuntoXY.o practica2.o
	gcc -g -Wall PuntoXY.o practica2.o -o PuntoXY

PuntoXY.o: PuntoXY.c PuntoXY.h
	gcc -c -Wall PuntoXY.c

practica2.o: practica2.c
	gcc -c -Wall practica2.c

