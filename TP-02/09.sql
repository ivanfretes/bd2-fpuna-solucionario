CREATE OR REPLACE TYPE T_REALIZA_VUELO AS OBJECT(
	ID_VUELO NUMBER(12),
	NRO_VUELO VARCHAR2 (6),
	AEROPUERTO_SALIDA VARCHAR2(7),
	AEROPUERTO_LLEGADA VARCHAR2(7),
	ESTADO VARCHAR2(1),
	FECHA_SALIDA_REAL DATE,
	PASAJEROS TAB_PASAJEROS

	STATIC FUNCTION F_VUELO_REALIZADO RETURN T_REALIZA_VUELO,
	MEMBER PROCEDURE P_ASIGNAR_PASAJEROS 
);


CREATE OR REPLACE TYPE BODY T_REALIZA_VUELO IS
	--FUNCION ESTATICA--
	STATIC FUNCTION F_VUELO_REALIZADO(V_ID_VUELO NUMBER) 
	RETURN T_REALIZA_VUELO
	
		V_ID_VUE NUMBER;
		V_NRO_VUELO VARCHAR2(6);
		V_AEROPUERTO_SALIDA VARCHAR2(7);
		V_AEROPUERTO_LLEGADA VARCHAR2(7);
		V_ESTADO VARCHAR2(1);
		V_HORA_SALIDA_REAL DATE;

		V_TEMP T_REALIZA_VUELO;

		BEGIN 
	
			SELECT 
				RV.ID_ESCALA ,
				VE.NUMERO_VUELO,
				VE.AEROPUERTO_SALIDA,
				VE.AEROPUERTO_LLEGADA ,
				RV.ESTADO,RV.HORA_PARTIDA_REAL
			INTO 
				V_ID_VUE,
				V_NRO_VUELO,
				V_AEROPUERTO_SALIDA,
				V_AEROPUERTO_LLEGADA,
				V_ESTADO,
				V_HORA_SALIDA_REAL 
			FROM VUELO_ESCALA VE 
			JOIN REALIZACION_VUELO RV 
			ON VE.ID_ESCALA = RV.ID_ESCALA 
			WHERE RV.ID_VUELO = V_ID_VUELO;

			V_TEMP := T_REALIZA_VUELO(
				V_ID_VUELO,
				V_NRO_VUELO,
				V_AEROPUERTO_SALIDA,
				V_AEROPUERTO_LLEGADA,
				V_ESTADO,
				V_HORA_SALIDA_REAL
			);


		RETURN V_TEMP;
	END;	