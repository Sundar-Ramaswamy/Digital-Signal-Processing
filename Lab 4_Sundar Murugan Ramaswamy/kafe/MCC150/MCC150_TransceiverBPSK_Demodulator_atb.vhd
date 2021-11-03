-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.0 (Release Build #614)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from MCC150_TransceiverBPSK_Demodulator
-- VHDL created on Wed May 26 13:29:53 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity MCC150_TransceiverBPSK_Demodulator_atb is
end;

architecture normal of MCC150_TransceiverBPSK_Demodulator_atb is

component MCC150_TransceiverBPSK_Demodulator is
    port (
        in_3_dv : in std_logic_vector(0 downto 0);  -- ufix1
        in_4_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_I_in : in std_logic_vector(13 downto 0);  -- sfix14
        in_2_Q_in : in std_logic_vector(13 downto 0);  -- sfix14
        out_3_Qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_4_Qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_1_I_Out : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_Q_Out : out std_logic_vector(13 downto 0);  -- sfix14
        clk : in std_logic;
        areset_n : in std_logic
    );
end component;

component MCC150_TransceiverBPSK_Demodulator_stm is
    port (
        in_3_dv_stm : out std_logic_vector(0 downto 0);
        in_4_dc_stm : out std_logic_vector(7 downto 0);
        in_1_I_in_stm : out std_logic_vector(13 downto 0);
        in_2_Q_in_stm : out std_logic_vector(13 downto 0);
        out_3_Qv_stm : out std_logic_vector(0 downto 0);
        out_4_Qc_stm : out std_logic_vector(7 downto 0);
        out_1_I_Out_stm : out std_logic_vector(0 downto 0);
        out_2_Q_Out_stm : out std_logic_vector(13 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end component;

signal in_3_dv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_4_dc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_1_I_in_stm : STD_LOGIC_VECTOR (13 downto 0);
signal in_2_Q_in_stm : STD_LOGIC_VECTOR (13 downto 0);
signal out_3_Qv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_4_Qc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_1_I_Out_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_Q_Out_stm : STD_LOGIC_VECTOR (13 downto 0);
signal in_3_dv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_4_dc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_1_I_in_dut : STD_LOGIC_VECTOR (13 downto 0);
signal in_2_Q_in_dut : STD_LOGIC_VECTOR (13 downto 0);
signal out_3_Qv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_4_Qc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_1_I_Out_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_Q_Out_dut : STD_LOGIC_VECTOR (13 downto 0);
        signal clk : std_logic;
        signal areset_n : std_logic;

begin

-- Channelized data in real output
checkChannelIn : process (clk, areset_n, in_1_I_in_dut, in_1_I_in_stm, in_2_Q_in_dut, in_2_Q_in_stm)
begin
END PROCESS;


-- Channelized data out check
checkChannelOut : process (clk, areset_n, out_1_I_Out_dut, out_1_I_Out_stm, out_2_Q_Out_dut, out_2_Q_Out_stm)
variable mismatch_out_3_Qv : BOOLEAN := FALSE;
variable mismatch_out_4_Qc : BOOLEAN := FALSE;
variable mismatch_out_1_I_Out : BOOLEAN := FALSE;
variable mismatch_out_2_Q_Out : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset_n = '0')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_3_Qv := FALSE;
        mismatch_out_4_Qc := FALSE;
        mismatch_out_1_I_Out := FALSE;
        mismatch_out_2_Q_Out := FALSE;
        IF ( (out_3_Qv_dut /= out_3_Qv_stm)) THEN
            mismatch_out_3_Qv := TRUE;
            report "mismatch in out_3_Qv signal" severity Failure;
        END IF;
        IF (out_3_Qv_dut = "1") THEN
            IF ( (out_4_Qc_dut /= out_4_Qc_stm)) THEN
                mismatch_out_4_Qc := TRUE;
                report "mismatch in out_4_Qc signal" severity Warning;
            END IF;
            IF ( (out_1_I_Out_dut /= out_1_I_Out_stm)) THEN
                mismatch_out_1_I_Out := TRUE;
                report "mismatch in out_1_I_Out signal" severity Warning;
            END IF;
            IF ( (out_2_Q_Out_dut /= out_2_Q_Out_stm)) THEN
                mismatch_out_2_Q_Out := TRUE;
                report "mismatch in out_2_Q_Out signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_out_3_Qv = TRUE or mismatch_out_4_Qc = TRUE or mismatch_out_1_I_Out = TRUE or mismatch_out_2_Q_Out = TRUE) THEN
            ok := FALSE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Failure;
        END IF;
    END IF;
END PROCESS;


dut : MCC150_TransceiverBPSK_Demodulator port map (
    in_3_dv_stm,
    in_4_dc_stm,
    in_1_I_in_stm,
    in_2_Q_in_stm,
    out_3_Qv_dut,
    out_4_Qc_dut,
    out_1_I_Out_dut,
    out_2_Q_Out_dut,
        clk,
        areset_n
);

sim : MCC150_TransceiverBPSK_Demodulator_stm port map (
    in_3_dv_stm,
    in_4_dc_stm,
    in_1_I_in_stm,
    in_2_Q_in_stm,
    out_3_Qv_stm,
    out_4_Qc_stm,
    out_1_I_Out_stm,
    out_2_Q_Out_stm,
        clk,
        areset_n
);

end normal;
