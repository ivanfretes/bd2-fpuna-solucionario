/*

	Ejercicio 14

	Liste ID y NOMBRE de todos los artículos que no están incluidos en ninguna VENTA. Debe utilizar necesariamente la sentencia MINUS.
*/

SELECT ID, NOMBRE
FROM B_ARTICULOS
MINUS
SELECT DV.ID_ARTICULO, A.NOMBRE
FROM B_DETALLE_VENTAS DV
INNER JOIN B_ARTICULOS A
ON DV.ID_ARTICULO = A.ID
