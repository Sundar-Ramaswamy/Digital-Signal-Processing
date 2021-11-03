-- safe_path for MCC150_TransceiverBPSK given rtl dir is ../kafe (quartus)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE MCC150_TransceiverBPSK_safe_path is
	FUNCTION safe_path( path: string ) RETURN string;
END MCC150_TransceiverBPSK_safe_path;

PACKAGE body MCC150_TransceiverBPSK_safe_path IS
	FUNCTION safe_path( path: string )
		RETURN string IS
	BEGIN
		return string'("../kafe/") & path;
	END FUNCTION safe_path;
END MCC150_TransceiverBPSK_safe_path;
