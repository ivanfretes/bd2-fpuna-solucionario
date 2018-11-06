/*

	Ejercicio 2

	Cree la tabla ERRORES_ORACLE con un solo campo:
		MENSAJE_ERROR VARCHAR2(150).
	
	Cree el procedimiento P_OBTENER_ERRORES que hará lo siguiente:
		- Definir un ciclo de 1 a 9999,
		- Por cada iteración, obtener el mensaje ORACLE del error correspondiente al número de la iteración.

		Recuerde que los números de mensaje de ORACLE son negativos. 
		Inserte en la tabla el mensaje de error obtenido.
*/
CREATE TABLE ERRORES_ORACLE(
	MENSAJE_ERROR VARCHAR2(150)
);


CREATE OR REPLACE PROCEDURE P_OBTENER_ERRORES
AS 
	v_error_code 	NUMBER(4);
	v_error_msg 	VARCHAR(255);
BEGIN

	FOR IND IN 1..9999 LOOP
		v_error_code := IND * (-1);
		v_error_msg :=  SQLERRM(v_error_code);
		DBMS.OUTPUT.LINE(TO_CHAR(v_error_code) || ':' || v_error_msg);
		
		IF v_error_msg NOT LIKE '%%' THEN 
			INSERT INTO ERRORS_ORACLE(MENSAJE_ERROR) VALUES(v_error_msg);
		END IF;
		
	END FOR;

END



