/*

	Ejercicio 6

	Cree un bloque PL/SQL que dada una variable alfanumérica (cuyo valor deberá ingresarse por teclado). Deberá imprimir dicha variable tal como se la introdujo, y posteriormente intercambiada. Ejemplo: Si intruduce ‘123456’ deberá mostrar en pantalla ‘654321’ :
*/

DECLARE
	V_DATA			VARCHAR2 NOT NULL;
	V_DATA_REVERSE 	VARCHAR2 NOT NULL := '';
	V_LETRA			VARCHAR2(1);
BEGIN
	V_DATA	:= 	&a;

	FOR indice IN 1..LENGTH(V_DATA) LOOP
			V_LETRA := SUBSTR(V_DATA, indice, 1);	
			V_DATA_REVERSE := V_LETRA || V_DATA_REVERSE;	
	END LOOP;

	DBMS_OUTPUT.PUT_LINE('Valor original: ' || V_DATA);	
	DBMS_OUTPUT.PUT_LINE('Valor revertido: ' || V_DATA_REVERSE);	
END;
