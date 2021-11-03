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
entity MCC150_TransceiverBPSK_AverageMagnitude1 is
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
end MCC150_TransceiverBPSK_AverageMagnitude1;

architecture normal of MCC150_TransceiverBPSK_AverageMagnitude1 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Add_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q : STD_LOGIC_VECTOR (11 downto 0);
    signal MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q : STD_LOGIC_VECTOR (17 downto 0);
    signal Add_a : STD_LOGIC_VECTOR (19 downto 0);
    signal Add_b : STD_LOGIC_VECTOR (19 downto 0);
    signal Add_o : STD_LOGIC_VECTOR (19 downto 0);
    signal Add_q : STD_LOGIC_VECTOR (18 downto 0);
    signal And_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal Select_rsrvd_fix_q : STD_LOGIC_VECTOR (17 downto 0);
    signal Sequence_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Sequence_rsrvd_fix_eq : std_logic;
    signal Shift_fs_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Shift_fs_qint : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_ChannelIn_in_2_dv_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_ChannelIn_in_2_dv_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_ChannelIn_in_3_dc_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_ChannelIn_in_1_Mag_2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_And_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q_1_q : STD_LOGIC_VECTOR (17 downto 0);

begin


    -- Const_rsrvd_fix(CONSTANT,15)
    Const_rsrvd_fix_q <= "00000000";

    -- Select_rsrvd_fix(SELECTOR,17)@1 + 1
    Select_rsrvd_fix_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Select_rsrvd_fix_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            Select_rsrvd_fix_q <= STD_LOGIC_VECTOR(MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q);
            IF (And_rsrvd_fix_q = "1") THEN
                Select_rsrvd_fix_q <= STD_LOGIC_VECTOR("0000000000" & Const_rsrvd_fix_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist3_ChannelIn_in_1_Mag_2(DELAY,27)
    redist3_ChannelIn_in_1_Mag_2 : dspba_delay
    GENERIC MAP ( width => 12, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_1_Mag, xout => redist3_ChannelIn_in_1_Mag_2_q, clk => clk, aclr => areset_n );

    -- Add(ADD,10)@2
    Add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & redist3_ChannelIn_in_1_Mag_2_q));
    Add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => Select_rsrvd_fix_q(17)) & Select_rsrvd_fix_q));
    Add_o <= STD_LOGIC_VECTOR(SIGNED(Add_a) + SIGNED(Add_b));
    Add_q <= Add_o(18 downto 0);

    -- Add_PostCast_primWireOut_sel_x(BITSELECT,3)@2
    Add_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(Add_q(17 downto 0));

    -- redist5_MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q_1(DELAY,29)
    redist5_MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q_1 : dspba_delay
    GENERIC MAP ( width => 18, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q, xout => redist5_MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q_1_q, clk => clk, aclr => areset_n );

    -- redist0_ChannelIn_in_2_dv_1(DELAY,24)
    redist0_ChannelIn_in_2_dv_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_2_dv, xout => redist0_ChannelIn_in_2_dv_1_q, clk => clk, aclr => areset_n );

    -- redist1_ChannelIn_in_2_dv_2(DELAY,25)
    redist1_ChannelIn_in_2_dv_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist0_ChannelIn_in_2_dv_1_q, xout => redist1_ChannelIn_in_2_dv_2_q, clk => clk, aclr => areset_n );

    -- MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x(MUX,6)@2
    MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_s <= redist1_ChannelIn_in_2_dv_2_q;
    MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_combproc: PROCESS (MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_s, redist5_MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q_1_q, Add_PostCast_primWireOut_sel_x_b)
    BEGIN
        CASE (MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_s) IS
            WHEN "0" => MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q <= redist5_MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q_1_q;
            WHEN "1" => MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q <= Add_PostCast_primWireOut_sel_x_b;
            WHEN OTHERS => MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Shift_fs(BITSHIFT,23)@1
    Shift_fs_qint <= MCC150_TransceiverBPSK_AverageMagnitude1_latch_1L_Mux_x_q;
    Shift_fs_q <= Shift_fs_qint(17 downto 6);

    -- Sequence_rsrvd_fix(SEQUENCE,19)@0 + 1
    Sequence_rsrvd_fix_clkproc: PROCESS (clk, areset_n)
        variable Sequence_rsrvd_fix_c : SIGNED(8 downto 0);
    BEGIN
        IF (areset_n = '0') THEN
            Sequence_rsrvd_fix_c := "000111110";
            Sequence_rsrvd_fix_q <= "0";
            Sequence_rsrvd_fix_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (in_2_dv = "1") THEN
                IF (Sequence_rsrvd_fix_c = "000000000") THEN
                    Sequence_rsrvd_fix_eq <= '1';
                ELSE
                    Sequence_rsrvd_fix_eq <= '0';
                END IF;
                IF (Sequence_rsrvd_fix_eq = '1') THEN
                    Sequence_rsrvd_fix_c := Sequence_rsrvd_fix_c + 63;
                ELSE
                    Sequence_rsrvd_fix_c := Sequence_rsrvd_fix_c - 1;
                END IF;
                Sequence_rsrvd_fix_q <= STD_LOGIC_VECTOR(Sequence_rsrvd_fix_c(8 downto 8));
            END IF;
        END IF;
    END PROCESS;

    -- And_rsrvd_fix(LOGICAL,12)@1
    And_rsrvd_fix_q <= redist0_ChannelIn_in_2_dv_1_q and Sequence_rsrvd_fix_q;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x(MUX,4)@1 + 1
    MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_s <= And_rsrvd_fix_q;
    MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_s) IS
                WHEN "0" => MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q <= MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q;
                WHEN "1" => MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q <= Shift_fs_q;
                WHEN OTHERS => MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist2_ChannelIn_in_3_dc_2(DELAY,26)
    redist2_ChannelIn_in_3_dc_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_3_dc, xout => redist2_ChannelIn_in_3_dc_2_q, clk => clk, aclr => areset_n );

    -- redist4_And_rsrvd_fix_q_1(DELAY,28)
    redist4_And_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => And_rsrvd_fix_q, xout => redist4_And_rsrvd_fix_q_1_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,14)@2 + 1
    out_2_qv <= redist4_And_rsrvd_fix_q_1_q;
    out_3_qc <= redist2_ChannelIn_in_3_dc_2_q;
    out_1_AvgMag <= MCC150_TransceiverBPSK_AverageMagnitude1_latch_0L_Mux_x_q;

END normal;
