/**
	Ejercicio 5

	Cree el trigger T_VERIFICAR_RESERVA que deberá dispararse antes de  INSERTAR un registro en la tabla RESERVA_TRAMO.  El trigger deberá determinar con la función F_DETERMINAR_DISPONIBILIDAD del paquete PCK_VUELO, la cantidad de asientos libres para el vuelo y fecha. Si la reserva a incorporar supera la capacidad, debe impedir la inserción. 
**/

CREATE OR REPLACE TRIGGER T_VERIFICAR_RESERVA 
BEFORE INSERT ON RESERVA_TRAMO
DECLARE
	V_CANT_DISPONIBLES 	NUMBER;
BEGIN
	V_CANT_DISPONIBLES := PKG_VUELO.F_DETERMINAR_DISPONIBILIDAD(
		:new.ID_ESCALA, 
		:new.FECHA_SALIDA_PROGRAMADA, 
		:new.CLASE
	);

	-- Si no hay asientos disponibles
	IF V_CANT_DISPONIBLES == 0 THEN
		RAISE_APPLICATION_ERROR(-20002, 'No hay asientos disponibles');
	END IF;
END;