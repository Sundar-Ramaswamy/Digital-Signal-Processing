-- safe_path for MCC150_TransmitterBPSK given rtl dir is ./rtl (modelsim)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE MCC150_TransmitterBPSK_safe_path is
	FUNCTION safe_path( path: string ) RETURN string;
END MCC150_TransmitterBPSK_safe_path;

PACKAGE body MCC150_TransmitterBPSK_safe_path IS
	FUNCTION safe_path( path: string )
		RETURN string IS
	BEGIN
		RETURN path;
	END FUNCTION safe_path;
END MCC150_TransmitterBPSK_safe_path;
