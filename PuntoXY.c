#include "PuntoXY.h"

typedef struct _PuntoXY{
	float x;
	float y;
} PuntoXY;


PuntoXY* PuntoXY_init(float x, float y){
	PuntoXY* p = (PuntoXY*)malloc(sizeof(PuntoXY));
	p->x = x;
	p->y = y;
	return p;
}

float PuntoXY_getX(PuntoXY* p){
	return p->x;
}

float PuntoXY_getY(PuntoXY* p){
	return p->y;
}

void PuntoXY_setX(PuntoXY* p, float x){
	if(p){
		p->x = x;
	}
}

void PuntoXY_setY(PuntoXY* p, float y){
	if(p){
		p->y = y;
	}
}

void PuntoXY_destroy(PuntoXY* p){
	free(p);
}


char* PuntoXY_toString(PuntoXY* p)
{
	char* string = (char*)malloc(30);
	sprintf(string, "x: %f, y: %f", p->x, p->y);
	return string;
}