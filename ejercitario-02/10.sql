/*

	Ejercicio 10

	Utilice la función LAST_DAY para determinar si este año es bisiesto o no. Con CASE y con DECODE, haga aparecer la expresión ‘bisiesto’ o ‘no bisiesto’ según corresponda. (En un año bisiesto el mes de febrero tiene 29 días)
*/

SELECT 
	CASE EXTRACT(DAY FROM LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE,'YEAR'),1)))
		WHEN 29 THEN
			'BISIESTO'
		ELSE
			'NO BISIESTO'
	END TIPO_ANHO
FROM DUAL