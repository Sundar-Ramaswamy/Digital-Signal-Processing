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
-- VHDL created on Wed May 26 13:29:51 2021


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
entity MCC150_TransceiverBPSK_Demodulator is
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
end MCC150_TransceiverBPSK_Demodulator;

architecture normal of MCC150_TransceiverBPSK_Demodulator is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Select_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpLT_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_ChannelIn_in_3_dv_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_ChannelIn_in_4_dc_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_ChannelIn_in_2_Q_in_1_q : STD_LOGIC_VECTOR (13 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist2_ChannelIn_in_2_Q_in_1(DELAY,16)
    redist2_ChannelIn_in_2_Q_in_1 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_2_Q_in, xout => redist2_ChannelIn_in_2_Q_in_1_q, clk => clk, aclr => areset_n );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- CmpLT_cmp_sign(LOGICAL,11)@0
    CmpLT_cmp_sign_q <= STD_LOGIC_VECTOR(in_1_I_in(13 downto 13));

    -- Select_rsrvd_fix(SELECTOR,10)@0 + 1
    Select_rsrvd_fix_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Select_rsrvd_fix_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            Select_rsrvd_fix_q <= GND_q;
            IF (CmpLT_cmp_sign_q = "1") THEN
                Select_rsrvd_fix_q <= VCC_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist1_ChannelIn_in_4_dc_1(DELAY,15)
    redist1_ChannelIn_in_4_dc_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_4_dc, xout => redist1_ChannelIn_in_4_dc_1_q, clk => clk, aclr => areset_n );

    -- redist0_ChannelIn_in_3_dv_1(DELAY,14)
    redist0_ChannelIn_in_3_dv_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_3_dv, xout => redist0_ChannelIn_in_3_dv_1_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,4)@1 + 1
    out_3_Qv <= redist0_ChannelIn_in_3_dv_1_q;
    out_4_Qc <= redist1_ChannelIn_in_4_dc_1_q;
    out_1_I_Out <= Select_rsrvd_fix_q;
    out_2_Q_Out <= redist2_ChannelIn_in_2_Q_in_1_q;

END normal;
