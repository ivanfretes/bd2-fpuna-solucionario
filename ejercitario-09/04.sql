/*
	Ejercicio 4
	

	Cree un bloque PL/SQL que permita ingresar por teclado, a través de una variable de sustitución, la cédula de un empleado. Su programa deberá mostrar el nombre y apellido (concatenados), asignación y categoría del empleado
*/

DECLARE 
	V_CEDULA		NUMBER(11) NOT NULL;
	V_NOMBRE		VARCHAR2(100);
	V_ASIGNACION	NUMBER(8);
	V_CATEGORIA		VARCHAR2(30);
BEGIN
	V_CEDULA := &a;

	SELECT 
		E.NOMBRE || ' ' || E.APELLIDO NOMBRE_APELLIDO, 
		S.ASGIANCION, 
		S.NOMBRE_CAT
	INTO V_NOMBRE, V_ASIGNACION, V_CATEGORIA
	FROM B_POSICION_ACTUAL P
	INNER JOIN B_CATEGORIAS_SALARIALES S
	ON P.COD_CATEGORIA = S.COD_CATEGORIA
	INNER JOIN B_EMPLEADOS E
	ON E.CEDULA = P.CEDULA
	WHERE E.CEDULA = V_CEDULA;
	
	DBMS_OUTPUT.PUT_LINE(
		'Nombre y Apellido ' || V_NOMBRE || '\n' ||
		'Asignacion ' || V_ASIGNACION || '\n' ||
		'Categoria ' || V_CATEGORIA
	);

END;