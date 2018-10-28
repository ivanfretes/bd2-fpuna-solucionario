/**
	
	Ejercicio 6
	
	Cree el trigger T_VERIFICAR_TRIPULACION que se deberá disparar antes de INSERTAR en la tabla TRIPULACIÓN, el cual deberá controlar lo siguiente: Se debe  impedir que se incorpore a la tripulación de un vuelo, una persona que ya tiene expirada su patente. 

	Por cada realización de vuelo puede haber un solo comandante.
	Sólo puede agregarse un miembro a la tripulación de un vuelo confirmado. En cualquier otro estado debe rechazarse la modificación.
**/


CREATE OR REPLACE TRIGGER T_VERIFICAR_TRIPULACION 
BEFORE INSERT ON tripulacion
DECLARE
BEGIN
	

END;