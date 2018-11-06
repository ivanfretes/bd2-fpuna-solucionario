/*
	Ejercicio 4
	Trate de actualizar elementos en la tabla. Por ejemplo trate de sustituir los clientes del empleado Juan Villalba con los del empleado Jorge Medina.
*/

UPDATE VENDEDORES2 SET
SET CLIENTES_VENDEDOR = (
	SELECT CLIENTES_VENDEDOR 
	FROM VENDEDORES2
	WHERE NOMBRE_VENDEDOR LIKE 'Jorge Medina'
) 
WHERE NOMBRE_VENDEDOR LIKE 'Juan Villalba';
	
