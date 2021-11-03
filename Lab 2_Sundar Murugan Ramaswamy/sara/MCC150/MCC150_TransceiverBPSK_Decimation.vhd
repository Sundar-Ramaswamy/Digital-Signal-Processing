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

-- VHDL created from MCC150_TransceiverBPSK_Decimation
-- VHDL created on Fri May 07 21:18:35 2021


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
entity MCC150_TransceiverBPSK_Decimation is
    port (
        in_4_dv : in std_logic_vector(0 downto 0);  -- ufix1
        in_5_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_I_in : in std_logic_vector(11 downto 0);  -- sfix12
        in_2_Q_in : in std_logic_vector(11 downto 0);  -- sfix12
        in_3_SampleIndex : in std_logic_vector(2 downto 0);  -- ufix3
        out_3_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_4_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_1_I_out : out std_logic_vector(11 downto 0);  -- sfix12
        out_2_Q_out : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_Decimation;

architecture normal of MCC150_TransceiverBPSK_Decimation is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal Counter_q : STD_LOGIC_VECTOR (2 downto 0);
    signal Counter_i : UNSIGNED (2 downto 0);
    attribute preserve : boolean;
    attribute preserve of Counter_i : signal is true;
    signal Select_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Select1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist0_CmpEQ_q_1_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- Counter(COUNTER,8)@0 + 1
    -- low=0, high=7, step=1, init=0
    Counter_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Counter_i <= TO_UNSIGNED(0, 3);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (in_4_dv = "1") THEN
                Counter_i <= Counter_i + 1;
            END IF;
        END IF;
    END PROCESS;
    Counter_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(Counter_i, 3)));

    -- CmpEQ(LOGICAL,6)@0
    CmpEQ_q <= "1" WHEN Counter_q = in_3_SampleIndex ELSE "0";

    -- Select1(SELECTOR,13)@0 + 1
    Select1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Select1_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            Select1_q <= STD_LOGIC_VECTOR(Select1_q);
            IF (CmpEQ_q = "1") THEN
                Select1_q <= STD_LOGIC_VECTOR(in_2_Q_in);
            END IF;
        END IF;
    END PROCESS;

    -- Select_rsrvd_fix(SELECTOR,12)@0 + 1
    Select_rsrvd_fix_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Select_rsrvd_fix_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            Select_rsrvd_fix_q <= STD_LOGIC_VECTOR(Select_rsrvd_fix_q);
            IF (CmpEQ_q = "1") THEN
                Select_rsrvd_fix_q <= STD_LOGIC_VECTOR(in_1_I_in);
            END IF;
        END IF;
    END PROCESS;

    -- Const_rsrvd_fix(CONSTANT,7)
    Const_rsrvd_fix_q <= "00000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist0_CmpEQ_q_1(DELAY,18)
    redist0_CmpEQ_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => CmpEQ_q, xout => redist0_CmpEQ_q_1_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,5)@1 + 1
    out_3_qv <= redist0_CmpEQ_q_1_q;
    out_4_qc <= Const_rsrvd_fix_q;
    out_1_I_out <= Select_rsrvd_fix_q;
    out_2_Q_out <= Select1_q;

END normal;
