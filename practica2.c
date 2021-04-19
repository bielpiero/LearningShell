#include <time.h>
#include <math.h>
#include <errno.h>
#include "PuntoXY.h"

void generarTamanoArray(int* tam){
	*tam = rand() % 100 + 1;
}

void generarAleatorios(int* arr, const int tam){
	int i;
	for(i = 0; i < tam; i++){
		arr[i] = rand() % 100; // arr[i] == *(arr + i)
	
	}
}

void printArray(int* arr, const int tam){
	int i;
	for(i = 0; i < tam; i++){
		printf("%d ", arr[i]);
	}	
	printf("\n");
}

int main(int argc, char** argv){
	int edad;
	PuntoXY* p;
	if(argc != 4){
		fprintf(stderr, "El numero de parametros es incorrecto.\n");
		exit(-1);
	}
	

	perror("Ha ocurrido algo inesperado: ");
	printf("Punto p: %s\n", PuntoXY_toString(p));
	edad = atoi(argv[3]);
	fprintf(stdout, "Hola, %s %s, pronto vas a cumplir %d\n", argv[1], argv[2], edad + 1);

	

	return 0;
}