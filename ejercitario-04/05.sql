/*
	Ejercicio 5

	Cree la tabla de BONIFICACION (con el script que se proporciona más abajo) y calcule con una operación MERGE, la bonificación correspondiente a todos los empleados.

	En todos los casos, la bonificación es igual al total de ventas de cada cédula del vendedor, el cual se calcula sumando el porcentaje de comisión que corresponde a cada artículo sobre el costo de venta de dicho artículo de las ventas realizadas hasta la fecha.

		- Cuando el registro de bonificación ya existe, actualice la bonificación con el monto calculado

		- Si no existe, inserte el registro correspondiente.
*/

CREATE TABLE BONIFICACION(
	CEDULA_VENDEDOR NUMBER(11),
	BONIFICACION NUMBER(10)
);