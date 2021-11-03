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

-- VHDL created from MCC150_TransmitterBPSK_x
-- VHDL created on Wed Apr 14 13:51:15 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

USE work.MCC150_TransmitterBPSK_x_safe_path.all;
entity MCC150_TransmitterBPSK_x is
    port (
        I_out : out std_logic_vector(11 downto 0);  -- sfix12
        Q_out : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransmitterBPSK_x;

architecture normal of MCC150_TransmitterBPSK_x is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component MCC150_TransmitterBPSK_x_Modulator is
        port (
            in_1_dv_x : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_2_dc : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_3_Data : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_1_qv : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_qc : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_3_I : out std_logic_vector(11 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransmitterBPSK_x_PRBSGenerator is
        port (
            out_1_qv : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_qc : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_3_PRBS : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Modulator_out_3_I : STD_LOGIC_VECTOR (11 downto 0);
    signal PRBSGenerator_out_1_qv : STD_LOGIC_VECTOR (0 downto 0);
    signal PRBSGenerator_out_2_qc : STD_LOGIC_VECTOR (7 downto 0);
    signal PRBSGenerator_out_3_PRBS : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- PRBSGenerator(BLACKBOX,4)
    thePRBSGenerator : MCC150_TransmitterBPSK_x_PRBSGenerator
    PORT MAP (
        out_1_qv => PRBSGenerator_out_1_qv,
        out_2_qc => PRBSGenerator_out_2_qc,
        out_3_PRBS => PRBSGenerator_out_3_PRBS,
        clk => clk,
        areset_n => areset_n
    );

    -- Modulator(BLACKBOX,3)
    theModulator : MCC150_TransmitterBPSK_x_Modulator
    PORT MAP (
        in_1_dv_x => PRBSGenerator_out_1_qv,
        in_2_dc => PRBSGenerator_out_2_qc,
        in_3_Data => PRBSGenerator_out_3_PRBS,
        out_3_I => Modulator_out_3_I,
        clk => clk,
        areset_n => areset_n
    );

    -- I_out(GPOUT,5)
    I_out <= Modulator_out_3_I;

    -- Const_rsrvd_fix(CONSTANT,2)
    Const_rsrvd_fix_q <= "000000000000";

    -- Q_out(GPOUT,6)
    Q_out <= Const_rsrvd_fix_q;

END normal;
