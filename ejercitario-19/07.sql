/*
	Ejercicio 6

	Cree el procedimiento P_POBLAR_PROVEEDORES, el cual, en base a las COMPRAS realizadas, deberá verificar todos los proveedores y los artículos que nos han proveído, llenando la tabla PROVEEDORES.

*/

CREATE OR REPLACE PROCEDURE P_POBLAR_PROVEEDORES 
IS

	-- Listado de Proveedores
	CURSOR CUR_PROV IS 
		SELECT 
			DISTINCT P.ID_PROVEEDOR,
			P.NOMBRE || ' , ' || P.APELLIDO NOMBRE
		FROM B_COMPRAS C
		INNER JOIN B_PERSONAS P
		ON C.ID_PROVEEDOR = P.ID;


	-- Listado de Articulos
	CURSOR CUR_ARTICULOS(PROVEEDOR_ID NUMBER) IS	
		SELECT 
			A.ID
			A.NOMBRE NOMBRE_ARTICULO
		FROM B_DETALLE_COMPRAS DC
		INNER JOIN B_COMPRAS C
		ON C.ID = DC.ID_COMPRA
		INNER JOIN B_ARTICULOS A
		ON A.ID = DC.ID_ARTICULO
		WHERE C.ID_PROVEEDOR = PROVEEDOR_ID ;

	-- Indice interno de articulos por proveedor
	INDICE_ART	 NUMBER;

	-- Constructor del Varray
	V_COMPRAS  TAB_ARTICULOS := TAB_ARTICULOS();
BEGIN

	FOR REG_PROV IN CUR_PROV LOOP
		INDICE_CLIENTE := 0;
		V_COMPRAS.DELETE;

		FOR REG_COMPRA IN CUR_ARTICULOS(REG_PROV.ID_PROVEEDOR) LOOP
			V_COMPRAS.EXTENDS; -- Inicializa cada elemento
			INDICE_ART := INDICE_ART + 1;

			V_COMPRAS(IND) := T_ARTICULOS(
				REG_COMPRA.ID,
				REG_COMPRA.NOMBRE_ARTICULO
			);
		END LOOP;

		INSERT INTO PROVEEDORES2() VALUES(
			REG_PROV.ID_PROVEEDOR,
			REG_PROV.NOMBRE ,
			V_COMPRAS
		);
	END LOOP;
	COMMIT;
END;