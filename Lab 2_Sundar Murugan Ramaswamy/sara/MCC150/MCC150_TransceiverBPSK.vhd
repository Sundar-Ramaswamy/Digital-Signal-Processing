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

-- VHDL created from MCC150_TransceiverBPSK
-- VHDL created on Fri May 07 21:18:36 2021


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

library twentynm;
use twentynm.twentynm_components.twentynm_fp_mac;

USE work.MCC150_TransceiverBPSK_safe_path.all;
entity MCC150_TransceiverBPSK is
    port (
        I_in_x : in std_logic_vector(11 downto 0);  -- sfix12
        Q_in : in std_logic_vector(11 downto 0);  -- sfix12
        SampleIndex : in std_logic_vector(2 downto 0);  -- ufix3
        I_out : out std_logic_vector(11 downto 0);  -- sfix12
        Q_out : out std_logic_vector(11 downto 0);  -- sfix12
        Symb_I_x : out std_logic_vector(11 downto 0);  -- sfix12
        Symb_Q : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK;

architecture normal of MCC150_TransceiverBPSK is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component MCC150_TransceiverBPSK_Decimation is
        port (
            in_1_I_in : in std_logic_vector(11 downto 0);  -- Fixed Point
            in_2_Q_in : in std_logic_vector(11 downto 0);  -- Fixed Point
            in_3_SampleIndex : in std_logic_vector(2 downto 0);  -- Fixed Point
            in_4_dv : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_5_dc : in std_logic_vector(7 downto 0);  -- Fixed Point
            out_1_I_out : out std_logic_vector(11 downto 0);  -- Fixed Point
            out_2_Q_out : out std_logic_vector(11 downto 0);  -- Fixed Point
            out_3_qv : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_4_qc : out std_logic_vector(7 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_InterpolatingFIR is
        port (
            xIn_0 : in std_logic_vector(11 downto 0);  -- Fixed Point
            xIn_v : in std_logic_vector(0 downto 0);  -- Fixed Point
            xIn_c : in std_logic_vector(7 downto 0);  -- Fixed Point
            xOut_0 : out std_logic_vector(26 downto 0);  -- Fixed Point
            xOut_v : out std_logic_vector(0 downto 0);  -- Fixed Point
            xOut_c : out std_logic_vector(7 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_Modulator is
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


    component MCC150_TransceiverBPSK_PRBSGenerator is
        port (
            out_1_qv : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_qc : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_3_PRBS : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_Scale is
        port (
            xIn_0 : in std_logic_vector(26 downto 0);  -- Fixed Point
            xIn_v : in std_logic_vector(0 downto 0);  -- Fixed Point
            xIn_c : in std_logic_vector(7 downto 0);  -- Fixed Point
            qOut_0 : out std_logic_vector(11 downto 0);  -- Fixed Point
            qOut_v : out std_logic_vector(0 downto 0);  -- Fixed Point
            qOut_c : out std_logic_vector(7 downto 0);  -- Fixed Point
            eOut_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_Scale1 is
        port (
            xIn_0 : in std_logic_vector(29 downto 0);  -- Fixed Point
            xIn_v : in std_logic_vector(0 downto 0);  -- Fixed Point
            xIn_c : in std_logic_vector(7 downto 0);  -- Fixed Point
            qOut_0 : out std_logic_vector(11 downto 0);  -- Fixed Point
            qOut_v : out std_logic_vector(0 downto 0);  -- Fixed Point
            qOut_c : out std_logic_vector(7 downto 0);  -- Fixed Point
            eOut_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_Scale2 is
        port (
            xIn_0 : in std_logic_vector(29 downto 0);  -- Fixed Point
            xIn_v : in std_logic_vector(0 downto 0);  -- Fixed Point
            xIn_c : in std_logic_vector(7 downto 0);  -- Fixed Point
            qOut_0 : out std_logic_vector(11 downto 0);  -- Fixed Point
            qOut_v : out std_logic_vector(0 downto 0);  -- Fixed Point
            qOut_c : out std_logic_vector(7 downto 0);  -- Fixed Point
            eOut_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_SingleRateFIR is
        port (
            xIn_0 : in std_logic_vector(11 downto 0);  -- Fixed Point
            xIn_v : in std_logic_vector(0 downto 0);  -- Fixed Point
            xIn_c : in std_logic_vector(7 downto 0);  -- Fixed Point
            xOut_0 : out std_logic_vector(29 downto 0);  -- Fixed Point
            xOut_v : out std_logic_vector(0 downto 0);  -- Fixed Point
            xOut_c : out std_logic_vector(7 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    component MCC150_TransceiverBPSK_SingleRateFIR1 is
        port (
            xIn_0 : in std_logic_vector(11 downto 0);  -- Fixed Point
            xIn_v : in std_logic_vector(0 downto 0);  -- Fixed Point
            xIn_c : in std_logic_vector(7 downto 0);  -- Fixed Point
            xOut_0 : out std_logic_vector(29 downto 0);  -- Fixed Point
            xOut_v : out std_logic_vector(0 downto 0);  -- Fixed Point
            xOut_c : out std_logic_vector(7 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset_n : in std_logic
        );
    end component;


    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Const3_q : STD_LOGIC_VECTOR (7 downto 0);
    signal Decimation_out_1_I_out : STD_LOGIC_VECTOR (11 downto 0);
    signal Decimation_out_2_Q_out : STD_LOGIC_VECTOR (11 downto 0);
    signal InterpolatingFIR_xOut_0 : STD_LOGIC_VECTOR (26 downto 0);
    signal InterpolatingFIR_xOut_v : STD_LOGIC_VECTOR (0 downto 0);
    signal InterpolatingFIR_xOut_c : STD_LOGIC_VECTOR (7 downto 0);
    signal Modulator_out_1_qv : STD_LOGIC_VECTOR (0 downto 0);
    signal Modulator_out_2_qc : STD_LOGIC_VECTOR (7 downto 0);
    signal Modulator_out_3_I : STD_LOGIC_VECTOR (11 downto 0);
    signal PRBSGenerator_out_1_qv : STD_LOGIC_VECTOR (0 downto 0);
    signal PRBSGenerator_out_2_qc : STD_LOGIC_VECTOR (7 downto 0);
    signal PRBSGenerator_out_3_PRBS : STD_LOGIC_VECTOR (0 downto 0);
    signal Scale_qOut_0 : STD_LOGIC_VECTOR (11 downto 0);
    signal Scale1_qOut_0 : STD_LOGIC_VECTOR (11 downto 0);
    signal Scale1_qOut_v : STD_LOGIC_VECTOR (0 downto 0);
    signal Scale1_qOut_c : STD_LOGIC_VECTOR (7 downto 0);
    signal Scale2_qOut_0 : STD_LOGIC_VECTOR (11 downto 0);
    signal SingleRateFIR_xOut_0 : STD_LOGIC_VECTOR (29 downto 0);
    signal SingleRateFIR_xOut_v : STD_LOGIC_VECTOR (0 downto 0);
    signal SingleRateFIR_xOut_c : STD_LOGIC_VECTOR (7 downto 0);
    signal SingleRateFIR1_xOut_0 : STD_LOGIC_VECTOR (29 downto 0);
    signal SingleRateFIR1_xOut_v : STD_LOGIC_VECTOR (0 downto 0);
    signal SingleRateFIR1_xOut_c : STD_LOGIC_VECTOR (7 downto 0);

begin


    -- PRBSGenerator(BLACKBOX,10)
    thePRBSGenerator : MCC150_TransceiverBPSK_PRBSGenerator
    PORT MAP (
        out_1_qv => PRBSGenerator_out_1_qv,
        out_2_qc => PRBSGenerator_out_2_qc,
        out_3_PRBS => PRBSGenerator_out_3_PRBS,
        clk => clk,
        areset_n => areset_n
    );

    -- Modulator(BLACKBOX,9)
    theModulator : MCC150_TransceiverBPSK_Modulator
    PORT MAP (
        in_1_dv_x => PRBSGenerator_out_1_qv,
        in_2_dc => PRBSGenerator_out_2_qc,
        in_3_Data => PRBSGenerator_out_3_PRBS,
        out_1_qv => Modulator_out_1_qv,
        out_2_qc => Modulator_out_2_qc,
        out_3_I => Modulator_out_3_I,
        clk => clk,
        areset_n => areset_n
    );

    -- InterpolatingFIR(BLACKBOX,8)
    theInterpolatingFIR : MCC150_TransceiverBPSK_InterpolatingFIR
    PORT MAP (
        xIn_0 => Modulator_out_3_I,
        xIn_v => Modulator_out_1_qv,
        xIn_c => Modulator_out_2_qc,
        xOut_0 => InterpolatingFIR_xOut_0,
        xOut_v => InterpolatingFIR_xOut_v,
        xOut_c => InterpolatingFIR_xOut_c,
        clk => clk,
        areset_n => areset_n
    );

    -- Scale(BLACKBOX,11)
    theScale : MCC150_TransceiverBPSK_Scale
    PORT MAP (
        xIn_0 => InterpolatingFIR_xOut_0,
        xIn_v => InterpolatingFIR_xOut_v,
        xIn_c => InterpolatingFIR_xOut_c,
        qOut_0 => Scale_qOut_0,
        clk => clk,
        areset_n => areset_n
    );

    -- I_out(GPOUT,19)
    I_out <= Scale_qOut_0;

    -- Const_rsrvd_fix(CONSTANT,2)
    Const_rsrvd_fix_q <= "000000000000";

    -- Q_out(GPOUT,20)
    Q_out <= Const_rsrvd_fix_q;

    -- Const3(CONSTANT,5)
    Const3_q <= "00000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- SingleRateFIR1(BLACKBOX,15)
    theSingleRateFIR1 : MCC150_TransceiverBPSK_SingleRateFIR1
    PORT MAP (
        xIn_0 => Q_in,
        xIn_v => VCC_q,
        xIn_c => Const3_q,
        xOut_0 => SingleRateFIR1_xOut_0,
        xOut_v => SingleRateFIR1_xOut_v,
        xOut_c => SingleRateFIR1_xOut_c,
        clk => clk,
        areset_n => areset_n
    );

    -- Scale2(BLACKBOX,13)
    theScale2 : MCC150_TransceiverBPSK_Scale2
    PORT MAP (
        xIn_0 => SingleRateFIR1_xOut_0,
        xIn_v => SingleRateFIR1_xOut_v,
        xIn_c => SingleRateFIR1_xOut_c,
        qOut_0 => Scale2_qOut_0,
        clk => clk,
        areset_n => areset_n
    );

    -- SingleRateFIR(BLACKBOX,14)
    theSingleRateFIR : MCC150_TransceiverBPSK_SingleRateFIR
    PORT MAP (
        xIn_0 => I_in_x,
        xIn_v => VCC_q,
        xIn_c => Const3_q,
        xOut_0 => SingleRateFIR_xOut_0,
        xOut_v => SingleRateFIR_xOut_v,
        xOut_c => SingleRateFIR_xOut_c,
        clk => clk,
        areset_n => areset_n
    );

    -- Scale1(BLACKBOX,12)
    theScale1 : MCC150_TransceiverBPSK_Scale1
    PORT MAP (
        xIn_0 => SingleRateFIR_xOut_0,
        xIn_v => SingleRateFIR_xOut_v,
        xIn_c => SingleRateFIR_xOut_c,
        qOut_0 => Scale1_qOut_0,
        qOut_v => Scale1_qOut_v,
        qOut_c => Scale1_qOut_c,
        clk => clk,
        areset_n => areset_n
    );

    -- Decimation(BLACKBOX,7)
    theDecimation : MCC150_TransceiverBPSK_Decimation
    PORT MAP (
        in_1_I_in => Scale1_qOut_0,
        in_2_Q_in => Scale2_qOut_0,
        in_3_SampleIndex => SampleIndex,
        in_4_dv => Scale1_qOut_v,
        in_5_dc => Scale1_qOut_c,
        out_1_I_out => Decimation_out_1_I_out,
        out_2_Q_out => Decimation_out_2_Q_out,
        clk => clk,
        areset_n => areset_n
    );

    -- Symb_I_x(GPOUT,21)
    Symb_I_x <= Decimation_out_1_I_out;

    -- Symb_Q(GPOUT,22)
    Symb_Q <= Decimation_out_2_Q_out;

END normal;
