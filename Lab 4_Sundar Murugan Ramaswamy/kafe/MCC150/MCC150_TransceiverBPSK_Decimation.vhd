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
        out_5_I_adj : out std_logic_vector(11 downto 0);  -- sfix12
        out_6_Q_adj : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_Decimation;

architecture normal of MCC150_TransceiverBPSK_Decimation is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Add_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Add_x_a : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Add_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Add_x_o : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Add_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_a : STD_LOGIC_VECTOR (4 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_b : STD_LOGIC_VECTOR (4 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_o : STD_LOGIC_VECTOR (4 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Const2_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Increment_Select_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_q : STD_LOGIC_VECTOR (11 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_q : STD_LOGIC_VECTOR (11 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_q : STD_LOGIC_VECTOR (11 downto 0);
    signal MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CmpEQ_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Counter_q : STD_LOGIC_VECTOR (2 downto 0);
    signal Counter_i : UNSIGNED (2 downto 0);
    attribute preserve : boolean;
    attribute preserve of Counter_i : signal is true;
    signal redist0_Counter_q_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist1_CmpEQ_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_ChannelIn_in_5_dc_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_ChannelIn_in_1_I_in_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_ChannelIn_in_2_Q_in_1_q : STD_LOGIC_VECTOR (11 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist4_ChannelIn_in_2_Q_in_1(DELAY,46)
    redist4_ChannelIn_in_2_Q_in_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_2_Q_in, xout => redist4_ChannelIn_in_2_Q_in_1_q, clk => clk, aclr => areset_n );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- MCC150_TransceiverBPSK_Decimation_Increment_Add_x(ADD,9)@0
    MCC150_TransceiverBPSK_Decimation_Increment_Add_x_a <= STD_LOGIC_VECTOR("0" & in_3_SampleIndex);
    MCC150_TransceiverBPSK_Decimation_Increment_Add_x_b <= STD_LOGIC_VECTOR("000" & VCC_q);
    MCC150_TransceiverBPSK_Decimation_Increment_Add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_Decimation_Increment_Add_x_a) + UNSIGNED(MCC150_TransceiverBPSK_Decimation_Increment_Add_x_b));
    MCC150_TransceiverBPSK_Decimation_Increment_Add_x_q <= MCC150_TransceiverBPSK_Decimation_Increment_Add_x_o(3 downto 0);

    -- MCC150_TransceiverBPSK_Decimation_Increment_Add_PostCast_primWireOut_sel_x(BITSELECT,2)@0
    MCC150_TransceiverBPSK_Decimation_Increment_Add_PostCast_primWireOut_sel_x_b <= MCC150_TransceiverBPSK_Decimation_Increment_Add_x_q(2 downto 0);

    -- MCC150_TransceiverBPSK_Decimation_Increment_Const2_x(CONSTANT,14)
    MCC150_TransceiverBPSK_Decimation_Increment_Const2_x_q <= "111";

    -- MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x(COMPARE,11)@0
    MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_a <= STD_LOGIC_VECTOR("00" & in_3_SampleIndex);
    MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_b <= STD_LOGIC_VECTOR("00" & MCC150_TransceiverBPSK_Decimation_Increment_Const2_x_q);
    MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_a) - UNSIGNED(MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_b));
    MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_c(0) <= MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_o(4);

    -- MCC150_TransceiverBPSK_Decimation_Increment_Select_x(SELECTOR,15)@0 + 1
    MCC150_TransceiverBPSK_Decimation_Increment_Select_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_Decimation_Increment_Select_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_Decimation_Increment_Select_x_q <= STD_LOGIC_VECTOR("00" & GND_q);
            IF (MCC150_TransceiverBPSK_Decimation_Increment_CmpLT_x_c = "1") THEN
                MCC150_TransceiverBPSK_Decimation_Increment_Select_x_q <= MCC150_TransceiverBPSK_Decimation_Increment_Add_PostCast_primWireOut_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- Counter(COUNTER,34)@0 + 1
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

    -- redist0_Counter_q_1(DELAY,42)
    redist0_Counter_q_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => Counter_q, xout => redist0_Counter_q_1_q, clk => clk, aclr => areset_n );

    -- CmpEQ1(LOGICAL,33)@1
    CmpEQ1_q <= "1" WHEN redist0_Counter_q_1_q = MCC150_TransceiverBPSK_Decimation_Increment_Select_x_q ELSE "0";

    -- MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x(SELECTOR,23)@1 + 1
    MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_q <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_q);
            IF (CmpEQ1_q = "1") THEN
                MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_q <= STD_LOGIC_VECTOR(redist4_ChannelIn_in_2_Q_in_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist3_ChannelIn_in_1_I_in_1(DELAY,45)
    redist3_ChannelIn_in_1_I_in_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_1_I_in, xout => redist3_ChannelIn_in_1_I_in_1_q, clk => clk, aclr => areset_n );

    -- MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x(SELECTOR,22)@1 + 1
    MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_q <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_q);
            IF (CmpEQ1_q = "1") THEN
                MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_q <= STD_LOGIC_VECTOR(redist3_ChannelIn_in_1_I_in_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- CmpEQ(LOGICAL,32)@0 + 1
    CmpEQ_qi <= "1" WHEN Counter_q = in_3_SampleIndex ELSE "0";
    CmpEQ_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => CmpEQ_qi, xout => CmpEQ_q, clk => clk, aclr => areset_n );

    -- MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x(SELECTOR,19)@1 + 1
    MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_q <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_q);
            IF (CmpEQ_q = "1") THEN
                MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_q <= STD_LOGIC_VECTOR(redist4_ChannelIn_in_2_Q_in_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x(SELECTOR,18)@1 + 1
    MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_q <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_q);
            IF (CmpEQ_q = "1") THEN
                MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_q <= STD_LOGIC_VECTOR(redist3_ChannelIn_in_1_I_in_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_ChannelIn_in_5_dc_2(DELAY,44)
    redist2_ChannelIn_in_5_dc_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_5_dc, xout => redist2_ChannelIn_in_5_dc_2_q, clk => clk, aclr => areset_n );

    -- redist1_CmpEQ_q_2(DELAY,43)
    redist1_CmpEQ_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => CmpEQ_q, xout => redist1_CmpEQ_q_2_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,31)@2 + 1
    out_3_qv <= redist1_CmpEQ_q_2_q;
    out_4_qc <= redist2_ChannelIn_in_5_dc_2_q;
    out_1_I_out <= MCC150_TransceiverBPSK_Decimation_Subsystem1_Select_x_q;
    out_2_Q_out <= MCC150_TransceiverBPSK_Decimation_Subsystem1_Select1_x_q;
    out_5_I_adj <= MCC150_TransceiverBPSK_Decimation_Subsystem3_Select_x_q;
    out_6_Q_adj <= MCC150_TransceiverBPSK_Decimation_Subsystem3_Select1_x_q;

END normal;
