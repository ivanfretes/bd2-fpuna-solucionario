/*

	Ejercicio 1

	Desarrolle un PL/SQL anónimo que calcule la liquidación de salarios del mes de Agosto del 2011. El PL/SQL deberá realizar lo siguiente:
		* Insertar un registro de cabecera de LIQUIDACIÓN correspondiente a agosto del 2011.
 		* Recorrer secuencialmente el archivo de empleados y calcular la liquidación de cada empleado de la siguiente manera:
			
			- salario básico = asignación correspondiente a la categoría de la posición vigente
			
			- descuento por IPS = 9,5% del salario
			
			- bonificaciónxventas= a la suma de la bonificación obtenida a 

			partir de las ventas realizadas por ese empleado en el mes de agosto del 2011 (la bonificación es calculada de acuerdo a los artículos vendidos).
			
			- líquido = salario básico – descuento x IPS + bonificación (si corresponde).


	 * Insertar la liquidación calculada en la PLANILLA con el ID de la cabecera de liquidación creada
*/

DECLARE
	CURSOR CUR_EMP IS
		SELECT * 
		FROM B_PLANILLA P
		INNER JOIN B_EMPLEADO E
		ON P.CEDULA = E.CEDULA
		INNER JOIN B_LIQUIDACION L
		ON L.ID = P.ID_LIQUIDACION
		WHERE EXTRACT(YEAR FROM L.FECHA_LIQUIDACION) = 2011
		AND EXTRACT(MONTH FROM L.FECHA_LIQUIDACION) = 08
		

BEGIN
	INSERT INTO B_LIQUIDACION(FECHA_LIQUIDACION, ANIO, MES)
	VALUES(SYSDATE, '2011','08');

	FOR REG_EMP IN CUR_EMP LOOP
 		SALARIO BASICO - ASIGNACION
 		DESCUENTO POR IPS - ASIGNACION * 0.095
 		BONIFICACIONXVENTAS - 
	END LOOP;
END;