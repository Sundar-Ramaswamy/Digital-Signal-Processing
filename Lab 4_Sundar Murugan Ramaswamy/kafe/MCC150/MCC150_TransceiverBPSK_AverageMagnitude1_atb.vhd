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

-- VHDL created from MCC150_TransceiverBPSK_AverageMagnitude1
-- VHDL created on Wed May 26 13:29:53 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity MCC150_TransceiverBPSK_AverageMagnitude1_atb is
end;

architecture normal of MCC150_TransceiverBPSK_AverageMagnitude1_atb is

component MCC150_TransceiverBPSK_AverageMagnitude1 is
    port (
        in_2_dv : in std_logic_vector(0 downto 0);  -- ufix1
        in_3_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_Mag : in std_logic_vector(11 downto 0);  -- ufix12
        out_2_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_3_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_1_AvgMag : out std_logic_vector(11 downto 0);  -- ufix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end component;

component MCC150_TransceiverBPSK_AverageMagnitude1_stm is
    port (
        in_2_dv_stm : out std_logic_vector(0 downto 0);
        in_3_dc_stm : out std_logic_vector(7 downto 0);
        in_1_Mag_stm : out std_logic_vector(11 downto 0);
        out_2_qv_stm : out std_logic_vector(0 downto 0);
        out_3_qc_stm : out std_logic_vector(7 downto 0);
        out_1_AvgMag_stm : out std_logic_vector(11 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end component;

signal in_2_dv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_3_dc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_1_Mag_stm : STD_LOGIC_VECTOR (11 downto 0);
signal out_2_qv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_3_qc_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_1_AvgMag_stm : STD_LOGIC_VECTOR (11 downto 0);
signal in_2_dv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_3_dc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_1_Mag_dut : STD_LOGIC_VECTOR (11 downto 0);
signal out_2_qv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_3_qc_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_1_AvgMag_dut : STD_LOGIC_VECTOR (11 downto 0);
        signal clk : std_logic;
        signal areset_n : std_logic;

begin

-- Channelized data in real output
checkChannelIn : process (clk, areset_n, in_1_Mag_dut, in_1_Mag_stm)
begin
END PROCESS;


-- Channelized data out check
checkChannelOut : process (clk, areset_n, out_1_AvgMag_dut, out_1_AvgMag_stm)
variable mismatch_out_2_qv : BOOLEAN := FALSE;
variable mismatch_out_3_qc : BOOLEAN := FALSE;
variable mismatch_out_1_AvgMag : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset_n = '0')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_2_qv := FALSE;
        mismatch_out_3_qc := FALSE;
        mismatch_out_1_AvgMag := FALSE;
        IF ( (out_2_qv_dut /= out_2_qv_stm)) THEN
            mismatch_out_2_qv := TRUE;
            report "mismatch in out_2_qv signal" severity Failure;
        END IF;
        IF (out_2_qv_dut = "1") THEN
            IF ( (out_3_qc_dut /= out_3_qc_stm)) THEN
                mismatch_out_3_qc := TRUE;
                report "mismatch in out_3_qc signal" severity Warning;
            END IF;
            IF ( (out_1_AvgMag_dut /= out_1_AvgMag_stm)) THEN
                mismatch_out_1_AvgMag := TRUE;
                report "mismatch in out_1_AvgMag signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_out_2_qv = TRUE or mismatch_out_3_qc = TRUE or mismatch_out_1_AvgMag = TRUE) THEN
            ok := FALSE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Failure;
        END IF;
    END IF;
END PROCESS;


dut : MCC150_TransceiverBPSK_AverageMagnitude1 port map (
    in_2_dv_stm,
    in_3_dc_stm,
    in_1_Mag_stm,
    out_2_qv_dut,
    out_3_qc_dut,
    out_1_AvgMag_dut,
        clk,
        areset_n
);

sim : MCC150_TransceiverBPSK_AverageMagnitude1_stm port map (
    in_2_dv_stm,
    in_3_dc_stm,
    in_1_Mag_stm,
    out_2_qv_stm,
    out_3_qc_stm,
    out_1_AvgMag_stm,
        clk,
        areset_n
);

end normal;
