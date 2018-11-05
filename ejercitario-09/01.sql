/*
	Ejercicio 1

	Cree un bloque PL/SQL anónimo que hará lo siguiente:
		- Definir las variables V_MAXIMO y V_MINIMO.
	 	- Seleccionar las asignaciones vigentes MAXIMA y MINIMA de los empleados.
 		- Imprimir los resultados;

*/

DECLARE
	V_MAXIMO	NUMBER	:= 0;
	V_MINIMO	NUMBER	:= 0;
BEGIN

	SELECT MAX(S.ASIGNACION), MIN(S.ASIGNACION)
	INTO V_MAXIMO, V_MINIMO
	FROM B_POSICION_ACTUAL P
	INNER JOIN B_CATEGORIAS_SALARIALES S
	ON P.COD_CATEGORIA = S.COD_CATEGORIA
	INNER JOIN B_EMPLEADOS E
	ON E.CEDULA = P.CEDULA;

	DBMS_OUTPUT.PUT_LINE('Maximo ' || TO_CHAR(V_MAXIMO));
	DBMS_OUTPUT.PUT_LINE('Minimo ' || TO_CHAR(V_MINIMO));
END;