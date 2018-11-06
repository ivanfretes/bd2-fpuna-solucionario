/*
	Ejercicio 1

	Cree en la base de datos el tipo de datos CLIENTES como un varray de un máximo de 50 elementos, compuesto de la siguiente estructura:

		- ID_CLIENTE
		- NOMBRE_CLIENTE
*/

CREATE TYPE T_CLIENTE IS OBJECT(
	ID_CLIENTE 		NUMBER(8),
	NOMBRE_CLIENTE	VARCHAR2(80)
);

CREATE TYPE CLIENTES IS VARRAY(50) OF T_CLIENTE;