/*
	Ejercicio 6

	Liste el volumen (cantidad) y monto de compras y ventas que se hicieron por cada artículo durante el año 2011. Debe listar también los artículos que no tuvieron movimiento. Muestre ID, ARTICULO NOMBRE ARTICULO CANT.COMPRAS MONTO COMPRAS MONTO_VENTAS
*/

WITH ARTICULO_COMPRA_VENTA AS (
	SELECT
		A.ID,
		A.NOMBRE NOMBRE_ARTICULO,
		SUM(DC.CANTIDAD) CANTIDAD_COMPRAS,
		SUM(DC.CANTIDAD * DC.PRECIO_COMPRA) MONTO_COMPRAS,
		SUM(DV.CANTIDAD) CANTIDAD_VENTAS,
		SUM(DC.CANTIDAD * DV.PRECIO) MONTO_VENTAS,

		DC.ID_COMPRA,
		DV.ID_VENTA 
	FROM B_ARTICULOS A
	LEFT JOIN B_DETALLE_COMPRAS DC
	ON DC.ID_ARTICULO = A.ID
	LEFT JOIN B_DETALLE_VENTAS DV
	ON DV.ID_ARTICULO = A.ID
	GROUP BY A.ID, A.NOMBRE_ARTICULO, DC.CANTIDAD, DV.CANTIDAD
)

SELECT 
	A.ID,
	A.NOMBRE_ARTICULO,
	A.CANTIDAD_COMPRAS,
	A.MONTO_COMPRAS,
	A.CANTIDAD_VENTAS,
	A.MONTO_VENTAS
FROM ARTICULO_COMPRA_VENTA A
LEFT JOIN B_COMPRAS C
ON C.ID = A.ID_COMPRA
LEFT JOIN B_VENTAS V
ON V.ID = A.ID_VENTA
WHERE EXTRACT(YEAR FROM C.FECHA) = 2011
GROUP BY A.ID;