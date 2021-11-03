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

-- VHDL created from MCC150_TransceiverBPSK_InterpolatingFIR
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
entity MCC150_TransceiverBPSK_InterpolatingFIR is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(11 downto 0);  -- sfix12
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(26 downto 0);  -- sfix27
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_InterpolatingFIR;

architecture normal of MCC150_TransceiverBPSK_InterpolatingFIR is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_q : STD_LOGIC_VECTOR (11 downto 0);
    signal d_in0_m0_wi0_wo0_assign_id1_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_run_preEnaQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enableQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra4_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra9_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra9_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra10_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra11_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we4_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we9_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we9_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we9_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we9_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we9_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we10_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we11_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_i : UNSIGNED (0 downto 0);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_wi0_r0_wa0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_wa9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_wa9_i : UNSIGNED (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_wa9_i : signal is true;
    signal u0_m0_wo0_wi0_r0_wa4_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_wa10_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_wa11_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr0_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr4_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr4_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr4_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr4_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr4_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr4_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr9_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr9_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr9_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr9_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr9_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr9_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr10_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr10_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr10_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr10_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr10_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr10_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr11_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr11_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr11_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr11_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_memr11_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_memr11_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_ca5_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_ca5_i : UNSIGNED (2 downto 0);
    attribute preserve of u0_m0_wo0_ca5_i : signal is true;
    signal u0_m0_wo0_symSuppress_0_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_symSuppress_0_seq_eq : std_logic;
    signal u0_m0_wo0_symSuppress_1_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_symSuppress_1_seq_eq : std_logic;
    signal u0_m0_wo0_symSuppress_2_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_symSuppress_2_seq_eq : std_logic;
    signal u0_m0_wo0_cma0_reset : std_logic;
    type u0_m0_wo0_cma0_a0type is array(NATURAL range <>) of SIGNED(11 downto 0);
    signal u0_m0_wo0_cma0_a0 : u0_m0_wo0_cma0_a0type(0 to 5);
    attribute preserve of u0_m0_wo0_cma0_a0 : signal is true;
    attribute altera_attribute of u0_m0_wo0_cma0_a0 : signal is "-name allow_synch_ctrl_usage off";
    signal u0_m0_wo0_cma0_a1 : u0_m0_wo0_cma0_a0type(0 to 5);
    attribute preserve of u0_m0_wo0_cma0_a1 : signal is true;
    attribute altera_attribute of u0_m0_wo0_cma0_a1 : signal is "-name allow_synch_ctrl_usage off";
    signal u0_m0_wo0_cma0_b0 : u0_m0_wo0_cma0_a0type(0 to 5);
    attribute preserve of u0_m0_wo0_cma0_b0 : signal is true;
    attribute altera_attribute of u0_m0_wo0_cma0_b0 : signal is "-name allow_synch_ctrl_usage off";
    signal u0_m0_wo0_cma0_b1 : u0_m0_wo0_cma0_a0type(0 to 5);
    attribute preserve of u0_m0_wo0_cma0_b1 : signal is true;
    attribute altera_attribute of u0_m0_wo0_cma0_b1 : signal is "-name allow_synch_ctrl_usage off";
    type u0_m0_wo0_cma0_c0type is array(NATURAL range <>) of UNSIGNED(2 downto 0);
    signal u0_m0_wo0_cma0_c0 : u0_m0_wo0_cma0_c0type(0 to 5);
    attribute preserve of u0_m0_wo0_cma0_c0 : signal is true;
    attribute altera_attribute of u0_m0_wo0_cma0_c0 : signal is "-name allow_synch_ctrl_usage off";
    signal u0_m0_wo0_cma0_c1 : u0_m0_wo0_cma0_c0type(0 to 5);
    attribute preserve of u0_m0_wo0_cma0_c1 : signal is true;
    attribute altera_attribute of u0_m0_wo0_cma0_c1 : signal is "-name allow_synch_ctrl_usage off";
    type u0_m0_wo0_cma0_ltype is array(NATURAL range <>) of SIGNED(12 downto 0);
    signal u0_m0_wo0_cma0_l : u0_m0_wo0_cma0_ltype(0 to 5);
    signal u0_m0_wo0_cma0_r : u0_m0_wo0_cma0_a0type(0 to 5);
    type u0_m0_wo0_cma0_ptype is array(NATURAL range <>) of SIGNED(24 downto 0);
    signal u0_m0_wo0_cma0_p : u0_m0_wo0_cma0_ptype(0 to 5);
    type u0_m0_wo0_cma0_utype is array(NATURAL range <>) of SIGNED(27 downto 0);
    signal u0_m0_wo0_cma0_u : u0_m0_wo0_cma0_utype(0 to 5);
    signal u0_m0_wo0_cma0_w : u0_m0_wo0_cma0_utype(0 to 5);
    signal u0_m0_wo0_cma0_x : u0_m0_wo0_cma0_utype(0 to 5);
    signal u0_m0_wo0_cma0_y : u0_m0_wo0_cma0_utype(0 to 5);
    signal u0_m0_wo0_cma0_k0 : u0_m0_wo0_cma0_a0type(0 to 7) := (
        0 => TO_SIGNED(12,12),
        1 => TO_SIGNED(19,12),
        2 => TO_SIGNED(15,12),
        3 => TO_SIGNED(0,12),
        4 => TO_SIGNED(-18,12),
        5 => TO_SIGNED(-13,12),
        6 => TO_SIGNED(-10,12),
        7 => TO_SIGNED(0,12),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k1 : u0_m0_wo0_cma0_a0type(0 to 7) := (
        0 => TO_SIGNED(53,12),
        1 => TO_SIGNED(45,12),
        2 => TO_SIGNED(0,12),
        3 => TO_SIGNED(-68,12),
        4 => TO_SIGNED(-29,12),
        5 => TO_SIGNED(-24,12),
        6 => TO_SIGNED(0,12),
        7 => TO_SIGNED(32,12),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k2 : u0_m0_wo0_cma0_a0type(0 to 7) := (
        0 => TO_SIGNED(1043,12),
        1 => TO_SIGNED(1448,12),
        2 => TO_SIGNED(1738,12),
        3 => TO_SIGNED(-123,12),
        4 => TO_SIGNED(-116,12),
        5 => TO_SIGNED(0,12),
        6 => TO_SIGNED(248,12),
        7 => TO_SIGNED(615,12),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k3 : u0_m0_wo0_cma0_a0type(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-116,12),
        2 => TO_SIGNED(1844,12),
        3 => TO_SIGNED(1738,12),
        4 => TO_SIGNED(1448,12),
        5 => TO_SIGNED(1043,12),
        6 => TO_SIGNED(0,12),
        7 => TO_SIGNED(248,12),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k4 : u0_m0_wo0_cma0_a0type(0 to 7) := (
        0 => TO_SIGNED(-24,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(-68,12),
        3 => TO_SIGNED(0,12),
        4 => TO_SIGNED(45,12),
        5 => TO_SIGNED(0,12),
        6 => TO_SIGNED(32,12),
        7 => TO_SIGNED(0,12),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k5 : u0_m0_wo0_cma0_a0type(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-18,12),
        2 => TO_SIGNED(0,12),
        3 => TO_SIGNED(15,12),
        4 => TO_SIGNED(0,12),
        5 => TO_SIGNED(12,12),
        6 => TO_SIGNED(0,12),
        7 => TO_SIGNED(-10,12),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_s : u0_m0_wo0_cma0_utype(0 to 5);
    signal u0_m0_wo0_cma0_qq : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_cma0_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_cma0_ena0 : std_logic;
    signal u0_m0_wo0_cma0_ena1 : std_logic;
    signal u0_m0_wo0_cma0_ena2 : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr1_mem_ia : STD_LOGIC_VECTOR (47 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_iq : STD_LOGIC_VECTOR (47 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_q : STD_LOGIC_VECTOR (47 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr1_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr1_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q : signal is true;
    signal u0_m0_wo0_cma0_mux_0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cma0_mux_0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cma0_mux_1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cma0_mux_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_cma0_mux_2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cma0_mux_2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_we4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_we11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_1_lut_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_b : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_c : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_d : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_e : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_wi0_r0_join1_q : STD_LOGIC_VECTOR (47 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- u0_m0_wo0_run(ENABLEGENERATOR,13)@10 + 2
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enableQ;
    u0_m0_wo0_run_enableQ <= u0_m0_wo0_run_out;
    u0_m0_wo0_run_clkproc: PROCESS (clk, areset_n)
        variable u0_m0_wo0_run_enable_c : SIGNED(0 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(4 downto 0);
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(-1, 1);
            u0_m0_wo0_run_count <= "00000";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "00000";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "11000";
                WHEN "100" => u0_m0_wo0_run_inc := "00001";
                WHEN "101" => u0_m0_wo0_run_inc := "00001";
                WHEN "110" => u0_m0_wo0_run_inc := "11001";
                WHEN "111" => u0_m0_wo0_run_inc := "11001";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_preEnaQ <= u0_m0_wo0_run_count(4 downto 4);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_preEnaQ and VCC_q;

    -- u0_m0_wo0_memread(DELAY,14)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset_n );

    -- d_u0_m0_wo0_memread_q_13(DELAY,90)@12 + 1
    d_u0_m0_wo0_memread_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => d_u0_m0_wo0_memread_q_13_q, clk => clk, aclr => areset_n );

    -- u0_m0_wo0_wi0_r0_ra0_1_lut(LOOKUP,19)@13
    u0_m0_wo0_wi0_r0_ra0_1_lut_combproc: PROCESS (u0_m0_wo0_wi0_r0_ra4_1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (u0_m0_wo0_wi0_r0_ra4_1_q) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_ra0_1_lut_q <= "1";
            WHEN "1" => u0_m0_wo0_wi0_r0_ra0_1_lut_q <= "0";
            WHEN OTHERS => -- unreachable
                           u0_m0_wo0_wi0_r0_ra0_1_lut_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_1(REG,20)@13
    u0_m0_wo0_wi0_r0_ra0_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra0_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_1_q <= u0_m0_wo0_wi0_r0_ra0_1_lut_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_2(REG,21)@13
    u0_m0_wo0_wi0_r0_ra0_2_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra0_2_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_2_q <= u0_m0_wo0_wi0_r0_ra0_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_3(REG,22)@13
    u0_m0_wo0_wi0_r0_ra0_3_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra0_3_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_3_q <= u0_m0_wo0_wi0_r0_ra0_2_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra9_1(REG,24)@13
    u0_m0_wo0_wi0_r0_ra9_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra9_1_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra9_1_q <= u0_m0_wo0_wi0_r0_ra0_3_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra9_2(REG,25)@13
    u0_m0_wo0_wi0_r0_ra9_2_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra9_2_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra9_2_q <= u0_m0_wo0_wi0_r0_ra9_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra10_1(REG,26)@13
    u0_m0_wo0_wi0_r0_ra10_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra10_1_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra10_1_q <= u0_m0_wo0_wi0_r0_ra9_2_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra11_1(REG,27)@13
    u0_m0_wo0_wi0_r0_ra11_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra11_1_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra11_1_q <= u0_m0_wo0_wi0_r0_ra10_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra4_1(REG,23)@13
    u0_m0_wo0_wi0_r0_ra4_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_ra4_1_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra4_1_q <= u0_m0_wo0_wi0_r0_ra11_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we9_1(REG,30)@13
    u0_m0_wo0_wi0_r0_we9_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we9_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we9_1_q <= u0_m0_wo0_wi0_r0_we4_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we9_2(REG,31)@13
    u0_m0_wo0_wi0_r0_we9_2_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we9_2_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we9_2_q <= u0_m0_wo0_wi0_r0_we9_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we9_3(REG,32)@13
    u0_m0_wo0_wi0_r0_we9_3_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we9_3_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we9_3_q <= u0_m0_wo0_wi0_r0_we9_2_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we9_4(REG,33)@13
    u0_m0_wo0_wi0_r0_we9_4_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we9_4_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we9_4_q <= u0_m0_wo0_wi0_r0_we9_3_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we9_5(REG,34)@13
    u0_m0_wo0_wi0_r0_we9_5_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we9_5_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we9_5_q <= u0_m0_wo0_wi0_r0_we9_4_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we10_1(REG,36)@13
    u0_m0_wo0_wi0_r0_we10_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we10_1_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we10_1_q <= u0_m0_wo0_wi0_r0_we9_5_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we11_1(REG,38)@13
    u0_m0_wo0_wi0_r0_we11_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we11_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we11_1_q <= u0_m0_wo0_wi0_r0_we10_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we4_1(REG,28)@13
    u0_m0_wo0_wi0_r0_we4_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_we4_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_we4_1_q <= u0_m0_wo0_wi0_r0_we11_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_we4(LOGICAL,29)@13
    u0_m0_wo0_wi0_r0_we4_q <= u0_m0_wo0_wi0_r0_we4_1_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_we9(LOGICAL,35)@13
    u0_m0_wo0_wi0_r0_we9_q <= u0_m0_wo0_wi0_r0_we9_5_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_wa9(COUNTER,41)@13
    -- low=0, high=1, step=1, init=1
    u0_m0_wo0_wi0_r0_wa9_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_wa9_i <= TO_UNSIGNED(1, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_we9_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa9_i <= u0_m0_wo0_wi0_r0_wa9_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa9_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa9_i, 1)));

    -- u0_m0_wo0_wi0_r0_wa10_1(REG,43)@13
    u0_m0_wo0_wi0_r0_wa10_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_wa10_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa10_1_q <= u0_m0_wo0_wi0_r0_wa9_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_wa11_1(REG,44)@13
    u0_m0_wo0_wi0_r0_wa11_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_wa11_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa11_1_q <= u0_m0_wo0_wi0_r0_wa10_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_wa4_1(REG,42)@13
    u0_m0_wo0_wi0_r0_wa4_1_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_wa4_1_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa4_1_q <= u0_m0_wo0_wi0_r0_wa11_1_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_memr4(DUALMEM,46)@13
    u0_m0_wo0_wi0_r0_memr4_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split1_d);
    u0_m0_wo0_wi0_r0_memr4_aa <= u0_m0_wo0_wi0_r0_wa4_1_q;
    u0_m0_wo0_wi0_r0_memr4_ab <= u0_m0_wo0_wi0_r0_ra4_1_q;
    u0_m0_wo0_wi0_r0_memr4_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 12,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr4_aa,
        data_a => u0_m0_wo0_wi0_r0_memr4_ia,
        wren_a => u0_m0_wo0_wi0_r0_we4_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr4_ab,
        q_b => u0_m0_wo0_wi0_r0_memr4_iq
    );
    u0_m0_wo0_wi0_r0_memr4_q <= u0_m0_wo0_wi0_r0_memr4_iq(11 downto 0);

    -- u0_m0_wo0_wi0_r0_memr9(DUALMEM,47)@13
    u0_m0_wo0_wi0_r0_memr9_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split1_d);
    u0_m0_wo0_wi0_r0_memr9_aa <= u0_m0_wo0_wi0_r0_wa9_q;
    u0_m0_wo0_wi0_r0_memr9_ab <= u0_m0_wo0_wi0_r0_ra9_2_q;
    u0_m0_wo0_wi0_r0_memr9_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 12,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr9_aa,
        data_a => u0_m0_wo0_wi0_r0_memr9_ia,
        wren_a => u0_m0_wo0_wi0_r0_we9_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr9_ab,
        q_b => u0_m0_wo0_wi0_r0_memr9_iq
    );
    u0_m0_wo0_wi0_r0_memr9_q <= u0_m0_wo0_wi0_r0_memr9_iq(11 downto 0);

    -- u0_m0_wo0_compute(DELAY,16)@12
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset_n );

    -- u0_m0_wo0_symSuppress_2_seq(SEQUENCE,70)@12 + 1
    u0_m0_wo0_symSuppress_2_seq_clkproc: PROCESS (clk, areset_n)
        variable u0_m0_wo0_symSuppress_2_seq_c : SIGNED(4 downto 0);
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_symSuppress_2_seq_c := "11111";
            u0_m0_wo0_symSuppress_2_seq_q <= "0";
            u0_m0_wo0_symSuppress_2_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_symSuppress_2_seq_c = "11110") THEN
                    u0_m0_wo0_symSuppress_2_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_symSuppress_2_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_symSuppress_2_seq_eq = '1') THEN
                    u0_m0_wo0_symSuppress_2_seq_c := u0_m0_wo0_symSuppress_2_seq_c + 3;
                ELSE
                    u0_m0_wo0_symSuppress_2_seq_c := u0_m0_wo0_symSuppress_2_seq_c - 1;
                END IF;
                u0_m0_wo0_symSuppress_2_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_symSuppress_2_seq_c(4 downto 4));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_cma0_mux_2(MUX,87)@13
    u0_m0_wo0_cma0_mux_2_s <= u0_m0_wo0_symSuppress_2_seq_q;
    u0_m0_wo0_cma0_mux_2_combproc: PROCESS (u0_m0_wo0_cma0_mux_2_s, u0_m0_wo0_wi0_r0_memr9_q, GND_q)
    BEGIN
        CASE (u0_m0_wo0_cma0_mux_2_s) IS
            WHEN "0" => u0_m0_wo0_cma0_mux_2_q <= u0_m0_wo0_wi0_r0_memr9_q;
            WHEN "1" => u0_m0_wo0_cma0_mux_2_q <= STD_LOGIC_VECTOR((11 downto 1 => GND_q(0)) & GND_q);
            WHEN OTHERS => u0_m0_wo0_cma0_mux_2_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_notEnable(LOGICAL,100)@13
    u0_m0_wo0_wi0_r0_delayr1_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr1_nor(LOGICAL,101)@13
    u0_m0_wo0_wi0_r0_delayr1_nor_q <= not (u0_m0_wo0_wi0_r0_delayr1_notEnable_q or u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr1_mem_last(CONSTANT,97)
    u0_m0_wo0_wi0_r0_delayr1_mem_last_q <= "0100";

    -- u0_m0_wo0_wi0_r0_delayr1_cmp(LOGICAL,98)@13
    u0_m0_wo0_wi0_r0_delayr1_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr1_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr1_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr1_mem_last_q = u0_m0_wo0_wi0_r0_delayr1_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr1_cmpReg(REG,99)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_cmpReg_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_delayr1_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_sticky_ena(REG,102)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_sticky_ena_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr1_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_enaAnd(LOGICAL,103)@13
    u0_m0_wo0_wi0_r0_delayr1_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr1_rdcnt(COUNTER,94)@13 + 1
    -- low=0, high=5, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr1_rdcnt_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= TO_UNSIGNED(0, 3);
            u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_delayr1_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_delayr1_rdcnt_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_i + 3;
                ELSE
                    u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr1_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr1_rdcnt_i, 3)));

    -- u0_m0_wo0_wi0_r0_delayr1_rdmux(MUX,95)@13
    u0_m0_wo0_wi0_r0_delayr1_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr1_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr1_rdmux_s, u0_m0_wo0_wi0_r0_delayr1_wraddr_q, u0_m0_wo0_wi0_r0_delayr1_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr1_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr1_rdmux_q <= u0_m0_wo0_wi0_r0_delayr1_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr1_rdmux_q <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr1_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join1(BITJOIN,50)@13
    u0_m0_wo0_wi0_r0_join1_q <= u0_m0_wo0_wi0_r0_memr4_q & u0_m0_wo0_wi0_r0_split1_c & u0_m0_wo0_wi0_r0_split1_b & u0_m0_wo0_wi0_r0_memr0_q;

    -- u0_m0_wo0_wi0_r0_delayr1_wraddr(REG,96)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_wraddr_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_delayr1_wraddr_q <= "101";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_mem(DUALMEM,93)@13 + 2
    u0_m0_wo0_wi0_r0_delayr1_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join1_q);
    u0_m0_wo0_wi0_r0_delayr1_mem_aa <= u0_m0_wo0_wi0_r0_delayr1_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr1_mem_ab <= u0_m0_wo0_wi0_r0_delayr1_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr1_mem_reset0 <= not (areset_n);
    u0_m0_wo0_wi0_r0_delayr1_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 48,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 48,
        widthad_b => 3,
        numwords_b => 6,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr1_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr1_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr1_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr1_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr1_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr1_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr1_mem_q <= u0_m0_wo0_wi0_r0_delayr1_mem_iq(47 downto 0);

    -- u0_m0_wo0_wi0_r0_split1(BITSELECT,51)@13
    u0_m0_wo0_wi0_r0_split1_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(11 downto 0));
    u0_m0_wo0_wi0_r0_split1_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(23 downto 12));
    u0_m0_wo0_wi0_r0_split1_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(35 downto 24));
    u0_m0_wo0_wi0_r0_split1_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(47 downto 36));

    -- u0_m0_wo0_wi0_r0_we10(LOGICAL,37)@13
    u0_m0_wo0_wi0_r0_we10_q <= u0_m0_wo0_wi0_r0_we10_1_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_memr10(DUALMEM,48)@13
    u0_m0_wo0_wi0_r0_memr10_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_memr9_q);
    u0_m0_wo0_wi0_r0_memr10_aa <= u0_m0_wo0_wi0_r0_wa10_1_q;
    u0_m0_wo0_wi0_r0_memr10_ab <= u0_m0_wo0_wi0_r0_ra10_1_q;
    u0_m0_wo0_wi0_r0_memr10_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 12,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr10_aa,
        data_a => u0_m0_wo0_wi0_r0_memr10_ia,
        wren_a => u0_m0_wo0_wi0_r0_we10_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr10_ab,
        q_b => u0_m0_wo0_wi0_r0_memr10_iq
    );
    u0_m0_wo0_wi0_r0_memr10_q <= u0_m0_wo0_wi0_r0_memr10_iq(11 downto 0);

    -- u0_m0_wo0_symSuppress_1_seq(SEQUENCE,68)@12 + 1
    u0_m0_wo0_symSuppress_1_seq_clkproc: PROCESS (clk, areset_n)
        variable u0_m0_wo0_symSuppress_1_seq_c : SIGNED(4 downto 0);
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_symSuppress_1_seq_c := "00000";
            u0_m0_wo0_symSuppress_1_seq_q <= "0";
            u0_m0_wo0_symSuppress_1_seq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_symSuppress_1_seq_c = "11110") THEN
                    u0_m0_wo0_symSuppress_1_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_symSuppress_1_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_symSuppress_1_seq_eq = '1') THEN
                    u0_m0_wo0_symSuppress_1_seq_c := u0_m0_wo0_symSuppress_1_seq_c + 3;
                ELSE
                    u0_m0_wo0_symSuppress_1_seq_c := u0_m0_wo0_symSuppress_1_seq_c - 1;
                END IF;
                u0_m0_wo0_symSuppress_1_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_symSuppress_1_seq_c(4 downto 4));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_cma0_mux_1(MUX,86)@13
    u0_m0_wo0_cma0_mux_1_s <= u0_m0_wo0_symSuppress_1_seq_q;
    u0_m0_wo0_cma0_mux_1_combproc: PROCESS (u0_m0_wo0_cma0_mux_1_s, u0_m0_wo0_wi0_r0_memr10_q, GND_q)
    BEGIN
        CASE (u0_m0_wo0_cma0_mux_1_s) IS
            WHEN "0" => u0_m0_wo0_cma0_mux_1_q <= u0_m0_wo0_wi0_r0_memr10_q;
            WHEN "1" => u0_m0_wo0_cma0_mux_1_q <= STD_LOGIC_VECTOR((11 downto 1 => GND_q(0)) & GND_q);
            WHEN OTHERS => u0_m0_wo0_cma0_mux_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_ca5(COUNTER,56)@13
    -- low=0, high=7, step=1, init=5
    u0_m0_wo0_ca5_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_ca5_i <= TO_UNSIGNED(5, 3);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_ca5_i <= u0_m0_wo0_ca5_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca5_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca5_i, 3)));

    -- d_xIn_0_13(DELAY,88)@10 + 3
    d_xIn_0_13 : dspba_delay
    GENERIC MAP ( width => 12, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xIn_0, xout => d_xIn_0_13_q, clk => clk, aclr => areset_n );

    -- d_in0_m0_wi0_wo0_assign_id1_q_13(DELAY,89)@10 + 3
    d_in0_m0_wi0_wo0_assign_id1_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_id1_q_13_q, clk => clk, aclr => areset_n );

    -- u0_m0_wo0_wi0_r0_wa0(COUNTER,40)@13
    -- low=0, high=1, step=1, init=0
    u0_m0_wo0_wi0_r0_wa0_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_wi0_r0_wa0_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_id1_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa0_i <= u0_m0_wo0_wi0_r0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa0_i, 1)));

    -- u0_m0_wo0_wi0_r0_memr0(DUALMEM,45)@13
    u0_m0_wo0_wi0_r0_memr0_ia <= STD_LOGIC_VECTOR(d_xIn_0_13_q);
    u0_m0_wo0_wi0_r0_memr0_aa <= u0_m0_wo0_wi0_r0_wa0_q;
    u0_m0_wo0_wi0_r0_memr0_ab <= u0_m0_wo0_wi0_r0_ra0_3_q;
    u0_m0_wo0_wi0_r0_memr0_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 12,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr0_aa,
        data_a => u0_m0_wo0_wi0_r0_memr0_ia,
        wren_a => d_in0_m0_wi0_wo0_assign_id1_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr0_ab,
        q_b => u0_m0_wo0_wi0_r0_memr0_iq
    );
    u0_m0_wo0_wi0_r0_memr0_q <= u0_m0_wo0_wi0_r0_memr0_iq(11 downto 0);

    -- u0_m0_wo0_wi0_r0_we11(LOGICAL,39)@13
    u0_m0_wo0_wi0_r0_we11_q <= u0_m0_wo0_wi0_r0_we11_1_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_memr11(DUALMEM,49)@13
    u0_m0_wo0_wi0_r0_memr11_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_memr10_q);
    u0_m0_wo0_wi0_r0_memr11_aa <= u0_m0_wo0_wi0_r0_wa11_1_q;
    u0_m0_wo0_wi0_r0_memr11_ab <= u0_m0_wo0_wi0_r0_ra11_1_q;
    u0_m0_wo0_wi0_r0_memr11_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 12,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr11_aa,
        data_a => u0_m0_wo0_wi0_r0_memr11_ia,
        wren_a => u0_m0_wo0_wi0_r0_we11_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr11_ab,
        q_b => u0_m0_wo0_wi0_r0_memr11_iq
    );
    u0_m0_wo0_wi0_r0_memr11_q <= u0_m0_wo0_wi0_r0_memr11_iq(11 downto 0);

    -- u0_m0_wo0_symSuppress_0_seq(SEQUENCE,66)@12 + 1
    u0_m0_wo0_symSuppress_0_seq_clkproc: PROCESS (clk, areset_n)
        variable u0_m0_wo0_symSuppress_0_seq_c : SIGNED(4 downto 0);
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_symSuppress_0_seq_c := "11101";
            u0_m0_wo0_symSuppress_0_seq_q <= "0";
            u0_m0_wo0_symSuppress_0_seq_eq <= '1';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_symSuppress_0_seq_c = "11110") THEN
                    u0_m0_wo0_symSuppress_0_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_symSuppress_0_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_symSuppress_0_seq_eq = '1') THEN
                    u0_m0_wo0_symSuppress_0_seq_c := u0_m0_wo0_symSuppress_0_seq_c + 3;
                ELSE
                    u0_m0_wo0_symSuppress_0_seq_c := u0_m0_wo0_symSuppress_0_seq_c - 1;
                END IF;
                u0_m0_wo0_symSuppress_0_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_symSuppress_0_seq_c(4 downto 4));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_cma0_mux_0(MUX,85)@13
    u0_m0_wo0_cma0_mux_0_s <= u0_m0_wo0_symSuppress_0_seq_q;
    u0_m0_wo0_cma0_mux_0_combproc: PROCESS (u0_m0_wo0_cma0_mux_0_s, u0_m0_wo0_wi0_r0_memr11_q, GND_q)
    BEGIN
        CASE (u0_m0_wo0_cma0_mux_0_s) IS
            WHEN "0" => u0_m0_wo0_cma0_mux_0_q <= u0_m0_wo0_wi0_r0_memr11_q;
            WHEN "1" => u0_m0_wo0_cma0_mux_0_q <= STD_LOGIC_VECTOR((11 downto 1 => GND_q(0)) & GND_q);
            WHEN OTHERS => u0_m0_wo0_cma0_mux_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_15(DELAY,92)@13 + 2
    d_u0_m0_wo0_compute_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_13_q, xout => d_u0_m0_wo0_compute_q_15_q, clk => clk, aclr => areset_n );

    -- d_u0_m0_wo0_compute_q_13(DELAY,91)@12 + 1
    d_u0_m0_wo0_compute_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_13_q, clk => clk, aclr => areset_n );

    -- u0_m0_wo0_cma0(CHAINMULTADD,75)@13 + 3
    u0_m0_wo0_cma0_reset <= not (areset_n);
    u0_m0_wo0_cma0_ena0 <= d_u0_m0_wo0_compute_q_13_q(0);
    u0_m0_wo0_cma0_ena1 <= d_u0_m0_wo0_compute_q_15_q(0);
    u0_m0_wo0_cma0_ena2 <= '1';
    u0_m0_wo0_cma0_l(0) <= RESIZE(u0_m0_wo0_cma0_a1(0),13) + RESIZE(u0_m0_wo0_cma0_b1(0),13);
    u0_m0_wo0_cma0_l(1) <= RESIZE(u0_m0_wo0_cma0_a1(1),13) + RESIZE(u0_m0_wo0_cma0_b1(1),13);
    u0_m0_wo0_cma0_l(2) <= RESIZE(u0_m0_wo0_cma0_a1(2),13) + RESIZE(u0_m0_wo0_cma0_b1(2),13);
    u0_m0_wo0_cma0_l(3) <= RESIZE(u0_m0_wo0_cma0_a1(3),13) + RESIZE(u0_m0_wo0_cma0_b1(3),13);
    u0_m0_wo0_cma0_l(4) <= RESIZE(u0_m0_wo0_cma0_a1(4),13) + RESIZE(u0_m0_wo0_cma0_b1(4),13);
    u0_m0_wo0_cma0_l(5) <= RESIZE(u0_m0_wo0_cma0_a1(5),13) + RESIZE(u0_m0_wo0_cma0_b1(5),13);
    -- altera synthesis_off
    u0_m0_wo0_cma0_k0 <= (
        0 => TO_SIGNED(12,12),
        1 => TO_SIGNED(19,12),
        2 => TO_SIGNED(15,12),
        3 => TO_SIGNED(0,12),
        4 => TO_SIGNED(-18,12),
        5 => TO_SIGNED(-13,12),
        6 => TO_SIGNED(-10,12),
        7 => TO_SIGNED(0,12),
        others => (others => '0'));
    u0_m0_wo0_cma0_k1 <= (
        0 => TO_SIGNED(53,12),
        1 => TO_SIGNED(45,12),
        2 => TO_SIGNED(0,12),
        3 => TO_SIGNED(-68,12),
        4 => TO_SIGNED(-29,12),
        5 => TO_SIGNED(-24,12),
        6 => TO_SIGNED(0,12),
        7 => TO_SIGNED(32,12),
        others => (others => '0'));
    u0_m0_wo0_cma0_k2 <= (
        0 => TO_SIGNED(1043,12),
        1 => TO_SIGNED(1448,12),
        2 => TO_SIGNED(1738,12),
        3 => TO_SIGNED(-123,12),
        4 => TO_SIGNED(-116,12),
        5 => TO_SIGNED(0,12),
        6 => TO_SIGNED(248,12),
        7 => TO_SIGNED(615,12),
        others => (others => '0'));
    u0_m0_wo0_cma0_k3 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-116,12),
        2 => TO_SIGNED(1844,12),
        3 => TO_SIGNED(1738,12),
        4 => TO_SIGNED(1448,12),
        5 => TO_SIGNED(1043,12),
        6 => TO_SIGNED(0,12),
        7 => TO_SIGNED(248,12),
        others => (others => '0'));
    u0_m0_wo0_cma0_k4 <= (
        0 => TO_SIGNED(-24,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(-68,12),
        3 => TO_SIGNED(0,12),
        4 => TO_SIGNED(45,12),
        5 => TO_SIGNED(0,12),
        6 => TO_SIGNED(32,12),
        7 => TO_SIGNED(0,12),
        others => (others => '0'));
    u0_m0_wo0_cma0_k5 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-18,12),
        2 => TO_SIGNED(0,12),
        3 => TO_SIGNED(15,12),
        4 => TO_SIGNED(0,12),
        5 => TO_SIGNED(12,12),
        6 => TO_SIGNED(0,12),
        7 => TO_SIGNED(-10,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_cma0_r(0) <= u0_m0_wo0_cma0_k0(TO_INTEGER(u0_m0_wo0_cma0_c1(0)));
    u0_m0_wo0_cma0_r(1) <= u0_m0_wo0_cma0_k1(TO_INTEGER(u0_m0_wo0_cma0_c1(1)));
    u0_m0_wo0_cma0_r(2) <= u0_m0_wo0_cma0_k2(TO_INTEGER(u0_m0_wo0_cma0_c1(2)));
    u0_m0_wo0_cma0_r(3) <= u0_m0_wo0_cma0_k3(TO_INTEGER(u0_m0_wo0_cma0_c1(3)));
    u0_m0_wo0_cma0_r(4) <= u0_m0_wo0_cma0_k4(TO_INTEGER(u0_m0_wo0_cma0_c1(4)));
    u0_m0_wo0_cma0_r(5) <= u0_m0_wo0_cma0_k5(TO_INTEGER(u0_m0_wo0_cma0_c1(5)));
    u0_m0_wo0_cma0_p(0) <= u0_m0_wo0_cma0_l(0) * u0_m0_wo0_cma0_r(0);
    u0_m0_wo0_cma0_p(1) <= u0_m0_wo0_cma0_l(1) * u0_m0_wo0_cma0_r(1);
    u0_m0_wo0_cma0_p(2) <= u0_m0_wo0_cma0_l(2) * u0_m0_wo0_cma0_r(2);
    u0_m0_wo0_cma0_p(3) <= u0_m0_wo0_cma0_l(3) * u0_m0_wo0_cma0_r(3);
    u0_m0_wo0_cma0_p(4) <= u0_m0_wo0_cma0_l(4) * u0_m0_wo0_cma0_r(4);
    u0_m0_wo0_cma0_p(5) <= u0_m0_wo0_cma0_l(5) * u0_m0_wo0_cma0_r(5);
    u0_m0_wo0_cma0_u(0) <= RESIZE(u0_m0_wo0_cma0_p(0),28);
    u0_m0_wo0_cma0_u(1) <= RESIZE(u0_m0_wo0_cma0_p(1),28);
    u0_m0_wo0_cma0_u(2) <= RESIZE(u0_m0_wo0_cma0_p(2),28);
    u0_m0_wo0_cma0_u(3) <= RESIZE(u0_m0_wo0_cma0_p(3),28);
    u0_m0_wo0_cma0_u(4) <= RESIZE(u0_m0_wo0_cma0_p(4),28);
    u0_m0_wo0_cma0_u(5) <= RESIZE(u0_m0_wo0_cma0_p(5),28);
    u0_m0_wo0_cma0_w(0) <= u0_m0_wo0_cma0_u(0);
    u0_m0_wo0_cma0_w(1) <= u0_m0_wo0_cma0_u(1);
    u0_m0_wo0_cma0_w(2) <= u0_m0_wo0_cma0_u(2);
    u0_m0_wo0_cma0_w(3) <= u0_m0_wo0_cma0_u(3);
    u0_m0_wo0_cma0_w(4) <= u0_m0_wo0_cma0_u(4);
    u0_m0_wo0_cma0_w(5) <= u0_m0_wo0_cma0_u(5);
    u0_m0_wo0_cma0_x(0) <= u0_m0_wo0_cma0_w(0);
    u0_m0_wo0_cma0_x(1) <= u0_m0_wo0_cma0_w(1);
    u0_m0_wo0_cma0_x(2) <= u0_m0_wo0_cma0_w(2);
    u0_m0_wo0_cma0_x(3) <= u0_m0_wo0_cma0_w(3);
    u0_m0_wo0_cma0_x(4) <= u0_m0_wo0_cma0_w(4);
    u0_m0_wo0_cma0_x(5) <= u0_m0_wo0_cma0_w(5);
    u0_m0_wo0_cma0_y(0) <= u0_m0_wo0_cma0_s(1) + u0_m0_wo0_cma0_x(0);
    u0_m0_wo0_cma0_y(1) <= u0_m0_wo0_cma0_s(2) + u0_m0_wo0_cma0_x(1);
    u0_m0_wo0_cma0_y(2) <= u0_m0_wo0_cma0_s(3) + u0_m0_wo0_cma0_x(2);
    u0_m0_wo0_cma0_y(3) <= u0_m0_wo0_cma0_s(4) + u0_m0_wo0_cma0_x(3);
    u0_m0_wo0_cma0_y(4) <= u0_m0_wo0_cma0_s(5) + u0_m0_wo0_cma0_x(4);
    u0_m0_wo0_cma0_y(5) <= u0_m0_wo0_cma0_x(5);
    u0_m0_wo0_cma0_chainmultadd_input: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_cma0_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_b0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena0 = '1') THEN
                u0_m0_wo0_cma0_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_cma0_mux_0_q),12);
                u0_m0_wo0_cma0_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_cma0_mux_1_q),12);
                u0_m0_wo0_cma0_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_cma0_mux_2_q),12);
                u0_m0_wo0_cma0_a0(3) <= SIGNED(RESIZE(UNSIGNED(GND_q),12));
                u0_m0_wo0_cma0_a0(4) <= SIGNED(RESIZE(UNSIGNED(GND_q),12));
                u0_m0_wo0_cma0_a0(5) <= SIGNED(RESIZE(UNSIGNED(GND_q),12));
                u0_m0_wo0_cma0_b0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_memr0_q),12);
                u0_m0_wo0_cma0_b0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_b),12);
                u0_m0_wo0_cma0_b0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_c),12);
                u0_m0_wo0_cma0_b0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_d),12);
                u0_m0_wo0_cma0_b0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_memr4_q),12);
                u0_m0_wo0_cma0_b0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_e),12);
                u0_m0_wo0_cma0_c0(0) <= RESIZE(UNSIGNED(u0_m0_wo0_ca5_q),3);
                u0_m0_wo0_cma0_c0(1) <= RESIZE(UNSIGNED(u0_m0_wo0_ca5_q),3);
                u0_m0_wo0_cma0_c0(2) <= RESIZE(UNSIGNED(u0_m0_wo0_ca5_q),3);
                u0_m0_wo0_cma0_c0(3) <= RESIZE(UNSIGNED(u0_m0_wo0_ca5_q),3);
                u0_m0_wo0_cma0_c0(4) <= RESIZE(UNSIGNED(u0_m0_wo0_ca5_q),3);
                u0_m0_wo0_cma0_c0(5) <= RESIZE(UNSIGNED(u0_m0_wo0_ca5_q),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_chainmultadd_pipe: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_cma0_a1 <= (others => (others => '0'));
            u0_m0_wo0_cma0_b1 <= (others => (others => '0'));
            u0_m0_wo0_cma0_c1 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena2 = '1') THEN
                u0_m0_wo0_cma0_a1 <= u0_m0_wo0_cma0_a0;
                u0_m0_wo0_cma0_b1 <= u0_m0_wo0_cma0_b0;
                u0_m0_wo0_cma0_c1 <= u0_m0_wo0_cma0_c0;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_chainmultadd_output: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_cma0_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena1 = '1') THEN
                u0_m0_wo0_cma0_s(0) <= u0_m0_wo0_cma0_y(0);
                u0_m0_wo0_cma0_s(1) <= u0_m0_wo0_cma0_y(1);
                u0_m0_wo0_cma0_s(2) <= u0_m0_wo0_cma0_y(2);
                u0_m0_wo0_cma0_s(3) <= u0_m0_wo0_cma0_y(3);
                u0_m0_wo0_cma0_s(4) <= u0_m0_wo0_cma0_y(4);
                u0_m0_wo0_cma0_s(5) <= u0_m0_wo0_cma0_y(5);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_delay : dspba_delay
    GENERIC MAP ( width => 28, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma0_s(0)(27 downto 0)), xout => u0_m0_wo0_cma0_qq, clk => clk, aclr => areset_n );
    u0_m0_wo0_cma0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_qq(27 downto 0));

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq_gated_reg(REG,76)@15 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_15_q);
        END IF;
    END PROCESS;

    -- xOut(PORTOUT,81)@16 + 1
    xOut_v <= u0_m0_wo0_oseq_gated_reg_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_cma0_q(26 downto 0);

END normal;
