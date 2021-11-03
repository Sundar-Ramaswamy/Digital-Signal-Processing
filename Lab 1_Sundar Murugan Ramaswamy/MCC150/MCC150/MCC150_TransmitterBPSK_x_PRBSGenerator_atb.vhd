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

-- VHDL created from MCC150_TransmitterBPSK_x_PRBSGenerator
-- VHDL created on Wed Apr 14 13:51:15 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity MCC150_TransmitterBPSK_x_PRBSGenerator_atb is
end;

architecture normal of MCC150_TransmitterBPSK_x_PRBSGenerator_atb is

component MCC150_TransmitterBPSK_x_PRBSGenerator is
    port (
        out_1_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_PRBS : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset_n : in std_logic
    );
end component;

component MCC150_TransmitterBPSK_x_PRBSGenerator_stm is
    port (
        out_1_qv_stm : out std_logic_vector(0 downto 0);
        out_2_qc_stm : out std_logic_vector(7 downto 0);
        out_3_PRBS_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end component;

signal out_1_qv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_qc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_PRBS_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_1_qv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_qc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_PRBS_dut : STD_LOGIC_VECTOR (0 downto 0);
        signal clk : std_logic;
        signal areset_n : std_logic;

begin

-- Channelized data out check
checkChannelOut : process (clk, areset_n, out_3_PRBS_dut, out_3_PRBS_stm)
variable mismatch_out_1_qv : BOOLEAN := FALSE;
variable mismatch_out_2_qc : BOOLEAN := FALSE;
variable mismatch_out_3_PRBS : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset_n = '0')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_1_qv := FALSE;
        mismatch_out_2_qc := FALSE;
        mismatch_out_3_PRBS := FALSE;
        IF ( (out_1_qv_dut /= out_1_qv_stm)) THEN
            mismatch_out_1_qv := TRUE;
            report "mismatch in out_1_qv signal" severity Failure;
        END IF;
        IF (out_1_qv_dut = "1") THEN
            IF ( (out_2_qc_dut /= out_2_qc_stm)) THEN
                mismatch_out_2_qc := TRUE;
                report "mismatch in out_2_qc signal" severity Warning;
            END IF;
            IF ( (out_3_PRBS_dut /= out_3_PRBS_stm)) THEN
                mismatch_out_3_PRBS := TRUE;
                report "mismatch in out_3_PRBS signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_out_1_qv = TRUE or mismatch_out_2_qc = TRUE or mismatch_out_3_PRBS = TRUE) THEN
            ok := FALSE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Failure;
        END IF;
    END IF;
END PROCESS;


dut : MCC150_TransmitterBPSK_x_PRBSGenerator port map (
    out_1_qv_dut,
    out_2_qc_dut,
    out_3_PRBS_dut,
        clk,
        areset_n
);

sim : MCC150_TransmitterBPSK_x_PRBSGenerator_stm port map (
    out_1_qv_stm,
    out_2_qc_stm,
    out_3_PRBS_stm,
        clk,
        areset_n
);

end normal;
