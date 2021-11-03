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

-- VHDL created from MCC150_TransceiverBPSK_Modulator
-- VHDL created on Wed May 26 13:29:53 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity MCC150_TransceiverBPSK_Modulator_atb is
end;

architecture normal of MCC150_TransceiverBPSK_Modulator_atb is

component MCC150_TransceiverBPSK_Modulator is
    port (
        in_1_dv_x : in std_logic_vector(0 downto 0);  -- ufix1
        in_2_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_3_Data : in std_logic_vector(0 downto 0);  -- ufix1
        out_1_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_I : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end component;

component MCC150_TransceiverBPSK_Modulator_stm is
    port (
        in_1_dv_x_stm : out std_logic_vector(0 downto 0);
        in_2_dc_stm : out std_logic_vector(7 downto 0);
        in_3_Data_stm : out std_logic_vector(0 downto 0);
        out_1_qv_stm : out std_logic_vector(0 downto 0);
        out_2_qc_stm : out std_logic_vector(7 downto 0);
        out_3_I_stm : out std_logic_vector(11 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end component;

signal in_1_dv_x_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_2_dc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_3_Data_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_1_qv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_qc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_I_stm : STD_LOGIC_VECTOR (11 downto 0);
signal in_1_dv_x_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_2_dc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_3_Data_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_1_qv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_qc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_I_dut : STD_LOGIC_VECTOR (11 downto 0);
        signal clk : std_logic;
        signal areset_n : std_logic;

begin

-- Channelized data in real output
checkChannelIn : process (clk, areset_n, in_3_Data_dut, in_3_Data_stm)
begin
END PROCESS;


-- Channelized data out check
checkChannelOut : process (clk, areset_n, out_3_I_dut, out_3_I_stm)
variable mismatch_out_1_qv : BOOLEAN := FALSE;
variable mismatch_out_2_qc : BOOLEAN := FALSE;
variable mismatch_out_3_I : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset_n = '0')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_1_qv := FALSE;
        mismatch_out_2_qc := FALSE;
        mismatch_out_3_I := FALSE;
        IF ( (out_1_qv_dut /= out_1_qv_stm)) THEN
            mismatch_out_1_qv := TRUE;
            report "mismatch in out_1_qv signal" severity Failure;
        END IF;
        IF (out_1_qv_dut = "1") THEN
            IF ( (out_2_qc_dut /= out_2_qc_stm)) THEN
                mismatch_out_2_qc := TRUE;
                report "mismatch in out_2_qc signal" severity Warning;
            END IF;
            IF ( (out_3_I_dut /= out_3_I_stm)) THEN
                mismatch_out_3_I := TRUE;
                report "mismatch in out_3_I signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_out_1_qv = TRUE or mismatch_out_2_qc = TRUE or mismatch_out_3_I = TRUE) THEN
            ok := FALSE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Failure;
        END IF;
    END IF;
END PROCESS;


dut : MCC150_TransceiverBPSK_Modulator port map (
    in_1_dv_x_stm,
    in_2_dc_stm,
    in_3_Data_stm,
    out_1_qv_dut,
    out_2_qc_dut,
    out_3_I_dut,
        clk,
        areset_n
);

sim : MCC150_TransceiverBPSK_Modulator_stm port map (
    in_1_dv_x_stm,
    in_2_dc_stm,
    in_3_Data_stm,
    out_1_qv_stm,
    out_2_qc_stm,
    out_3_I_stm,
        clk,
        areset_n
);

end normal;
