/**

	10. Utilización de campos BLOB
		b. Crear el directorio ‘MIS_IMAGENES’. Copie en la carpeta física las imágenes de los diversos tipos de aviones que están en el archivo comprimido ‘IMÁGENES_AVIONES’. 
**/

-- a. Altere la tabla TIPO_APARATO agregando una columna llamada IMAGEN.
ALTER TABLE TIPO_APARATO ADD IMAGEN BLOB;

/*
	c. 
	Desarrolle el procedimiento P_ADJUNTAR_IMAGENES, que actualiza los registros de la tabla TIPO_APARATO, con las imágenes correspondientes. Las imágenes están nombradas así PLANE99.jpg   en donde ‘99’ es el tipo_aparato.
*/
CREATE OR REPLACE PROCEDURE P_ADJUNTAR_IMAGENES
IS
BEGIN
	

END;