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

-- VHDL created from MCC150_TransmitterBPSK_Modulator
-- VHDL created on Sat Apr 17 17:41:34 2021


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

USE work.MCC150_TransmitterBPSK_safe_path.all;
entity MCC150_TransmitterBPSK_Modulator is
    port (
        in_1_dv_x : in std_logic_vector(0 downto 0);  -- ufix1
        in_2_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_3_Data : in std_logic_vector(0 downto 0);  -- ufix1
        out_1_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_I : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset : in std_logic
    );
end MCC150_TransmitterBPSK_Modulator;

architecture normal of MCC150_TransmitterBPSK_Modulator is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Const1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Select_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist0_ChannelIn_in_1_dv_x_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_ChannelIn_in_2_dc_1_q : STD_LOGIC_VECTOR (7 downto 0);

begin


    -- Const_rsrvd_fix(CONSTANT,4)
    Const_rsrvd_fix_q <= "011111111111";

    -- Const1(CONSTANT,5)
    Const1_q <= "100000000001";

    -- Select_rsrvd_fix(SELECTOR,6)@0 + 1
    Select_rsrvd_fix_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '0') THEN
            Select_rsrvd_fix_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            Select_rsrvd_fix_q <= STD_LOGIC_VECTOR(Const_rsrvd_fix_q);
            IF (in_3_Data = "1") THEN
                Select_rsrvd_fix_q <= STD_LOGIC_VECTOR(Const1_q);
            END IF;
        END IF;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist1_ChannelIn_in_2_dc_1(DELAY,8)
    redist1_ChannelIn_in_2_dc_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_2_dc, xout => redist1_ChannelIn_in_2_dc_1_q, clk => clk, aclr => areset );

    -- redist0_ChannelIn_in_1_dv_x_1(DELAY,7)
    redist0_ChannelIn_in_1_dv_x_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_1_dv_x, xout => redist0_ChannelIn_in_1_dv_x_1_q, clk => clk, aclr => areset );

    -- ChannelOut(PORTOUT,3)@1 + 1
    out_1_qv <= redist0_ChannelIn_in_1_dv_x_1_q;
    out_2_qc <= redist1_ChannelIn_in_2_dc_1_q;
    out_3_I <= Select_rsrvd_fix_q;

END normal;
