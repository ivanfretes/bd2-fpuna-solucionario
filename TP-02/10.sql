/**

	10. Utilización de campos BLOB
**/

-- a. Altere la tabla TIPO_APARATO agregando una columna llamada IMAGEN.
ALTER TABLE TIPO_APARATO ADD IMAGEN BLOB DEFAULT EMPTY_BLOB();

/*
	b. 
	Crear el directorio ‘MIS_IMAGENES’. Copie en la carpeta física las imágenes de los diversos tipos de aviones que están en el archivo comprimido ‘IMÁGENES_AVIONES’. 
*/
CREATE DIRECTORY 'MIS_IMAGENES' AS 'C:\MIS_IMAGENES';
GRANT WRITE ON DIRECTORY MIS_IMAGENES TO PUBLIC; 
/*
	c. 
	Desarrolle el procedimiento P_ADJUNTAR_IMAGENES, que actualiza los registros de la tabla TIPO_APARATO, con las imágenes correspondientes. Las imágenes están nombradas así PLANE99.jpg   en donde ‘99’ es el tipo_aparato.
*/
CREATE OR REPLACE PROCEDURE P_ADJUNTAR_IMAGENES
IS
	nombrearch 	VARCHAR2(30);
	arch 		BFILE;
	iblob		BLOB;

	CURSOR CUR_TIPO_APARATO IS SELECT * FROM TIPO_APARATO FOR UPDATE;
BEGIN
	FOR REG IN CUR_TIPO_APARATO LOOP
		BEGIN
			nombrearch := 'PLANE' || TO_CHAR(REG.TIPO_APARATO) || '.jpg';


			-- Handler del archivo
			arch:= BFILENAME('MIS_IMAGENES',nombrearch);
			
			-- Apertura del archivo
			DBMS_LOB.FILEOPEN(arch, DBMS_LOB.FILE_READONLY);

			DBMS_LOB.LOADFROMFILE(
				iblob, 
				v_flob,
				DBMS_LOB.GETLENGTH(arch)
			);

			UPDATE TIPO_APARATO SET IMAGEN = iblob
			WHERE CURRENT OF CUR_TIPO_APARATO;
			
			DBMS_LOB.FILECLOSE(arch);
			COMMIT;
			
		EXCEPTION
			WHEN OTHERS THEN
				NULL;
		END;
	END LOOP;
END;