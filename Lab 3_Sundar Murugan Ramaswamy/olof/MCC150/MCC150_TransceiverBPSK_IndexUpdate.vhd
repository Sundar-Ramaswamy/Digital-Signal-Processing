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

-- VHDL created from MCC150_TransceiverBPSK_IndexUpdate
-- VHDL created on Sat May 15 13:20:13 2021


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
entity MCC150_TransceiverBPSK_IndexUpdate is
    port (
        in_3_dv : in std_logic_vector(0 downto 0);  -- ufix1
        in_4_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_AvgMag_out : in std_logic_vector(11 downto 0);  -- ufix12
        in_2_AvgMag_adj : in std_logic_vector(11 downto 0);  -- ufix12
        out_2_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_3_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_1_SampleIndex : out std_logic_vector(2 downto 0);  -- ufix3
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_IndexUpdate;

architecture normal of MCC150_TransceiverBPSK_IndexUpdate is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_a : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_o : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Const1_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_a : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_o : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_a : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_o : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_a : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_o : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_a : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_o : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_a : STD_LOGIC_VECTOR (4 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_b : STD_LOGIC_VECTOR (4 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_o : STD_LOGIC_VECTOR (4 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal CmpLT_a : STD_LOGIC_VECTOR (13 downto 0);
    signal CmpLT_b : STD_LOGIC_VECTOR (13 downto 0);
    signal CmpLT_o : STD_LOGIC_VECTOR (13 downto 0);
    signal CmpLT_c : STD_LOGIC_VECTOR (0 downto 0);
    signal Mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal Mux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist0_SampleDelay_q_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist1_CmpLT_c_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_ChannelIn_in_3_dv_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_ChannelIn_in_4_dc_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q : STD_LOGIC_VECTOR (2 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x(ADD,28)@0
    MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_a <= STD_LOGIC_VECTOR("0" & redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q);
    MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_b <= STD_LOGIC_VECTOR("000" & VCC_q);
    MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_a) + UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_b));
    MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_o(3 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_PostCast_primWireOut_sel_x(BITSELECT,8)@0
    MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_PostCast_primWireOut_sel_x_b <= MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_x_q(2 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_Const1_x(CONSTANT,16)
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Const1_x_q <= "111";

    -- MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x(COMPARE,30)@0
    MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_a <= STD_LOGIC_VECTOR("00" & redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q);
    MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_b <= STD_LOGIC_VECTOR("00" & MCC150_TransceiverBPSK_IndexUpdate_Decrement_Const1_x_q);
    MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_a) - UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_b));
    MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_c(0) <= MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_o(4);

    -- MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x(SELECTOR,34)@0 + 1
    MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q <= STD_LOGIC_VECTOR("00" & GND_q);
            IF (MCC150_TransceiverBPSK_IndexUpdate_Increment_CmpLT_x_c = "1") THEN
                MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Increment_Add_PostCast_primWireOut_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x(SUB,27)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_a <= STD_LOGIC_VECTOR("0" & MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_b <= STD_LOGIC_VECTOR("000" & VCC_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_a) - UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_b));
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_o(3 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_PostCast_primWireOut_sel_x(BITSELECT,7)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_x_q(2 downto 0));

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x(ADD,20)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_a <= STD_LOGIC_VECTOR("0" & MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_b <= STD_LOGIC_VECTOR("0" & MCC150_TransceiverBPSK_IndexUpdate_Decrement_Const1_x_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_a) + UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_b));
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_o(3 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_PostCast_primWireOut_sel_x(BITSELECT,5)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_PostCast_primWireOut_sel_x_b <= MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_x_q(2 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x(LOGICAL,22)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x_b <= STD_LOGIC_VECTOR("00" & GND_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x_q <= "1" WHEN MCC150_TransceiverBPSK_IndexUpdate_Increment_Select_x_q = MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x_b ELSE "0";

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x(SELECTOR,26)@1 + 1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Sub_PostCast_primWireOut_sel_x_b;
            IF (MCC150_TransceiverBPSK_IndexUpdate_Decrement1_CmpEQ_x_q = "1") THEN
                MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Add_PostCast_primWireOut_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- redist0_SampleDelay_q_1(DELAY,56)
    redist0_SampleDelay_q_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q, xout => redist0_SampleDelay_q_1_q, clk => clk, aclr => areset_n );

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x(SUB,19)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_a <= STD_LOGIC_VECTOR("0" & redist0_SampleDelay_q_1_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_b <= STD_LOGIC_VECTOR("000" & VCC_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_a) - UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_b));
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_o(3 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_PostCast_primWireOut_sel_x(BITSELECT,4)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_x_q(2 downto 0));

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x(ADD,12)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_a <= STD_LOGIC_VECTOR("0" & redist0_SampleDelay_q_1_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_b <= STD_LOGIC_VECTOR("0" & MCC150_TransceiverBPSK_IndexUpdate_Decrement_Const1_x_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_a) + UNSIGNED(MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_b));
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_o(3 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_PostCast_primWireOut_sel_x(BITSELECT,2)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_PostCast_primWireOut_sel_x_b <= MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_x_q(2 downto 0);

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x(LOGICAL,14)@1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x_b <= STD_LOGIC_VECTOR("00" & GND_q);
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x_q <= "1" WHEN redist0_SampleDelay_q_1_q = MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x_b ELSE "0";

    -- MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x(SELECTOR,18)@1 + 1
    MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement_Sub_PostCast_primWireOut_sel_x_b;
            IF (MCC150_TransceiverBPSK_IndexUpdate_Decrement_CmpEQ_x_q = "1") THEN
                MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement_Add_PostCast_primWireOut_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- CmpLT(COMPARE,45)@0 + 1
    CmpLT_a <= STD_LOGIC_VECTOR("00" & in_1_AvgMag_out);
    CmpLT_b <= STD_LOGIC_VECTOR("00" & in_2_AvgMag_adj);
    CmpLT_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            CmpLT_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CmpLT_o <= STD_LOGIC_VECTOR(UNSIGNED(CmpLT_a) - UNSIGNED(CmpLT_b));
        END IF;
    END PROCESS;
    CmpLT_c(0) <= CmpLT_o(13);

    -- redist1_CmpLT_c_2(DELAY,57)
    redist1_CmpLT_c_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => CmpLT_c, xout => redist1_CmpLT_c_2_q, clk => clk, aclr => areset_n );

    -- Mux(MUX,47)@2
    Mux_s <= redist1_CmpLT_c_2_q;
    Mux_combproc: PROCESS (Mux_s, MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_q, MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_q)
    BEGIN
        CASE (Mux_s) IS
            WHEN "0" => Mux_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement_Select_x_q;
            WHEN "1" => Mux_q <= MCC150_TransceiverBPSK_IndexUpdate_Decrement1_Select_x_q;
            WHEN OTHERS => Mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1(DELAY,60)
    redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q, xout => redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q, clk => clk, aclr => areset_n );

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x(MUX,35)@2
    MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_s <= redist2_ChannelIn_in_3_dv_2_q;
    MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_combproc: PROCESS (MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_s, redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q, Mux_q)
    BEGIN
        CASE (MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_s) IS
            WHEN "0" => MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q <= redist4_MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q_1_q;
            WHEN "1" => MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q <= Mux_q;
            WHEN OTHERS => MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist3_ChannelIn_in_4_dc_2(DELAY,59)
    redist3_ChannelIn_in_4_dc_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_4_dc, xout => redist3_ChannelIn_in_4_dc_2_q, clk => clk, aclr => areset_n );

    -- redist2_ChannelIn_in_3_dv_2(DELAY,58)
    redist2_ChannelIn_in_3_dv_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_3_dv, xout => redist2_ChannelIn_in_3_dv_2_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,44)@2 + 1
    out_2_qv <= redist2_ChannelIn_in_3_dv_2_q;
    out_3_qc <= redist3_ChannelIn_in_4_dc_2_q;
    out_1_SampleIndex <= MCC150_TransceiverBPSK_IndexUpdate_latch_0L_Mux_x_q;

END normal;
