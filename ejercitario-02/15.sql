/*
	Ejercicio 15

	La organización ha decidido mantener un registro único de todas las personas, sean éstas proveedores, clientes y/o empleados. Para el efecto se le pide una operación de UNION entre las tablas de B_PERSONAS y B_EMPLEADOS. Debe listar CEDULA, APELLIDO, NOMBRE, DIRECCION, TELEFONO, FECHA_NACIMIENTO. En la tabla PERSONAS tenga únicamente en cuenta las personas de tipo FISICAS (F) y que tengan cédula. Ordene la consulta por apellido y nombre
*/

SELECT CEDULA, APELLIDO, NOMBRE, DIRECCION, TELEFONO, FECHA_NACIMIENTO
FROM B_PERSONAS 
WHERE TIPO_PERSONA = 'F'
AND CEDULA IS NOT NULL
UNION 
SELECT TO_CHAR(CEDULA), APELLIDO, NOMBRE, DIRECCION, TELEFONO, FECHA_NACIM
FROM B_EMPLEADOS
ORDER BY APELLIDO, NOMBRE