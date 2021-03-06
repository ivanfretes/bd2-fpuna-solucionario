/*
	Ejercicio 3

	Cree el procedimiento P_LLENAR TABLA que deberá buscar los vendedores (a partir de las ventas realizadas en B_VENTAS), y determinar a cuántos clientes (personas) han vendido, llenando la tabla de vendedores. Preste atención al campo de tipo objeto
*/
CREATE OR REPLACE PROCEDURE P_LLENAR_TABLA IS
	
	CURSOR CUR_VENDEDOR IS 
		SELECT 
			DISTINCT V.CEDULA_VENDEDOR,
			E.NOMBRE || ' , ' || E.APELLIDO NOMBRE
		FROM B_VENTAS V 
		INNER JOIN B_EMPLEADOS E
		ON E.CEDULA = V.CEDULA_VENDEDOR;


	-- Listado de Clientes
	CURSOR CUR_CLIENTES(VENDEDOR_CEDULA NUMBER) IS	
		SELECT 
			DISTINCT V.ID_CLIENTE
			C.NOMBRE || ' , ' || C.APELLIDO NOMBRE
		FROM B_PERSONAS C
		INNER JOIN B_VENTAS V
		ON C.ID = V.ID_CLIENTE
		WHERE V.CEDULA = VENDEDOR_CEDULA;


	INDICE_CLIENTE		NUMBER;

	-- Constructor del Varray
	VARR_CLIENTE	CLIENTES := CLIENTES();
BEGIN
	

	FOR REG_VEND IN CUR_VENDEDOR LOOP
		INDICE_CLIENTE := 0;
		VARR_CLIENTE.DELETE;

		FOR REG_CLIENTE IN CUR_CLIENTES(REG_VEND.CEDULA_VENDEDOR) LOOP
			VARR_CLIENTE.EXTENDS;
			INDICE_CLIENTE := INDICE_CLIENTE + 1;

			IF INDICE_CLIENTE > 50 THEN
				EXIT;

			VARR_CLIENTE(INDICE_CLIENTE) := T_CLIENTE(
				REG_CLIENTE.ID,
				REG_CLIENTE.NOMBRE
			);
		END LOOP;

		INSERT INTO VENDEDORES2() VALUES(
			REG_VEND.CEDULA_VENDEDOR, 
			REG_VEND.NOMBRE,
			VARR_CLIENTE
		);
	END LOOP;
	COMMIT;
END;