/*

	Ejercicio 7

	Cree un bloque PL/SQL que acepte por teclado el nombre de un usuario de la BD y devuelva el tablespace asignado por default y el nombre del profile.
*/

DECLARE
	V_USERNAME				VARCHAR2(30) NOT NULL;

	V_DEFAULT_TABLESPACE	VARCHAR2(50);
	V_PROFILE_NAME			VARCHAR2(50);

BEGIN
	V_USERNAME := &a;

	SELECT DEFAULT_TABLESPACE, PROFILE_NAME
	INTO V_DEFAULT_TABLESPACE, V_PROFILE_NAME
	FROM DBA_USERS
	WHERE USERNAME=V_USERNAME;

	DBMS_OUTPUT.PUT_LINE(
		'Tablespace por defecto: ' || V_DEFAULT_TABLESPACE || '\n' ||
		'Nombre del Profile: ' || V_PROFILE_NAME
	);
END