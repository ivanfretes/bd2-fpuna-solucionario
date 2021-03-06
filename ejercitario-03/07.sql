/*
	Ejercicio 7

	Para tener una idea de movimientos, se desea conocer el volumen (cantidad) de ventas por mes que se hicieron por cada artículo durante el año 2012. Debe listar también los artículos que no tuvieron movimiento. La consulta debe lucir así:

	Nombre Articulo | Ene | Feb |  ... | Dic
*/

WITH ARTICULO_VENTA AS (
	SELECT
		A.ID,
		A.NOMBRE NOMBRE_ARTICULO,
		SUM(DV.CANTIDAD) CANTIDAD_VENTAS,
		SUM(DC.CANTIDAD * DV.PRECIO) MONTO_VENTAS,
		DV.ID_VENTA 
	FROM B_ARTICULOS A
	LEFT JOIN B_DETALLE_VENTAS DV
	ON DV.ID_ARTICULO = A.ID
	GROUP BY A.ID, A.NOMBRE_ARTICULO, DC.CANTIDAD, DV.CANTIDAD
)

SELECT 
	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END ENE

	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END FEB

	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END MAR

	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END ABR

	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END MAY

	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END JUN

	CASE EXTRACT(MONTH FROM C.FECHA)
		WHEN 1 THEN 
			SUM(S.)
	END JUL

FROM ARTICULO_COMPRA_VENTA A
INNER JOIN B_COMPRAS C
ON C.ID = A.ID_COMPRA
INNER JOIN B_VENTAS V
ON V.ID = A.ID_VENTA
WHERE EXTRACT(YEAR FROM C.FECHA) = 2012