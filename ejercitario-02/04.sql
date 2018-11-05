/*
	Ejercicio 4

	Algunos empleados de la empresa son también clientes. Obtenga dicha lista a través de una operación de intersección. Liste cédula, nombre y apellido, teléfono. Tenga en cuenta sólo a las personas físicas (F) que tengan cédula. Recuerde que los tipos de datos para operaciones del álgebra relacional tienen que ser los mismo

*/

SELECT 
	P.CEDULA, 
	P.NOMBRE || ' ' || P.APELLIDO NOMBRE_APELLIDO,
	P.TELEFONO
FROM B_EMPLEADOS E
INNER JOIN B_PERSONAS P
ON E.CEDULA = TO_CHAR(P.CEDULA)
WHERE ES_CLIENTE = 'S'
AND P.TIPO_PERSONA = 'F'
AND P.CEDULA IS NOT NULL