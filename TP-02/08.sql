/**
	Ejercicio 8

	1. Crea en la BD el tipo T_PASAJEROS que contendrá los siguientes elementos:
	-	NRO_RESERVA  NUMBER(12)
	-	NRO_PASAPORTE  NUMBER(12)
	-	NOMBRE_APELLIDO VARCHAR2(100)
	-	CLASE  VARCHAR2(1)
	-	NRO_ASIENTO NUMBER(3)
	
	2. Cree en la BD el tipo TAB_PASAJEROS como una tabla anidada

**/

CREATE OR REPLACE TYPE T_PASAJERO AS OBJECT(
	NRO_RESERVA NUMBER(12),
	NRO_PASAPORTE NUMBER(12),
	NOMBRE_APELLIDO VARCHAR2(100),
	CLASE VARCHAR2(1),
	NRO_ASIENTO NUMBER(3)
);


TYPE TAB_PASAJEROS IS TABLE OF T_PASAJERO;
