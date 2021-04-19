#ifndef PUNTOXY_H
#define PUNTOXY_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct _PuntoXY PuntoXY;

PuntoXY* PuntoXY_init(float x, float y);

float PuntoXY_getX(PuntoXY* p);
float PuntoXY_getY(PuntoXY* p);

void PuntoXY_setX(PuntoXY* p, float x);
void PuntoXY_setY(PuntoXY* p, float y);

void PuntoXY_destroy(PuntoXY* p);

char* PuntoXY_toString(PuntoXY* p);

#endif