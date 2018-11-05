/*
	Ejercicio 3

	Liste el libro DIARIO correspondiente al mes de enero del año 2012, tomando en cuenta la cabecera y el detalle. Debe listar los siguientes datos:
	
	ID_Asiento, Fecha, Concepto, Nro.Linea, código cuenta, nombre cuenta, Monto débito,
	
	Monto crédito (haga aparecer el monto del crédito o débito según el valor del campo débito_crédito – D ó C)
*/

SELECT 
	C.ID ID_ASIENTO,
	C.FECHA,
	C.CONCEPTO,
	D.NRO_LINEA,
	CTA.CODIGO_CTA,
	CTA.NOMBRE_CTA,
	CASE DEBE_HABER
		WHEN 'D' THEN 
			IMPORTE
		ELSE 0
	END MONTO_DEBITO,
	CASE DEBE_HABER
		WHEN 'C' THEN 
			IMPORTE
		ELSE 0
	END MONTO_CREDITO
FROM B_DIARIO_DETALLE D 
INNER JOIN B_DIARIO_CABECERA C
ON C.ID = D.ID
INNER JOIN B_CUENTAS CTA
ON CTA.CODIGO_CTA = D.CODIGO_CTA
WHERE EXTRACT(MONTH FROM FECHA) = 1
AND EXTRACT(YEAR FROM FECHA) = 2012