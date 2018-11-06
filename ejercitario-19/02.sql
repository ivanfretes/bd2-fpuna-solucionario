/*
	Ejercicio 2
	
	Cree la tabla relacional VENDEDORES, compuesta de las siguientes columnas
		- CEDUL_VENDEDOR
		- NOMBRE_VENDEDOR
		- CLIENTES_VENDEDOR CLIENTES;
*/


-- Para evitar ambigüedad con una tabla existente, la llamamos T_VENDEDORES
CREATE TABLE T_VENDEDORES (
	CEDUL_VENDEDOR		NUMBER(11),
	NOMBRE_VENDEDOR		VARCHAR2(80),
	CLIENTES_VENDEDOR	CLIENTES;
);