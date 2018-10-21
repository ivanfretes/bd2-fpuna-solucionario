SET SERVER OUTPUT ON

DECLARE
	number_capicua			NUMBER(12) NOT NULL;	
	text_capicua			VARCHAR2(12) NOT NULL;	
BEGIN
	LOOP
		-- Lectura del numero

		number_capicua := &a ;
		text_capicua := TO_CHAR(number_capicua ,'FM999999');


		IF SUBSTR(text_capicua, 0, LENGTH(text_capicua)) = 
	   	   SUBSTR(text_capicua, LENGTH(text_capicua), 0) 
			DBMS_OUTPUTS.PUT_LINE("NUMERO ES PALINDROMO");
		ELSE
			DBMS_OUTPUTS.PUT_LINE("NUMERO NO ES PALINDROMO");
		END IF

		-- Cualquier valor negativo termina la ejecución
		EXIT WHEN number_capicua < 0
	END LOOP;

END;