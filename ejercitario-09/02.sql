/*

	Ejercicio 2

	Realice lo siguiente
	 Crear la tabla SECUENCIADOR con las siguientes columnas
		- NUMERO NUMBER
		- VALOR_PAR VARCHAR2(30)
		- VALOR_IMPAR

	 Desarrolle un PL/SQL anónimo que permita insertar 100 filas. En la primera columna se insertará el valor del contador y en la segunda y tercera columnas, el número concatenado con la expresión “es par” o “es impar” según sea par o impar. Utilice la función MOD.
*/


CREATE OR REPLACE TABLE SECUENCIADOR(
	NUMERO 			NUMBER,
	VALOR_PAR 		VARCHAR2(30),
	VALOR_IMPAR 	VARCHAR2(30)
);

DECLARE
	V_CANT_FILAS	NUMBER	:= 100;
BEGIN 

	FOR indice IN 1..V_CANT_FILAS LOOP
		IF MOD(indice,2) = 0 THEN
			INSERT INTO SECUENCIADOR(NUMERO, VALOR_PAR)
			VALUES(indice, indice || ' es par');
		ELSE 
			INSERT INTO SECUENCIADOR(NUMERO, VALOR_IMPAR)
			VALUES(indice, indice || ' es impar');
		END IF;
	END LOOP;

END;
