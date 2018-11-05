/*
	Ejercicio 16

	El área de CREDITOS Y COBRANZAS solicita un informe de las ventas a crédito efectuadas en el año 2018 y cuyas cuotas tienen atraso en el pago. A las cuotas que se encuentran en dicha situación se le aplica una tasa de interés del 0.5% por cada día de atraso.

	Se considera que una cuota está en mora cuando ya pasó la fecha de vencimiento y no existe aún pago alguno. Se pide mostrar los siguientes datos y ordenar de forma descendente por días de atraso.
*/
SELECT 
	(E.NOMBRE || ' ' || E.APELLIDO) VENDEDOR, 
	
	CASE C.TIPO_PERSONA
		WHEN 'F' THEN C.CEDULA
		ELSE C.RUC
	END RUC_CI, 

	(C.NOMBRE || ' ' || C.APELLIDO) CLIENTE,
	(VP.NUMERO_CUOTA || '/' || V.PLAZO) CUOTA,
	VP.VENCIMIENTO 	FECHA_VTO,
	TO_CHAR(VP.MONTO_CUOTA,'9G999G999G999') MONTO_CUOTA,  

	-- DIAS DE ATRASO
	(TRUNC(SYSDATE) - TRUNC(VP.VENCIMIENTO)) AS DIAS_DE_ATRASO
    
    -- INTERES
	TO_CHAR((TRUNC(SYSDATE) - TRUNC(VP.VENCIMIENTO)) * (VP.MONTO_CUOTA*0.5/100)),
		'9G999G999G999')) INTERES,

	-- [ Monto día de interes] 
	-- multiplicado por [ cant de dias de mora ]
	-- Sumado al monto inicial de la cuota

	TO_CHAR(ROUND(
		((TRUNC(SYSDATE) - TRUNC(VP.VENCIMIENTO)) * (VP.MONTO_CUOTA*0.5/100)) + 
		VP.MONTO_CUOTA),
	'9G999G999G999') MONTO_A_PAGAR 

FROM B_VENTAS V
INNER JOIN B_PLAN_PAGO VP
ON V.ID = VP.ID_VENTA
INNER JOIN B_PERSONAS C
ON V.ID_CLIENTE = C.ID
INNER JOIN B_EMPLEADOS E
ON V.CEDULA_VENDEDOR = E.CEDULA

WHERE V.TIPO_VENTA = 'CR'
AND (TRUNC(SYSDATE) - TRUNC(VP.VENCIMIENTO)) > 0
AND VP.FECHA_PAGO IS NULL
AND EXTRACT(YEAR FROM V.FECHA) = 2018
ORDER BY DIAS_DE_ATRASO DESC

