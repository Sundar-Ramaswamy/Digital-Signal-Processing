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

-- VHDL created from MCC150_TransceiverBPSK_CPR
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
entity MCC150_TransceiverBPSK_CPR is
    port (
        in_3_dv : in std_logic_vector(0 downto 0);  -- ufix1
        in_4_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_I_in : in std_logic_vector(11 downto 0);  -- sfix12
        in_2_Q_in : in std_logic_vector(11 downto 0);  -- sfix12
        out_3_Qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_4_Qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_1_I_Out : out std_logic_vector(13 downto 0);  -- sfix14
        out_2_Q_Out : out std_logic_vector(13 downto 0);  -- sfix14
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_CPR;

architecture normal of MCC150_TransceiverBPSK_CPR is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Mult3_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal Sub1_a : STD_LOGIC_VECTOR (12 downto 0);
    signal Sub1_b : STD_LOGIC_VECTOR (12 downto 0);
    signal Sub1_o : STD_LOGIC_VECTOR (12 downto 0);
    signal Sub1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal Sub1_PreShift_0_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Sub1_PreShift_0_qint : STD_LOGIC_VECTOR (9 downto 0);
    signal CORDIC_CnstZero_0_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_XLtZero_00_a : STD_LOGIC_VECTOR (23 downto 0);
    signal CORDIC_XLtZero_00_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_XgteZero_00_a : STD_LOGIC_VECTOR (23 downto 0);
    signal CORDIC_XgteZero_00_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ZeroAddSubX_00_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_ZeroAddSubX_00_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_ZeroAddSubX_00_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_ZeroAddSubX_00_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ZeroAddSubX_00_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_YLtZero_00_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CnstAtan_s0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYGeZero_s0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftY_s0_in : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_ShiftY_s0_b : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Xout_s0_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s0_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s0_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s0_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s0_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s0_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s0_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s0_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s0_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s0_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s0_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s0_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s1_b : STD_LOGIC_VECTOR (24 downto 0);
    signal CORDIC_ShiftY_s1_b : STD_LOGIC_VECTOR (24 downto 0);
    signal CORDIC_Xout_s1_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s1_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s1_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s1_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s1_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s1_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s1_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s1_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s1_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s2_b : STD_LOGIC_VECTOR (23 downto 0);
    signal CORDIC_ShiftY_s2_b : STD_LOGIC_VECTOR (23 downto 0);
    signal CORDIC_Xout_s2_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s2_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s2_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s2_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s2_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s2_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s2_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s2_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s2_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s2_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s2_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s2_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s3_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s3_b : STD_LOGIC_VECTOR (22 downto 0);
    signal CORDIC_ShiftY_s3_b : STD_LOGIC_VECTOR (22 downto 0);
    signal CORDIC_Xout_s3_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s3_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s3_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s3_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s3_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s3_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s3_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s3_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s3_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s3_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s3_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s3_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s3_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s3_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s3_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s4_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s4_b : STD_LOGIC_VECTOR (21 downto 0);
    signal CORDIC_ShiftY_s4_b : STD_LOGIC_VECTOR (21 downto 0);
    signal CORDIC_Xout_s4_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s4_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s4_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s4_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s4_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s4_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s4_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s4_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s4_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s4_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s4_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s4_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s4_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s4_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s4_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s5_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s5_b : STD_LOGIC_VECTOR (20 downto 0);
    signal CORDIC_ShiftY_s5_b : STD_LOGIC_VECTOR (20 downto 0);
    signal CORDIC_Xout_s5_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s5_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s5_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s5_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s5_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s5_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s5_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s5_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s5_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s5_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s5_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s5_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s5_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s5_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s5_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s6_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s6_b : STD_LOGIC_VECTOR (19 downto 0);
    signal CORDIC_ShiftY_s6_b : STD_LOGIC_VECTOR (19 downto 0);
    signal CORDIC_Xout_s6_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s6_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s6_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s6_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s6_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s6_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s6_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s6_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s6_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s6_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s6_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s6_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s6_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s6_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s6_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s7_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s7_b : STD_LOGIC_VECTOR (18 downto 0);
    signal CORDIC_ShiftY_s7_b : STD_LOGIC_VECTOR (18 downto 0);
    signal CORDIC_Xout_s7_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s7_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s7_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Xout_s7_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Xout_s7_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Yout_s7_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s7_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s7_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s7_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s7_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s7_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s7_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s7_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s7_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s7_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s8_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYLtZero_s8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_CmpYGeZero_s8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_ShiftX_s8_b : STD_LOGIC_VECTOR (17 downto 0);
    signal CORDIC_Yout_s8_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s8_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s8_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Yout_s8_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Yout_s8_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_Pout_s8_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s8_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s8_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s8_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s8_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_CnstAtan_s9_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_CmpYGeZero_s9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s9_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s9_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s9_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_Pout_s9_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_Pout_s9_q : STD_LOGIC_VECTOR (25 downto 0);
    signal CORDIC_LutPlusMinus_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC_LutSubP_a : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_LutSubP_b : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_LutSubP_o : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_LutSubP_q : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC_SelPonX_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC_SelPonX_q : STD_LOGIC_VECTOR (26 downto 0);
    signal CORDIC1_CnstPi_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC1_CnstPiOv2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC1_CnstNegPiOv2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC1_CmpPiOv2_00_a : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPiOv2_00_b : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPiOv2_00_o : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPiOv2_00_c : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpNegPiOv2_00_a : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpNegPiOv2_00_b : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpNegPiOv2_00_o : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpNegPiOv2_00_c : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_AorB_00_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPGeZero_s0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s0_in : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ShiftX_s0_b : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ShiftY_s0_in : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ShiftY_s0_b : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Xout_s0_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s0_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s0_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s0_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s0_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s0_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s0_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s0_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s0_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s0_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s1_b : STD_LOGIC_VECTOR (12 downto 0);
    signal CORDIC1_ShiftY_s1_b : STD_LOGIC_VECTOR (12 downto 0);
    signal CORDIC1_Xout_s1_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s1_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s1_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s1_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s1_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s1_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s1_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s1_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s1_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s1_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s1_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s2_b : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC1_ShiftY_s2_b : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC1_Xout_s2_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s2_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s2_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s2_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s2_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s2_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s2_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s2_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s2_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s3_b : STD_LOGIC_VECTOR (10 downto 0);
    signal CORDIC1_ShiftY_s3_b : STD_LOGIC_VECTOR (10 downto 0);
    signal CORDIC1_Xout_s3_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s3_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s3_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s3_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s3_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s3_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s3_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s3_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s3_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s3_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s3_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s3_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s3_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s3_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s3_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s4_b : STD_LOGIC_VECTOR (9 downto 0);
    signal CORDIC1_ShiftY_s4_b : STD_LOGIC_VECTOR (9 downto 0);
    signal CORDIC1_Xout_s4_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s4_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s4_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s4_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s4_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s4_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s4_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s4_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s4_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s4_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s4_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s4_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s5_b : STD_LOGIC_VECTOR (8 downto 0);
    signal CORDIC1_ShiftY_s5_b : STD_LOGIC_VECTOR (8 downto 0);
    signal CORDIC1_Xout_s5_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s5_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s5_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s5_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s5_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s5_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s5_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s5_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s5_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s5_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s5_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s5_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s6_b : STD_LOGIC_VECTOR (7 downto 0);
    signal CORDIC1_ShiftY_s6_b : STD_LOGIC_VECTOR (7 downto 0);
    signal CORDIC1_Xout_s6_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s6_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s6_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s6_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s6_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s6_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s6_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s6_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s6_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s6_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s6_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s6_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s6_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s6_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s6_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s7_b : STD_LOGIC_VECTOR (6 downto 0);
    signal CORDIC1_ShiftY_s7_b : STD_LOGIC_VECTOR (6 downto 0);
    signal CORDIC1_Xout_s7_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s7_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s7_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s7_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s7_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s7_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s7_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s7_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s7_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s7_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s7_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s7_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s7_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s7_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s7_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s8_b : STD_LOGIC_VECTOR (5 downto 0);
    signal CORDIC1_ShiftY_s8_b : STD_LOGIC_VECTOR (5 downto 0);
    signal CORDIC1_Xout_s8_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s8_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s8_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s8_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s8_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s8_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s8_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s8_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s8_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s8_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s8_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s8_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s8_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s8_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s8_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s9_b : STD_LOGIC_VECTOR (4 downto 0);
    signal CORDIC1_ShiftY_s9_b : STD_LOGIC_VECTOR (4 downto 0);
    signal CORDIC1_Xout_s9_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s9_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s9_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s9_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s9_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s9_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s9_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s9_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s9_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s9_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Pout_s9_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s9_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s9_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Pout_s9_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Pout_s9_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_CmpPGeZero_s10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_CmpPLtZero_s10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftX_s10_b : STD_LOGIC_VECTOR (3 downto 0);
    signal CORDIC1_ShiftY_s10_b : STD_LOGIC_VECTOR (3 downto 0);
    signal CORDIC1_Xout_s10_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s10_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s10_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s10_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s10_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s10_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s10_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s10_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s10_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s10_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ShiftX_s11_b : STD_LOGIC_VECTOR (2 downto 0);
    signal CORDIC1_ShiftY_s11_b : STD_LOGIC_VECTOR (2 downto 0);
    signal CORDIC1_Xout_s11_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s11_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s11_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s11_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s11_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s11_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s11_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s11_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s11_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ShiftX_s12_b : STD_LOGIC_VECTOR (1 downto 0);
    signal CORDIC1_ShiftY_s12_b : STD_LOGIC_VECTOR (1 downto 0);
    signal CORDIC1_Xout_s12_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s12_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s12_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s12_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s12_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s12_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s12_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s12_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s12_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s12_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ShiftX_s13_b : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ShiftY_s13_b : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s13_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s13_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s13_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Xout_s13_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Xout_s13_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_Yout_s13_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s13_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s13_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_Yout_s13_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_Yout_s13_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ConstZero_Last_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ZeroAddSubX_Last_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_ZeroAddSubX_Last_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_ZeroAddSubX_Last_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_ZeroAddSubX_Last_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ZeroAddSubX_Last_q : STD_LOGIC_VECTOR (13 downto 0);
    signal CORDIC1_ZeroAddSubY_Last_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_ZeroAddSubY_Last_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_ZeroAddSubY_Last_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_ZeroAddSubY_Last_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_ZeroAddSubY_Last_q : STD_LOGIC_VECTOR (13 downto 0);
    signal Mult3_shift0_q : STD_LOGIC_VECTOR (24 downto 0);
    signal Mult3_shift0_qint : STD_LOGIC_VECTOR (24 downto 0);
    signal Mult3_PostCast_primWireOut_rnd_sel_in : STD_LOGIC_VECTOR (25 downto 0);
    signal Mult3_PostCast_primWireOut_rnd_sel_b : STD_LOGIC_VECTOR (25 downto 0);
    signal Shift_fs_q : STD_LOGIC_VECTOR (10 downto 0);
    signal Shift_fs_qint : STD_LOGIC_VECTOR (11 downto 0);
    signal CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_a : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_b : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_i : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_o : STD_LOGIC_VECTOR (14 downto 0);
    signal CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_s : STD_LOGIC_VECTOR (0 downto 0);
    signal CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_q : STD_LOGIC_VECTOR (13 downto 0);
    signal Mult2_cma_reset : std_logic;
    type Mult2_cma_a0type is array(NATURAL range <>) of SIGNED(11 downto 0);
    signal Mult2_cma_a0 : Mult2_cma_a0type(0 to 0);
    attribute preserve : boolean;
    attribute preserve of Mult2_cma_a0 : signal is true;
    attribute altera_attribute of Mult2_cma_a0 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult2_cma_a1 : Mult2_cma_a0type(0 to 0);
    attribute preserve of Mult2_cma_a1 : signal is true;
    attribute altera_attribute of Mult2_cma_a1 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult2_cma_c0 : Mult2_cma_a0type(0 to 0);
    attribute preserve of Mult2_cma_c0 : signal is true;
    attribute altera_attribute of Mult2_cma_c0 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult2_cma_c1 : Mult2_cma_a0type(0 to 0);
    attribute preserve of Mult2_cma_c1 : signal is true;
    attribute altera_attribute of Mult2_cma_c1 : signal is "-name allow_synch_ctrl_usage off";
    type Mult2_cma_ptype is array(NATURAL range <>) of SIGNED(23 downto 0);
    signal Mult2_cma_p : Mult2_cma_ptype(0 to 0);
    signal Mult2_cma_u : Mult2_cma_ptype(0 to 0);
    signal Mult2_cma_w : Mult2_cma_ptype(0 to 0);
    signal Mult2_cma_x : Mult2_cma_ptype(0 to 0);
    signal Mult2_cma_y : Mult2_cma_ptype(0 to 0);
    signal Mult2_cma_s : Mult2_cma_ptype(0 to 0);
    signal Mult2_cma_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal Mult2_cma_q : STD_LOGIC_VECTOR (23 downto 0);
    signal Mult2_cma_ena0 : std_logic;
    signal Mult2_cma_ena1 : std_logic;
    signal Mult2_cma_ena2 : std_logic;
    signal Mult_Sub_Mult1_merged_cma_reset : std_logic;
    signal Mult_Sub_Mult1_merged_cma_a0 : Mult2_cma_a0type(0 to 1);
    attribute preserve of Mult_Sub_Mult1_merged_cma_a0 : signal is true;
    attribute altera_attribute of Mult_Sub_Mult1_merged_cma_a0 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Sub_Mult1_merged_cma_a1 : Mult2_cma_a0type(0 to 1);
    attribute preserve of Mult_Sub_Mult1_merged_cma_a1 : signal is true;
    attribute altera_attribute of Mult_Sub_Mult1_merged_cma_a1 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Sub_Mult1_merged_cma_c0 : Mult2_cma_a0type(0 to 1);
    attribute preserve of Mult_Sub_Mult1_merged_cma_c0 : signal is true;
    attribute altera_attribute of Mult_Sub_Mult1_merged_cma_c0 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Sub_Mult1_merged_cma_c1 : Mult2_cma_a0type(0 to 1);
    attribute preserve of Mult_Sub_Mult1_merged_cma_c1 : signal is true;
    attribute altera_attribute of Mult_Sub_Mult1_merged_cma_c1 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Sub_Mult1_merged_cma_p : Mult2_cma_ptype(0 to 1);
    type Mult_Sub_Mult1_merged_cma_utype is array(NATURAL range <>) of SIGNED(24 downto 0);
    signal Mult_Sub_Mult1_merged_cma_u : Mult_Sub_Mult1_merged_cma_utype(0 to 1);
    signal Mult_Sub_Mult1_merged_cma_w : Mult_Sub_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Sub_Mult1_merged_cma_x : Mult_Sub_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Sub_Mult1_merged_cma_y : Mult_Sub_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Sub_Mult1_merged_cma_s : Mult_Sub_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Sub_Mult1_merged_cma_qq : STD_LOGIC_VECTOR (24 downto 0);
    signal Mult_Sub_Mult1_merged_cma_q : STD_LOGIC_VECTOR (24 downto 0);
    signal Mult_Sub_Mult1_merged_cma_ena0 : std_logic;
    signal Mult_Sub_Mult1_merged_cma_ena1 : std_logic;
    signal Mult_Sub_Mult1_merged_cma_ena2 : std_logic;
    signal muxopt_assign_id1_q_const_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist0_Shift_fs_q_1_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist1_CORDIC1_AorB_00_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_ChannelIn_in_3_dv_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_outputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_mem_reset0 : std_logic;
    signal redist3_ChannelIn_in_4_dc_7_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist3_ChannelIn_in_4_dc_7_rdcnt_i : signal is true;
    signal redist3_ChannelIn_in_4_dc_7_rdcnt_eq : std_logic;
    attribute preserve of redist3_ChannelIn_in_4_dc_7_rdcnt_eq : signal is true;
    signal redist3_ChannelIn_in_4_dc_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_ChannelIn_in_4_dc_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of redist3_ChannelIn_in_4_dc_7_sticky_ena_q : signal is true;
    signal redist3_ChannelIn_in_4_dc_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_outputreg_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_mem_reset0 : std_logic;
    signal redist4_ChannelIn_in_1_I_in_5_mem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_mem_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_mem_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist4_ChannelIn_in_1_I_in_5_rdcnt_i : signal is true;
    signal redist4_ChannelIn_in_1_I_in_5_rdcnt_eq : std_logic;
    attribute preserve of redist4_ChannelIn_in_1_I_in_5_rdcnt_eq : signal is true;
    signal redist4_ChannelIn_in_1_I_in_5_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_mem_last_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_ChannelIn_in_1_I_in_5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist4_ChannelIn_in_1_I_in_5_sticky_ena_q : signal is true;
    signal redist4_ChannelIn_in_1_I_in_5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_outputreg_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_mem_reset0 : std_logic;
    signal redist5_ChannelIn_in_2_Q_in_5_mem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_mem_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_mem_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist5_ChannelIn_in_2_Q_in_5_rdcnt_i : signal is true;
    signal redist5_ChannelIn_in_2_Q_in_5_rdcnt_eq : std_logic;
    attribute preserve of redist5_ChannelIn_in_2_Q_in_5_rdcnt_eq : signal is true;
    signal redist5_ChannelIn_in_2_Q_in_5_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_mem_last_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_2_Q_in_5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist5_ChannelIn_in_2_Q_in_5_sticky_ena_q : signal is true;
    signal redist5_ChannelIn_in_2_Q_in_5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- CORDIC1_CnstNegPiOv2(CONSTANT,387)
    CORDIC1_CnstNegPiOv2_q <= "110011011100";

    -- Mult2_cma(CHAINMULTADD,685)@0 + 3
    Mult2_cma_reset <= not (areset_n);
    Mult2_cma_ena0 <= '1';
    Mult2_cma_ena1 <= Mult2_cma_ena0;
    Mult2_cma_ena2 <= Mult2_cma_ena0;
    Mult2_cma_p(0) <= Mult2_cma_a1(0) * Mult2_cma_c1(0);
    Mult2_cma_u(0) <= RESIZE(Mult2_cma_p(0),24);
    Mult2_cma_w(0) <= Mult2_cma_u(0);
    Mult2_cma_x(0) <= Mult2_cma_w(0);
    Mult2_cma_y(0) <= Mult2_cma_x(0);
    Mult2_cma_chainmultadd_input: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult2_cma_a0 <= (others => (others => '0'));
            Mult2_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult2_cma_ena0 = '1') THEN
                Mult2_cma_a0(0) <= RESIZE(SIGNED(in_1_I_in),12);
                Mult2_cma_c0(0) <= RESIZE(SIGNED(in_2_Q_in),12);
            END IF;
        END IF;
    END PROCESS;
    Mult2_cma_chainmultadd_pipe: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult2_cma_a1 <= (others => (others => '0'));
            Mult2_cma_c1 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult2_cma_ena2 = '1') THEN
                Mult2_cma_a1 <= Mult2_cma_a0;
                Mult2_cma_c1 <= Mult2_cma_c0;
            END IF;
        END IF;
    END PROCESS;
    Mult2_cma_chainmultadd_output: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult2_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult2_cma_ena1 = '1') THEN
                Mult2_cma_s(0) <= Mult2_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    Mult2_cma_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(Mult2_cma_s(0)(23 downto 0)), xout => Mult2_cma_qq, clk => clk, aclr => areset_n );
    Mult2_cma_q <= STD_LOGIC_VECTOR(Mult2_cma_qq(23 downto 0));

    -- Mult3_shift0(BITSHIFT,592)@3
    Mult3_shift0_qint <= Mult2_cma_q & "0";
    Mult3_shift0_q <= Mult3_shift0_qint(24 downto 0);

    -- Mult3_PostCast_primWireOut_rnd_sel(BITSELECT,593)@3
    Mult3_PostCast_primWireOut_rnd_sel_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 25 => Mult3_shift0_q(24)) & Mult3_shift0_q));
    Mult3_PostCast_primWireOut_rnd_sel_b <= STD_LOGIC_VECTOR(Mult3_PostCast_primWireOut_rnd_sel_in(25 downto 0));

    -- Mult3_PostCast_primWireOut_sel_x(BITSELECT,2)@3
    Mult3_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(Mult3_PostCast_primWireOut_rnd_sel_b(23 downto 0));

    -- CORDIC_YLtZero_00(LOGICAL,30)@3
    CORDIC_YLtZero_00_q <= STD_LOGIC_VECTOR(Mult3_PostCast_primWireOut_sel_x_b(23 downto 23));

    -- CORDIC_LutPlusMinus(LOOKUP,376)@3
    CORDIC_LutPlusMinus_combproc: PROCESS (CORDIC_YLtZero_00_q)
    BEGIN
        -- Begin reserved scope level
        CASE (CORDIC_YLtZero_00_q) IS
            WHEN "0" => CORDIC_LutPlusMinus_q <= "011001001000";
            WHEN "1" => CORDIC_LutPlusMinus_q <= "100110111000";
            WHEN OTHERS => -- unreachable
                           CORDIC_LutPlusMinus_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- CORDIC_LutSubP(SUB,377)@3
    CORDIC_LutSubP_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_LutPlusMinus_q(11)) & CORDIC_LutPlusMinus_q));
    CORDIC_LutSubP_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s9_q(25)) & CORDIC_Pout_s9_q));
    CORDIC_LutSubP_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_LutSubP_a) - SIGNED(CORDIC_LutSubP_b));
    CORDIC_LutSubP_q <= CORDIC_LutSubP_o(26 downto 0);

    -- CORDIC_CmpYLtZero_s8(LOGICAL,143)@3
    CORDIC_CmpYLtZero_s8_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s7_q(25 downto 25));

    -- CORDIC_CmpYLtZero_s6(LOGICAL,117)@3
    CORDIC_CmpYLtZero_s6_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s5_q(25 downto 25));

    -- CORDIC_CmpYLtZero_s4(LOGICAL,91)@3
    CORDIC_CmpYLtZero_s4_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s3_q(25 downto 25));

    -- CORDIC_CmpYLtZero_s2(LOGICAL,65)@3
    CORDIC_CmpYLtZero_s2_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s1_q(25 downto 25));

    -- CORDIC_XgteZero_00(LOGICAL,27)@3
    CORDIC_XgteZero_00_a <= STD_LOGIC_VECTOR(Mult_Sub_Mult1_merged_cma_q(23 downto 0));
    CORDIC_XgteZero_00_q <= not (CORDIC_XgteZero_00_a(23 downto 23));

    -- Mult_Sub_Mult1_merged_cma(CHAINMULTADD,686)@0 + 3
    Mult_Sub_Mult1_merged_cma_reset <= not (areset_n);
    Mult_Sub_Mult1_merged_cma_ena0 <= '1';
    Mult_Sub_Mult1_merged_cma_ena1 <= Mult_Sub_Mult1_merged_cma_ena0;
    Mult_Sub_Mult1_merged_cma_ena2 <= Mult_Sub_Mult1_merged_cma_ena0;
    Mult_Sub_Mult1_merged_cma_p(0) <= Mult_Sub_Mult1_merged_cma_a1(0) * Mult_Sub_Mult1_merged_cma_c1(0);
    Mult_Sub_Mult1_merged_cma_p(1) <= Mult_Sub_Mult1_merged_cma_a1(1) * Mult_Sub_Mult1_merged_cma_c1(1);
    Mult_Sub_Mult1_merged_cma_u(0) <= RESIZE(Mult_Sub_Mult1_merged_cma_p(0),25);
    Mult_Sub_Mult1_merged_cma_u(1) <= RESIZE(Mult_Sub_Mult1_merged_cma_p(1),25);
    Mult_Sub_Mult1_merged_cma_w(0) <= Mult_Sub_Mult1_merged_cma_u(1) - Mult_Sub_Mult1_merged_cma_u(0);
    Mult_Sub_Mult1_merged_cma_x(0) <= Mult_Sub_Mult1_merged_cma_w(0);
    Mult_Sub_Mult1_merged_cma_y(0) <= Mult_Sub_Mult1_merged_cma_x(0);
    Mult_Sub_Mult1_merged_cma_chainmultadd_input: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult_Sub_Mult1_merged_cma_a0 <= (others => (others => '0'));
            Mult_Sub_Mult1_merged_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult_Sub_Mult1_merged_cma_ena0 = '1') THEN
                Mult_Sub_Mult1_merged_cma_a0(0) <= RESIZE(SIGNED(in_2_Q_in),12);
                Mult_Sub_Mult1_merged_cma_a0(1) <= RESIZE(SIGNED(in_1_I_in),12);
                Mult_Sub_Mult1_merged_cma_c0(0) <= RESIZE(SIGNED(in_2_Q_in),12);
                Mult_Sub_Mult1_merged_cma_c0(1) <= RESIZE(SIGNED(in_1_I_in),12);
            END IF;
        END IF;
    END PROCESS;
    Mult_Sub_Mult1_merged_cma_chainmultadd_pipe: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult_Sub_Mult1_merged_cma_a1 <= (others => (others => '0'));
            Mult_Sub_Mult1_merged_cma_c1 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult_Sub_Mult1_merged_cma_ena2 = '1') THEN
                Mult_Sub_Mult1_merged_cma_a1 <= Mult_Sub_Mult1_merged_cma_a0;
                Mult_Sub_Mult1_merged_cma_c1 <= Mult_Sub_Mult1_merged_cma_c0;
            END IF;
        END IF;
    END PROCESS;
    Mult_Sub_Mult1_merged_cma_chainmultadd_output: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult_Sub_Mult1_merged_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult_Sub_Mult1_merged_cma_ena1 = '1') THEN
                Mult_Sub_Mult1_merged_cma_s(0) <= Mult_Sub_Mult1_merged_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    Mult_Sub_Mult1_merged_cma_delay : dspba_delay
    GENERIC MAP ( width => 25, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(Mult_Sub_Mult1_merged_cma_s(0)(24 downto 0)), xout => Mult_Sub_Mult1_merged_cma_qq, clk => clk, aclr => areset_n );
    Mult_Sub_Mult1_merged_cma_q <= STD_LOGIC_VECTOR(Mult_Sub_Mult1_merged_cma_qq(24 downto 0));

    -- CORDIC_CnstZero_0(CONSTANT,22)
    CORDIC_CnstZero_0_q <= "00000000000000000000000000";

    -- CORDIC_ZeroAddSubX_00(ADDSUB,28)@3
    CORDIC_ZeroAddSubX_00_s <= CORDIC_XgteZero_00_q;
    CORDIC_ZeroAddSubX_00_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_CnstZero_0_q(25)) & CORDIC_CnstZero_0_q));
    CORDIC_ZeroAddSubX_00_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => Mult_Sub_Mult1_merged_cma_q(24)) & Mult_Sub_Mult1_merged_cma_q));
    CORDIC_ZeroAddSubX_00_combproc: PROCESS (CORDIC_ZeroAddSubX_00_a, CORDIC_ZeroAddSubX_00_b, CORDIC_ZeroAddSubX_00_s)
    BEGIN
        IF (CORDIC_ZeroAddSubX_00_s = "1") THEN
            CORDIC_ZeroAddSubX_00_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_ZeroAddSubX_00_a) + SIGNED(CORDIC_ZeroAddSubX_00_b));
        ELSE
            CORDIC_ZeroAddSubX_00_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_ZeroAddSubX_00_a) - SIGNED(CORDIC_ZeroAddSubX_00_b));
        END IF;
    END PROCESS;
    CORDIC_ZeroAddSubX_00_q <= CORDIC_ZeroAddSubX_00_o(25 downto 0);

    -- CORDIC_Yout_s0(ADDSUB,48)@3
    CORDIC_Yout_s0_s <= CORDIC_YLtZero_00_q;
    CORDIC_Yout_s0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 24 => Mult3_PostCast_primWireOut_sel_x_b(23)) & Mult3_PostCast_primWireOut_sel_x_b));
    CORDIC_Yout_s0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_ZeroAddSubX_00_q(25)) & CORDIC_ZeroAddSubX_00_q));
    CORDIC_Yout_s0_combproc: PROCESS (CORDIC_Yout_s0_a, CORDIC_Yout_s0_b, CORDIC_Yout_s0_s)
    BEGIN
        IF (CORDIC_Yout_s0_s = "1") THEN
            CORDIC_Yout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s0_a) + SIGNED(CORDIC_Yout_s0_b));
        ELSE
            CORDIC_Yout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s0_a) - SIGNED(CORDIC_Yout_s0_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s0_q <= CORDIC_Yout_s0_o(25 downto 0);

    -- CORDIC_CmpYGeZero_s1(LOGICAL,55)@3
    CORDIC_CmpYGeZero_s1_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s0_q(25 downto 25)));

    -- CORDIC_ShiftY_s1(BITSELECT,59)@3
    CORDIC_ShiftY_s1_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s0_q(25 downto 1));

    -- CORDIC_CmpYGeZero_s0(LOGICAL,42)@3
    CORDIC_CmpYGeZero_s0_q <= STD_LOGIC_VECTOR(not (Mult3_PostCast_primWireOut_sel_x_b(23 downto 23)));

    -- CORDIC_ShiftY_s0(BITSELECT,46)@3
    CORDIC_ShiftY_s0_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 24 => Mult3_PostCast_primWireOut_sel_x_b(23)) & Mult3_PostCast_primWireOut_sel_x_b));
    CORDIC_ShiftY_s0_b <= STD_LOGIC_VECTOR(CORDIC_ShiftY_s0_in(25 downto 0));

    -- CORDIC_Xout_s0(ADDSUB,47)@3
    CORDIC_Xout_s0_s <= CORDIC_CmpYGeZero_s0_q;
    CORDIC_Xout_s0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_ZeroAddSubX_00_q(25)) & CORDIC_ZeroAddSubX_00_q));
    CORDIC_Xout_s0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_ShiftY_s0_b(25)) & CORDIC_ShiftY_s0_b));
    CORDIC_Xout_s0_combproc: PROCESS (CORDIC_Xout_s0_a, CORDIC_Xout_s0_b, CORDIC_Xout_s0_s)
    BEGIN
        IF (CORDIC_Xout_s0_s = "1") THEN
            CORDIC_Xout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s0_a) + SIGNED(CORDIC_Xout_s0_b));
        ELSE
            CORDIC_Xout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s0_a) - SIGNED(CORDIC_Xout_s0_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s0_q <= CORDIC_Xout_s0_o(25 downto 0);

    -- CORDIC_Xout_s1(ADDSUB,60)@3
    CORDIC_Xout_s1_s <= CORDIC_CmpYGeZero_s1_q;
    CORDIC_Xout_s1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s0_q(25)) & CORDIC_Xout_s0_q));
    CORDIC_Xout_s1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => CORDIC_ShiftY_s1_b(24)) & CORDIC_ShiftY_s1_b));
    CORDIC_Xout_s1_combproc: PROCESS (CORDIC_Xout_s1_a, CORDIC_Xout_s1_b, CORDIC_Xout_s1_s)
    BEGIN
        IF (CORDIC_Xout_s1_s = "1") THEN
            CORDIC_Xout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s1_a) + SIGNED(CORDIC_Xout_s1_b));
        ELSE
            CORDIC_Xout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s1_a) - SIGNED(CORDIC_Xout_s1_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s1_q <= CORDIC_Xout_s1_o(25 downto 0);

    -- CORDIC_ShiftX_s2(BITSELECT,71)@3
    CORDIC_ShiftX_s2_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s1_q(25 downto 2));

    -- CORDIC_CmpYLtZero_s1(LOGICAL,52)@3
    CORDIC_CmpYLtZero_s1_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s0_q(25 downto 25));

    -- CORDIC_ShiftX_s1(BITSELECT,58)@3
    CORDIC_ShiftX_s1_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s0_q(25 downto 1));

    -- CORDIC_Yout_s1(ADDSUB,61)@3
    CORDIC_Yout_s1_s <= CORDIC_CmpYLtZero_s1_q;
    CORDIC_Yout_s1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s0_q(25)) & CORDIC_Yout_s0_q));
    CORDIC_Yout_s1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 25 => CORDIC_ShiftX_s1_b(24)) & CORDIC_ShiftX_s1_b));
    CORDIC_Yout_s1_combproc: PROCESS (CORDIC_Yout_s1_a, CORDIC_Yout_s1_b, CORDIC_Yout_s1_s)
    BEGIN
        IF (CORDIC_Yout_s1_s = "1") THEN
            CORDIC_Yout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s1_a) + SIGNED(CORDIC_Yout_s1_b));
        ELSE
            CORDIC_Yout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s1_a) - SIGNED(CORDIC_Yout_s1_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s1_q <= CORDIC_Yout_s1_o(25 downto 0);

    -- CORDIC_Yout_s2(ADDSUB,74)@3
    CORDIC_Yout_s2_s <= CORDIC_CmpYLtZero_s2_q;
    CORDIC_Yout_s2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s1_q(25)) & CORDIC_Yout_s1_q));
    CORDIC_Yout_s2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 24 => CORDIC_ShiftX_s2_b(23)) & CORDIC_ShiftX_s2_b));
    CORDIC_Yout_s2_combproc: PROCESS (CORDIC_Yout_s2_a, CORDIC_Yout_s2_b, CORDIC_Yout_s2_s)
    BEGIN
        IF (CORDIC_Yout_s2_s = "1") THEN
            CORDIC_Yout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s2_a) + SIGNED(CORDIC_Yout_s2_b));
        ELSE
            CORDIC_Yout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s2_a) - SIGNED(CORDIC_Yout_s2_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s2_q <= CORDIC_Yout_s2_o(25 downto 0);

    -- CORDIC_CmpYGeZero_s3(LOGICAL,81)@3
    CORDIC_CmpYGeZero_s3_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s2_q(25 downto 25)));

    -- CORDIC_ShiftY_s3(BITSELECT,85)@3
    CORDIC_ShiftY_s3_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s2_q(25 downto 3));

    -- CORDIC_CmpYGeZero_s2(LOGICAL,68)@3
    CORDIC_CmpYGeZero_s2_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s1_q(25 downto 25)));

    -- CORDIC_ShiftY_s2(BITSELECT,72)@3
    CORDIC_ShiftY_s2_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s1_q(25 downto 2));

    -- CORDIC_Xout_s2(ADDSUB,73)@3
    CORDIC_Xout_s2_s <= CORDIC_CmpYGeZero_s2_q;
    CORDIC_Xout_s2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s1_q(25)) & CORDIC_Xout_s1_q));
    CORDIC_Xout_s2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 24 => CORDIC_ShiftY_s2_b(23)) & CORDIC_ShiftY_s2_b));
    CORDIC_Xout_s2_combproc: PROCESS (CORDIC_Xout_s2_a, CORDIC_Xout_s2_b, CORDIC_Xout_s2_s)
    BEGIN
        IF (CORDIC_Xout_s2_s = "1") THEN
            CORDIC_Xout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s2_a) + SIGNED(CORDIC_Xout_s2_b));
        ELSE
            CORDIC_Xout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s2_a) - SIGNED(CORDIC_Xout_s2_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s2_q <= CORDIC_Xout_s2_o(25 downto 0);

    -- CORDIC_Xout_s3(ADDSUB,86)@3
    CORDIC_Xout_s3_s <= CORDIC_CmpYGeZero_s3_q;
    CORDIC_Xout_s3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s2_q(25)) & CORDIC_Xout_s2_q));
    CORDIC_Xout_s3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 23 => CORDIC_ShiftY_s3_b(22)) & CORDIC_ShiftY_s3_b));
    CORDIC_Xout_s3_combproc: PROCESS (CORDIC_Xout_s3_a, CORDIC_Xout_s3_b, CORDIC_Xout_s3_s)
    BEGIN
        IF (CORDIC_Xout_s3_s = "1") THEN
            CORDIC_Xout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s3_a) + SIGNED(CORDIC_Xout_s3_b));
        ELSE
            CORDIC_Xout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s3_a) - SIGNED(CORDIC_Xout_s3_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s3_q <= CORDIC_Xout_s3_o(25 downto 0);

    -- CORDIC_ShiftX_s4(BITSELECT,97)@3
    CORDIC_ShiftX_s4_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s3_q(25 downto 4));

    -- CORDIC_CmpYLtZero_s3(LOGICAL,78)@3
    CORDIC_CmpYLtZero_s3_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s2_q(25 downto 25));

    -- CORDIC_ShiftX_s3(BITSELECT,84)@3
    CORDIC_ShiftX_s3_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s2_q(25 downto 3));

    -- CORDIC_Yout_s3(ADDSUB,87)@3
    CORDIC_Yout_s3_s <= CORDIC_CmpYLtZero_s3_q;
    CORDIC_Yout_s3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s2_q(25)) & CORDIC_Yout_s2_q));
    CORDIC_Yout_s3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 23 => CORDIC_ShiftX_s3_b(22)) & CORDIC_ShiftX_s3_b));
    CORDIC_Yout_s3_combproc: PROCESS (CORDIC_Yout_s3_a, CORDIC_Yout_s3_b, CORDIC_Yout_s3_s)
    BEGIN
        IF (CORDIC_Yout_s3_s = "1") THEN
            CORDIC_Yout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s3_a) + SIGNED(CORDIC_Yout_s3_b));
        ELSE
            CORDIC_Yout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s3_a) - SIGNED(CORDIC_Yout_s3_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s3_q <= CORDIC_Yout_s3_o(25 downto 0);

    -- CORDIC_Yout_s4(ADDSUB,100)@3
    CORDIC_Yout_s4_s <= CORDIC_CmpYLtZero_s4_q;
    CORDIC_Yout_s4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s3_q(25)) & CORDIC_Yout_s3_q));
    CORDIC_Yout_s4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 22 => CORDIC_ShiftX_s4_b(21)) & CORDIC_ShiftX_s4_b));
    CORDIC_Yout_s4_combproc: PROCESS (CORDIC_Yout_s4_a, CORDIC_Yout_s4_b, CORDIC_Yout_s4_s)
    BEGIN
        IF (CORDIC_Yout_s4_s = "1") THEN
            CORDIC_Yout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s4_a) + SIGNED(CORDIC_Yout_s4_b));
        ELSE
            CORDIC_Yout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s4_a) - SIGNED(CORDIC_Yout_s4_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s4_q <= CORDIC_Yout_s4_o(25 downto 0);

    -- CORDIC_CmpYGeZero_s5(LOGICAL,107)@3
    CORDIC_CmpYGeZero_s5_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s4_q(25 downto 25)));

    -- CORDIC_ShiftY_s5(BITSELECT,111)@3
    CORDIC_ShiftY_s5_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s4_q(25 downto 5));

    -- CORDIC_CmpYGeZero_s4(LOGICAL,94)@3
    CORDIC_CmpYGeZero_s4_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s3_q(25 downto 25)));

    -- CORDIC_ShiftY_s4(BITSELECT,98)@3
    CORDIC_ShiftY_s4_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s3_q(25 downto 4));

    -- CORDIC_Xout_s4(ADDSUB,99)@3
    CORDIC_Xout_s4_s <= CORDIC_CmpYGeZero_s4_q;
    CORDIC_Xout_s4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s3_q(25)) & CORDIC_Xout_s3_q));
    CORDIC_Xout_s4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 22 => CORDIC_ShiftY_s4_b(21)) & CORDIC_ShiftY_s4_b));
    CORDIC_Xout_s4_combproc: PROCESS (CORDIC_Xout_s4_a, CORDIC_Xout_s4_b, CORDIC_Xout_s4_s)
    BEGIN
        IF (CORDIC_Xout_s4_s = "1") THEN
            CORDIC_Xout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s4_a) + SIGNED(CORDIC_Xout_s4_b));
        ELSE
            CORDIC_Xout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s4_a) - SIGNED(CORDIC_Xout_s4_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s4_q <= CORDIC_Xout_s4_o(25 downto 0);

    -- CORDIC_Xout_s5(ADDSUB,112)@3
    CORDIC_Xout_s5_s <= CORDIC_CmpYGeZero_s5_q;
    CORDIC_Xout_s5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s4_q(25)) & CORDIC_Xout_s4_q));
    CORDIC_Xout_s5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 21 => CORDIC_ShiftY_s5_b(20)) & CORDIC_ShiftY_s5_b));
    CORDIC_Xout_s5_combproc: PROCESS (CORDIC_Xout_s5_a, CORDIC_Xout_s5_b, CORDIC_Xout_s5_s)
    BEGIN
        IF (CORDIC_Xout_s5_s = "1") THEN
            CORDIC_Xout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s5_a) + SIGNED(CORDIC_Xout_s5_b));
        ELSE
            CORDIC_Xout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s5_a) - SIGNED(CORDIC_Xout_s5_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s5_q <= CORDIC_Xout_s5_o(25 downto 0);

    -- CORDIC_ShiftX_s6(BITSELECT,123)@3
    CORDIC_ShiftX_s6_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s5_q(25 downto 6));

    -- CORDIC_CmpYLtZero_s5(LOGICAL,104)@3
    CORDIC_CmpYLtZero_s5_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s4_q(25 downto 25));

    -- CORDIC_ShiftX_s5(BITSELECT,110)@3
    CORDIC_ShiftX_s5_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s4_q(25 downto 5));

    -- CORDIC_Yout_s5(ADDSUB,113)@3
    CORDIC_Yout_s5_s <= CORDIC_CmpYLtZero_s5_q;
    CORDIC_Yout_s5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s4_q(25)) & CORDIC_Yout_s4_q));
    CORDIC_Yout_s5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 21 => CORDIC_ShiftX_s5_b(20)) & CORDIC_ShiftX_s5_b));
    CORDIC_Yout_s5_combproc: PROCESS (CORDIC_Yout_s5_a, CORDIC_Yout_s5_b, CORDIC_Yout_s5_s)
    BEGIN
        IF (CORDIC_Yout_s5_s = "1") THEN
            CORDIC_Yout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s5_a) + SIGNED(CORDIC_Yout_s5_b));
        ELSE
            CORDIC_Yout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s5_a) - SIGNED(CORDIC_Yout_s5_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s5_q <= CORDIC_Yout_s5_o(25 downto 0);

    -- CORDIC_Yout_s6(ADDSUB,126)@3
    CORDIC_Yout_s6_s <= CORDIC_CmpYLtZero_s6_q;
    CORDIC_Yout_s6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s5_q(25)) & CORDIC_Yout_s5_q));
    CORDIC_Yout_s6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 20 => CORDIC_ShiftX_s6_b(19)) & CORDIC_ShiftX_s6_b));
    CORDIC_Yout_s6_combproc: PROCESS (CORDIC_Yout_s6_a, CORDIC_Yout_s6_b, CORDIC_Yout_s6_s)
    BEGIN
        IF (CORDIC_Yout_s6_s = "1") THEN
            CORDIC_Yout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s6_a) + SIGNED(CORDIC_Yout_s6_b));
        ELSE
            CORDIC_Yout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s6_a) - SIGNED(CORDIC_Yout_s6_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s6_q <= CORDIC_Yout_s6_o(25 downto 0);

    -- CORDIC_CmpYGeZero_s7(LOGICAL,133)@3
    CORDIC_CmpYGeZero_s7_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s6_q(25 downto 25)));

    -- CORDIC_ShiftY_s7(BITSELECT,137)@3
    CORDIC_ShiftY_s7_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s6_q(25 downto 7));

    -- CORDIC_CmpYGeZero_s6(LOGICAL,120)@3
    CORDIC_CmpYGeZero_s6_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s5_q(25 downto 25)));

    -- CORDIC_ShiftY_s6(BITSELECT,124)@3
    CORDIC_ShiftY_s6_b <= STD_LOGIC_VECTOR(CORDIC_Yout_s5_q(25 downto 6));

    -- CORDIC_Xout_s6(ADDSUB,125)@3
    CORDIC_Xout_s6_s <= CORDIC_CmpYGeZero_s6_q;
    CORDIC_Xout_s6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s5_q(25)) & CORDIC_Xout_s5_q));
    CORDIC_Xout_s6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 20 => CORDIC_ShiftY_s6_b(19)) & CORDIC_ShiftY_s6_b));
    CORDIC_Xout_s6_combproc: PROCESS (CORDIC_Xout_s6_a, CORDIC_Xout_s6_b, CORDIC_Xout_s6_s)
    BEGIN
        IF (CORDIC_Xout_s6_s = "1") THEN
            CORDIC_Xout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s6_a) + SIGNED(CORDIC_Xout_s6_b));
        ELSE
            CORDIC_Xout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s6_a) - SIGNED(CORDIC_Xout_s6_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s6_q <= CORDIC_Xout_s6_o(25 downto 0);

    -- CORDIC_Xout_s7(ADDSUB,138)@3
    CORDIC_Xout_s7_s <= CORDIC_CmpYGeZero_s7_q;
    CORDIC_Xout_s7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Xout_s6_q(25)) & CORDIC_Xout_s6_q));
    CORDIC_Xout_s7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 19 => CORDIC_ShiftY_s7_b(18)) & CORDIC_ShiftY_s7_b));
    CORDIC_Xout_s7_combproc: PROCESS (CORDIC_Xout_s7_a, CORDIC_Xout_s7_b, CORDIC_Xout_s7_s)
    BEGIN
        IF (CORDIC_Xout_s7_s = "1") THEN
            CORDIC_Xout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s7_a) + SIGNED(CORDIC_Xout_s7_b));
        ELSE
            CORDIC_Xout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Xout_s7_a) - SIGNED(CORDIC_Xout_s7_b));
        END IF;
    END PROCESS;
    CORDIC_Xout_s7_q <= CORDIC_Xout_s7_o(25 downto 0);

    -- CORDIC_ShiftX_s8(BITSELECT,149)@3
    CORDIC_ShiftX_s8_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s7_q(25 downto 8));

    -- CORDIC_CmpYLtZero_s7(LOGICAL,130)@3
    CORDIC_CmpYLtZero_s7_q <= STD_LOGIC_VECTOR(CORDIC_Yout_s6_q(25 downto 25));

    -- CORDIC_ShiftX_s7(BITSELECT,136)@3
    CORDIC_ShiftX_s7_b <= STD_LOGIC_VECTOR(CORDIC_Xout_s6_q(25 downto 7));

    -- CORDIC_Yout_s7(ADDSUB,139)@3
    CORDIC_Yout_s7_s <= CORDIC_CmpYLtZero_s7_q;
    CORDIC_Yout_s7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s6_q(25)) & CORDIC_Yout_s6_q));
    CORDIC_Yout_s7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 19 => CORDIC_ShiftX_s7_b(18)) & CORDIC_ShiftX_s7_b));
    CORDIC_Yout_s7_combproc: PROCESS (CORDIC_Yout_s7_a, CORDIC_Yout_s7_b, CORDIC_Yout_s7_s)
    BEGIN
        IF (CORDIC_Yout_s7_s = "1") THEN
            CORDIC_Yout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s7_a) + SIGNED(CORDIC_Yout_s7_b));
        ELSE
            CORDIC_Yout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s7_a) - SIGNED(CORDIC_Yout_s7_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s7_q <= CORDIC_Yout_s7_o(25 downto 0);

    -- CORDIC_Yout_s8(ADDSUB,152)@3
    CORDIC_Yout_s8_s <= CORDIC_CmpYLtZero_s8_q;
    CORDIC_Yout_s8_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Yout_s7_q(25)) & CORDIC_Yout_s7_q));
    CORDIC_Yout_s8_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 18 => CORDIC_ShiftX_s8_b(17)) & CORDIC_ShiftX_s8_b));
    CORDIC_Yout_s8_combproc: PROCESS (CORDIC_Yout_s8_a, CORDIC_Yout_s8_b, CORDIC_Yout_s8_s)
    BEGIN
        IF (CORDIC_Yout_s8_s = "1") THEN
            CORDIC_Yout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s8_a) + SIGNED(CORDIC_Yout_s8_b));
        ELSE
            CORDIC_Yout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Yout_s8_a) - SIGNED(CORDIC_Yout_s8_b));
        END IF;
    END PROCESS;
    CORDIC_Yout_s8_q <= CORDIC_Yout_s8_o(25 downto 0);

    -- CORDIC_CmpYGeZero_s9(LOGICAL,159)@3
    CORDIC_CmpYGeZero_s9_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s8_q(25 downto 25)));

    -- CORDIC_CnstAtan_s9(CONSTANT,155)
    CORDIC_CnstAtan_s9_q <= "000000000001";

    -- CORDIC_CmpYGeZero_s8(LOGICAL,146)@3
    CORDIC_CmpYGeZero_s8_q <= STD_LOGIC_VECTOR(not (CORDIC_Yout_s7_q(25 downto 25)));

    -- CORDIC_CnstAtan_s8(CONSTANT,142)
    CORDIC_CnstAtan_s8_q <= "000000000010";

    -- CORDIC_CnstAtan_s7(CONSTANT,129)
    CORDIC_CnstAtan_s7_q <= "000000000100";

    -- CORDIC_CnstAtan_s6(CONSTANT,116)
    CORDIC_CnstAtan_s6_q <= "000000001000";

    -- CORDIC_CnstAtan_s5(CONSTANT,103)
    CORDIC_CnstAtan_s5_q <= "000000010000";

    -- CORDIC_CnstAtan_s4(CONSTANT,90)
    CORDIC_CnstAtan_s4_q <= "000000100000";

    -- CORDIC_CnstAtan_s3(CONSTANT,77)
    CORDIC_CnstAtan_s3_q <= "000001000000";

    -- CORDIC_CnstAtan_s2(CONSTANT,64)
    CORDIC_CnstAtan_s2_q <= "000001111101";

    -- CORDIC_CnstAtan_s1(CONSTANT,51)
    CORDIC_CnstAtan_s1_q <= "000011101101";

    -- CORDIC_CnstAtan_s0(CONSTANT,38)
    CORDIC_CnstAtan_s0_q <= "000110010010";

    -- muxopt_assign_id1_q_const(CONSTANT,687)
    muxopt_assign_id1_q_const_q <= "000000000000";

    -- CORDIC_Pout_s0(ADDSUB,49)@3
    CORDIC_Pout_s0_s <= CORDIC_CmpYGeZero_s0_q;
    CORDIC_Pout_s0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => muxopt_assign_id1_q_const_q(11)) & muxopt_assign_id1_q_const_q));
    CORDIC_Pout_s0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s0_q(11)) & CORDIC_CnstAtan_s0_q));
    CORDIC_Pout_s0_combproc: PROCESS (CORDIC_Pout_s0_a, CORDIC_Pout_s0_b, CORDIC_Pout_s0_s)
    BEGIN
        IF (CORDIC_Pout_s0_s = "1") THEN
            CORDIC_Pout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s0_a) + SIGNED(CORDIC_Pout_s0_b));
        ELSE
            CORDIC_Pout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s0_a) - SIGNED(CORDIC_Pout_s0_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s0_q <= CORDIC_Pout_s0_o(25 downto 0);

    -- CORDIC_Pout_s1(ADDSUB,62)@3
    CORDIC_Pout_s1_s <= CORDIC_CmpYGeZero_s1_q;
    CORDIC_Pout_s1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s0_q(25)) & CORDIC_Pout_s0_q));
    CORDIC_Pout_s1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s1_q(11)) & CORDIC_CnstAtan_s1_q));
    CORDIC_Pout_s1_combproc: PROCESS (CORDIC_Pout_s1_a, CORDIC_Pout_s1_b, CORDIC_Pout_s1_s)
    BEGIN
        IF (CORDIC_Pout_s1_s = "1") THEN
            CORDIC_Pout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s1_a) + SIGNED(CORDIC_Pout_s1_b));
        ELSE
            CORDIC_Pout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s1_a) - SIGNED(CORDIC_Pout_s1_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s1_q <= CORDIC_Pout_s1_o(25 downto 0);

    -- CORDIC_Pout_s2(ADDSUB,75)@3
    CORDIC_Pout_s2_s <= CORDIC_CmpYGeZero_s2_q;
    CORDIC_Pout_s2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s1_q(25)) & CORDIC_Pout_s1_q));
    CORDIC_Pout_s2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s2_q(11)) & CORDIC_CnstAtan_s2_q));
    CORDIC_Pout_s2_combproc: PROCESS (CORDIC_Pout_s2_a, CORDIC_Pout_s2_b, CORDIC_Pout_s2_s)
    BEGIN
        IF (CORDIC_Pout_s2_s = "1") THEN
            CORDIC_Pout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s2_a) + SIGNED(CORDIC_Pout_s2_b));
        ELSE
            CORDIC_Pout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s2_a) - SIGNED(CORDIC_Pout_s2_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s2_q <= CORDIC_Pout_s2_o(25 downto 0);

    -- CORDIC_Pout_s3(ADDSUB,88)@3
    CORDIC_Pout_s3_s <= CORDIC_CmpYGeZero_s3_q;
    CORDIC_Pout_s3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s2_q(25)) & CORDIC_Pout_s2_q));
    CORDIC_Pout_s3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s3_q(11)) & CORDIC_CnstAtan_s3_q));
    CORDIC_Pout_s3_combproc: PROCESS (CORDIC_Pout_s3_a, CORDIC_Pout_s3_b, CORDIC_Pout_s3_s)
    BEGIN
        IF (CORDIC_Pout_s3_s = "1") THEN
            CORDIC_Pout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s3_a) + SIGNED(CORDIC_Pout_s3_b));
        ELSE
            CORDIC_Pout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s3_a) - SIGNED(CORDIC_Pout_s3_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s3_q <= CORDIC_Pout_s3_o(25 downto 0);

    -- CORDIC_Pout_s4(ADDSUB,101)@3
    CORDIC_Pout_s4_s <= CORDIC_CmpYGeZero_s4_q;
    CORDIC_Pout_s4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s3_q(25)) & CORDIC_Pout_s3_q));
    CORDIC_Pout_s4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s4_q(11)) & CORDIC_CnstAtan_s4_q));
    CORDIC_Pout_s4_combproc: PROCESS (CORDIC_Pout_s4_a, CORDIC_Pout_s4_b, CORDIC_Pout_s4_s)
    BEGIN
        IF (CORDIC_Pout_s4_s = "1") THEN
            CORDIC_Pout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s4_a) + SIGNED(CORDIC_Pout_s4_b));
        ELSE
            CORDIC_Pout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s4_a) - SIGNED(CORDIC_Pout_s4_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s4_q <= CORDIC_Pout_s4_o(25 downto 0);

    -- CORDIC_Pout_s5(ADDSUB,114)@3
    CORDIC_Pout_s5_s <= CORDIC_CmpYGeZero_s5_q;
    CORDIC_Pout_s5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s4_q(25)) & CORDIC_Pout_s4_q));
    CORDIC_Pout_s5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s5_q(11)) & CORDIC_CnstAtan_s5_q));
    CORDIC_Pout_s5_combproc: PROCESS (CORDIC_Pout_s5_a, CORDIC_Pout_s5_b, CORDIC_Pout_s5_s)
    BEGIN
        IF (CORDIC_Pout_s5_s = "1") THEN
            CORDIC_Pout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s5_a) + SIGNED(CORDIC_Pout_s5_b));
        ELSE
            CORDIC_Pout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s5_a) - SIGNED(CORDIC_Pout_s5_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s5_q <= CORDIC_Pout_s5_o(25 downto 0);

    -- CORDIC_Pout_s6(ADDSUB,127)@3
    CORDIC_Pout_s6_s <= CORDIC_CmpYGeZero_s6_q;
    CORDIC_Pout_s6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s5_q(25)) & CORDIC_Pout_s5_q));
    CORDIC_Pout_s6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s6_q(11)) & CORDIC_CnstAtan_s6_q));
    CORDIC_Pout_s6_combproc: PROCESS (CORDIC_Pout_s6_a, CORDIC_Pout_s6_b, CORDIC_Pout_s6_s)
    BEGIN
        IF (CORDIC_Pout_s6_s = "1") THEN
            CORDIC_Pout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s6_a) + SIGNED(CORDIC_Pout_s6_b));
        ELSE
            CORDIC_Pout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s6_a) - SIGNED(CORDIC_Pout_s6_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s6_q <= CORDIC_Pout_s6_o(25 downto 0);

    -- CORDIC_Pout_s7(ADDSUB,140)@3
    CORDIC_Pout_s7_s <= CORDIC_CmpYGeZero_s7_q;
    CORDIC_Pout_s7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s6_q(25)) & CORDIC_Pout_s6_q));
    CORDIC_Pout_s7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s7_q(11)) & CORDIC_CnstAtan_s7_q));
    CORDIC_Pout_s7_combproc: PROCESS (CORDIC_Pout_s7_a, CORDIC_Pout_s7_b, CORDIC_Pout_s7_s)
    BEGIN
        IF (CORDIC_Pout_s7_s = "1") THEN
            CORDIC_Pout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s7_a) + SIGNED(CORDIC_Pout_s7_b));
        ELSE
            CORDIC_Pout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s7_a) - SIGNED(CORDIC_Pout_s7_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s7_q <= CORDIC_Pout_s7_o(25 downto 0);

    -- CORDIC_Pout_s8(ADDSUB,153)@3
    CORDIC_Pout_s8_s <= CORDIC_CmpYGeZero_s8_q;
    CORDIC_Pout_s8_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s7_q(25)) & CORDIC_Pout_s7_q));
    CORDIC_Pout_s8_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s8_q(11)) & CORDIC_CnstAtan_s8_q));
    CORDIC_Pout_s8_combproc: PROCESS (CORDIC_Pout_s8_a, CORDIC_Pout_s8_b, CORDIC_Pout_s8_s)
    BEGIN
        IF (CORDIC_Pout_s8_s = "1") THEN
            CORDIC_Pout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s8_a) + SIGNED(CORDIC_Pout_s8_b));
        ELSE
            CORDIC_Pout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s8_a) - SIGNED(CORDIC_Pout_s8_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s8_q <= CORDIC_Pout_s8_o(25 downto 0);

    -- CORDIC_Pout_s9(ADDSUB,166)@3
    CORDIC_Pout_s9_s <= CORDIC_CmpYGeZero_s9_q;
    CORDIC_Pout_s9_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s8_q(25)) & CORDIC_Pout_s8_q));
    CORDIC_Pout_s9_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 12 => CORDIC_CnstAtan_s9_q(11)) & CORDIC_CnstAtan_s9_q));
    CORDIC_Pout_s9_combproc: PROCESS (CORDIC_Pout_s9_a, CORDIC_Pout_s9_b, CORDIC_Pout_s9_s)
    BEGIN
        IF (CORDIC_Pout_s9_s = "1") THEN
            CORDIC_Pout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s9_a) + SIGNED(CORDIC_Pout_s9_b));
        ELSE
            CORDIC_Pout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC_Pout_s9_a) - SIGNED(CORDIC_Pout_s9_b));
        END IF;
    END PROCESS;
    CORDIC_Pout_s9_q <= CORDIC_Pout_s9_o(25 downto 0);

    -- CORDIC_XLtZero_00(LOGICAL,26)@3
    CORDIC_XLtZero_00_a <= STD_LOGIC_VECTOR(Mult_Sub_Mult1_merged_cma_q(23 downto 0));
    CORDIC_XLtZero_00_q <= CORDIC_XLtZero_00_a(23 downto 23);

    -- CORDIC_SelPonX(MUX,380)@3
    CORDIC_SelPonX_s <= CORDIC_XLtZero_00_q;
    CORDIC_SelPonX_combproc: PROCESS (CORDIC_SelPonX_s, CORDIC_Pout_s9_q, CORDIC_LutSubP_q)
    BEGIN
        CASE (CORDIC_SelPonX_s) IS
            WHEN "0" => CORDIC_SelPonX_q <= STD_LOGIC_VECTOR((26 downto 26 => CORDIC_Pout_s9_q(25)) & CORDIC_Pout_s9_q);
            WHEN "1" => CORDIC_SelPonX_q <= CORDIC_LutSubP_q;
            WHEN OTHERS => CORDIC_SelPonX_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Sub1_PreShift_0(BITSHIFT,21)@3
    Sub1_PreShift_0_qint <= GND_q & "000000000";
    Sub1_PreShift_0_q <= Sub1_PreShift_0_qint(9 downto 0);

    -- Sub1(SUB,20)@3
    Sub1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & Sub1_PreShift_0_q));
    Sub1_b <= STD_LOGIC_VECTOR(CORDIC_SelPonX_q(12 downto 0));
    Sub1_o <= STD_LOGIC_VECTOR(SIGNED(Sub1_a) - SIGNED(Sub1_b));
    Sub1_q <= Sub1_o(11 downto 0);

    -- Shift_fs(BITSHIFT,594)@3
    Shift_fs_qint <= Sub1_q;
    Shift_fs_q <= Shift_fs_qint(11 downto 1);

    -- redist0_Shift_fs_q_1(DELAY,688)
    redist0_Shift_fs_q_1 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => Shift_fs_q, xout => redist0_Shift_fs_q_1_q, clk => clk, aclr => areset_n );

    -- CORDIC1_CmpNegPiOv2_00(COMPARE,394)@4
    CORDIC1_CmpNegPiOv2_00_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 11 => redist0_Shift_fs_q_1_q(10)) & redist0_Shift_fs_q_1_q));
    CORDIC1_CmpNegPiOv2_00_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => CORDIC1_CnstNegPiOv2_q(11)) & CORDIC1_CnstNegPiOv2_q));
    CORDIC1_CmpNegPiOv2_00_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_CmpNegPiOv2_00_a) - SIGNED(CORDIC1_CmpNegPiOv2_00_b));
    CORDIC1_CmpNegPiOv2_00_c(0) <= CORDIC1_CmpNegPiOv2_00_o(13);

    -- CORDIC1_CnstPiOv2(CONSTANT,386)
    CORDIC1_CnstPiOv2_q <= "001100100100";

    -- CORDIC1_CmpPiOv2_00(COMPARE,393)@4
    CORDIC1_CmpPiOv2_00_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => CORDIC1_CnstPiOv2_q(11)) & CORDIC1_CnstPiOv2_q));
    CORDIC1_CmpPiOv2_00_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 11 => redist0_Shift_fs_q_1_q(10)) & redist0_Shift_fs_q_1_q));
    CORDIC1_CmpPiOv2_00_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_CmpPiOv2_00_a) - SIGNED(CORDIC1_CmpPiOv2_00_b));
    CORDIC1_CmpPiOv2_00_c(0) <= CORDIC1_CmpPiOv2_00_o(13);

    -- CORDIC1_AorB_00(LOGICAL,395)@4
    CORDIC1_AorB_00_q <= not (CORDIC1_CmpPiOv2_00_c or CORDIC1_CmpNegPiOv2_00_c);

    -- redist1_CORDIC1_AorB_00_q_2(DELAY,689)
    redist1_CORDIC1_AorB_00_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => CORDIC1_AorB_00_q, xout => redist1_CORDIC1_AorB_00_q_2_q, clk => clk, aclr => areset_n );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- CORDIC1_CmpPLtZero_s9(LOGICAL,522)@5
    CORDIC1_CmpPLtZero_s9_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s8_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s8(LOGICAL,509)@5
    CORDIC1_CmpPLtZero_s8_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s7_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s7(LOGICAL,496)@5
    CORDIC1_CmpPLtZero_s7_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s6_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s6(LOGICAL,483)@5
    CORDIC1_CmpPLtZero_s6_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s5_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s5(LOGICAL,470)@5
    CORDIC1_CmpPLtZero_s5_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s4_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s4(LOGICAL,457)@5
    CORDIC1_CmpPLtZero_s4_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s3_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s3(LOGICAL,444)@5
    CORDIC1_CmpPLtZero_s3_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s2_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s2(LOGICAL,431)@5
    CORDIC1_CmpPLtZero_s2_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s1_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s1(LOGICAL,418)@5
    CORDIC1_CmpPLtZero_s1_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s0_q(13 downto 13));

    -- CORDIC1_CmpPLtZero_s0(LOGICAL,405)@5
    CORDIC1_CmpPLtZero_s0_q <= STD_LOGIC_VECTOR(CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_q(13 downto 13));

    -- CORDIC1_CnstPi(CONSTANT,385)
    CORDIC1_CnstPi_q <= "011001001000";

    -- CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged(ADDSUB,653)@4 + 1
    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_s <= CORDIC1_CmpNegPiOv2_00_c;
    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 11 => redist0_Shift_fs_q_1_q(10)) & redist0_Shift_fs_q_1_q));
    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC1_CnstPi_q(11)) & CORDIC1_CnstPi_q));
    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_i <= CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_a;
    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (CORDIC1_AorB_00_q = "1") THEN
                CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_o <= CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_i;
            ELSE
                IF (CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_s = "1") THEN
                    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_a) + SIGNED(CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_b));
                ELSE
                    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_a) - SIGNED(CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_q <= CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_o(13 downto 0);

    -- CORDIC1_Pout_s0(ADDSUB,411)@5
    CORDIC1_Pout_s0_s <= CORDIC1_CmpPLtZero_s0_q;
    CORDIC1_Pout_s0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_q(13)) & CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_q));
    CORDIC1_Pout_s0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s0_q(11)) & CORDIC_CnstAtan_s0_q));
    CORDIC1_Pout_s0_combproc: PROCESS (CORDIC1_Pout_s0_a, CORDIC1_Pout_s0_b, CORDIC1_Pout_s0_s)
    BEGIN
        IF (CORDIC1_Pout_s0_s = "1") THEN
            CORDIC1_Pout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s0_a) + SIGNED(CORDIC1_Pout_s0_b));
        ELSE
            CORDIC1_Pout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s0_a) - SIGNED(CORDIC1_Pout_s0_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s0_q <= CORDIC1_Pout_s0_o(13 downto 0);

    -- CORDIC1_Pout_s1(ADDSUB,424)@5
    CORDIC1_Pout_s1_s <= CORDIC1_CmpPLtZero_s1_q;
    CORDIC1_Pout_s1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s0_q(13)) & CORDIC1_Pout_s0_q));
    CORDIC1_Pout_s1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s1_q(11)) & CORDIC_CnstAtan_s1_q));
    CORDIC1_Pout_s1_combproc: PROCESS (CORDIC1_Pout_s1_a, CORDIC1_Pout_s1_b, CORDIC1_Pout_s1_s)
    BEGIN
        IF (CORDIC1_Pout_s1_s = "1") THEN
            CORDIC1_Pout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s1_a) + SIGNED(CORDIC1_Pout_s1_b));
        ELSE
            CORDIC1_Pout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s1_a) - SIGNED(CORDIC1_Pout_s1_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s1_q <= CORDIC1_Pout_s1_o(13 downto 0);

    -- CORDIC1_Pout_s2(ADDSUB,437)@5
    CORDIC1_Pout_s2_s <= CORDIC1_CmpPLtZero_s2_q;
    CORDIC1_Pout_s2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s1_q(13)) & CORDIC1_Pout_s1_q));
    CORDIC1_Pout_s2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s2_q(11)) & CORDIC_CnstAtan_s2_q));
    CORDIC1_Pout_s2_combproc: PROCESS (CORDIC1_Pout_s2_a, CORDIC1_Pout_s2_b, CORDIC1_Pout_s2_s)
    BEGIN
        IF (CORDIC1_Pout_s2_s = "1") THEN
            CORDIC1_Pout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s2_a) + SIGNED(CORDIC1_Pout_s2_b));
        ELSE
            CORDIC1_Pout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s2_a) - SIGNED(CORDIC1_Pout_s2_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s2_q <= CORDIC1_Pout_s2_o(13 downto 0);

    -- CORDIC1_Pout_s3(ADDSUB,450)@5
    CORDIC1_Pout_s3_s <= CORDIC1_CmpPLtZero_s3_q;
    CORDIC1_Pout_s3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s2_q(13)) & CORDIC1_Pout_s2_q));
    CORDIC1_Pout_s3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s3_q(11)) & CORDIC_CnstAtan_s3_q));
    CORDIC1_Pout_s3_combproc: PROCESS (CORDIC1_Pout_s3_a, CORDIC1_Pout_s3_b, CORDIC1_Pout_s3_s)
    BEGIN
        IF (CORDIC1_Pout_s3_s = "1") THEN
            CORDIC1_Pout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s3_a) + SIGNED(CORDIC1_Pout_s3_b));
        ELSE
            CORDIC1_Pout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s3_a) - SIGNED(CORDIC1_Pout_s3_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s3_q <= CORDIC1_Pout_s3_o(13 downto 0);

    -- CORDIC1_Pout_s4(ADDSUB,463)@5
    CORDIC1_Pout_s4_s <= CORDIC1_CmpPLtZero_s4_q;
    CORDIC1_Pout_s4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s3_q(13)) & CORDIC1_Pout_s3_q));
    CORDIC1_Pout_s4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s4_q(11)) & CORDIC_CnstAtan_s4_q));
    CORDIC1_Pout_s4_combproc: PROCESS (CORDIC1_Pout_s4_a, CORDIC1_Pout_s4_b, CORDIC1_Pout_s4_s)
    BEGIN
        IF (CORDIC1_Pout_s4_s = "1") THEN
            CORDIC1_Pout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s4_a) + SIGNED(CORDIC1_Pout_s4_b));
        ELSE
            CORDIC1_Pout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s4_a) - SIGNED(CORDIC1_Pout_s4_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s4_q <= CORDIC1_Pout_s4_o(13 downto 0);

    -- CORDIC1_Pout_s5(ADDSUB,476)@5
    CORDIC1_Pout_s5_s <= CORDIC1_CmpPLtZero_s5_q;
    CORDIC1_Pout_s5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s4_q(13)) & CORDIC1_Pout_s4_q));
    CORDIC1_Pout_s5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s5_q(11)) & CORDIC_CnstAtan_s5_q));
    CORDIC1_Pout_s5_combproc: PROCESS (CORDIC1_Pout_s5_a, CORDIC1_Pout_s5_b, CORDIC1_Pout_s5_s)
    BEGIN
        IF (CORDIC1_Pout_s5_s = "1") THEN
            CORDIC1_Pout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s5_a) + SIGNED(CORDIC1_Pout_s5_b));
        ELSE
            CORDIC1_Pout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s5_a) - SIGNED(CORDIC1_Pout_s5_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s5_q <= CORDIC1_Pout_s5_o(13 downto 0);

    -- CORDIC1_Pout_s6(ADDSUB,489)@5
    CORDIC1_Pout_s6_s <= CORDIC1_CmpPLtZero_s6_q;
    CORDIC1_Pout_s6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s5_q(13)) & CORDIC1_Pout_s5_q));
    CORDIC1_Pout_s6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s6_q(11)) & CORDIC_CnstAtan_s6_q));
    CORDIC1_Pout_s6_combproc: PROCESS (CORDIC1_Pout_s6_a, CORDIC1_Pout_s6_b, CORDIC1_Pout_s6_s)
    BEGIN
        IF (CORDIC1_Pout_s6_s = "1") THEN
            CORDIC1_Pout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s6_a) + SIGNED(CORDIC1_Pout_s6_b));
        ELSE
            CORDIC1_Pout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s6_a) - SIGNED(CORDIC1_Pout_s6_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s6_q <= CORDIC1_Pout_s6_o(13 downto 0);

    -- CORDIC1_Pout_s7(ADDSUB,502)@5
    CORDIC1_Pout_s7_s <= CORDIC1_CmpPLtZero_s7_q;
    CORDIC1_Pout_s7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s6_q(13)) & CORDIC1_Pout_s6_q));
    CORDIC1_Pout_s7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s7_q(11)) & CORDIC_CnstAtan_s7_q));
    CORDIC1_Pout_s7_combproc: PROCESS (CORDIC1_Pout_s7_a, CORDIC1_Pout_s7_b, CORDIC1_Pout_s7_s)
    BEGIN
        IF (CORDIC1_Pout_s7_s = "1") THEN
            CORDIC1_Pout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s7_a) + SIGNED(CORDIC1_Pout_s7_b));
        ELSE
            CORDIC1_Pout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s7_a) - SIGNED(CORDIC1_Pout_s7_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s7_q <= CORDIC1_Pout_s7_o(13 downto 0);

    -- CORDIC1_Pout_s8(ADDSUB,515)@5
    CORDIC1_Pout_s8_s <= CORDIC1_CmpPLtZero_s8_q;
    CORDIC1_Pout_s8_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s7_q(13)) & CORDIC1_Pout_s7_q));
    CORDIC1_Pout_s8_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s8_q(11)) & CORDIC_CnstAtan_s8_q));
    CORDIC1_Pout_s8_combproc: PROCESS (CORDIC1_Pout_s8_a, CORDIC1_Pout_s8_b, CORDIC1_Pout_s8_s)
    BEGIN
        IF (CORDIC1_Pout_s8_s = "1") THEN
            CORDIC1_Pout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s8_a) + SIGNED(CORDIC1_Pout_s8_b));
        ELSE
            CORDIC1_Pout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s8_a) - SIGNED(CORDIC1_Pout_s8_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s8_q <= CORDIC1_Pout_s8_o(13 downto 0);

    -- CORDIC1_Pout_s9(ADDSUB,528)@5
    CORDIC1_Pout_s9_s <= CORDIC1_CmpPLtZero_s9_q;
    CORDIC1_Pout_s9_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Pout_s8_q(13)) & CORDIC1_Pout_s8_q));
    CORDIC1_Pout_s9_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC_CnstAtan_s9_q(11)) & CORDIC_CnstAtan_s9_q));
    CORDIC1_Pout_s9_combproc: PROCESS (CORDIC1_Pout_s9_a, CORDIC1_Pout_s9_b, CORDIC1_Pout_s9_s)
    BEGIN
        IF (CORDIC1_Pout_s9_s = "1") THEN
            CORDIC1_Pout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s9_a) + SIGNED(CORDIC1_Pout_s9_b));
        ELSE
            CORDIC1_Pout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Pout_s9_a) - SIGNED(CORDIC1_Pout_s9_b));
        END IF;
    END PROCESS;
    CORDIC1_Pout_s9_q <= CORDIC1_Pout_s9_o(13 downto 0);

    -- CORDIC1_CmpPGeZero_s10(LOGICAL,532)@5
    CORDIC1_CmpPGeZero_s10_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s9_q(13 downto 13)));

    -- CORDIC1_CmpPLtZero_s10(LOGICAL,535)@5
    CORDIC1_CmpPLtZero_s10_q <= STD_LOGIC_VECTOR(CORDIC1_Pout_s9_q(13 downto 13));

    -- CORDIC1_CmpPGeZero_s9(LOGICAL,519)@5
    CORDIC1_CmpPGeZero_s9_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s8_q(13 downto 13)));

    -- CORDIC1_CmpPGeZero_s7(LOGICAL,493)@5
    CORDIC1_CmpPGeZero_s7_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s6_q(13 downto 13)));

    -- CORDIC1_CmpPGeZero_s5(LOGICAL,467)@5
    CORDIC1_CmpPGeZero_s5_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s4_q(13 downto 13)));

    -- CORDIC1_CmpPGeZero_s3(LOGICAL,441)@5
    CORDIC1_CmpPGeZero_s3_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s2_q(13 downto 13)));

    -- CORDIC1_CmpPGeZero_s1(LOGICAL,415)@5
    CORDIC1_CmpPGeZero_s1_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s0_q(13 downto 13)));

    -- redist5_ChannelIn_in_2_Q_in_5_notEnable(LOGICAL,723)
    redist5_ChannelIn_in_2_Q_in_5_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist5_ChannelIn_in_2_Q_in_5_nor(LOGICAL,724)
    redist5_ChannelIn_in_2_Q_in_5_nor_q <= not (redist5_ChannelIn_in_2_Q_in_5_notEnable_q or redist5_ChannelIn_in_2_Q_in_5_sticky_ena_q);

    -- redist5_ChannelIn_in_2_Q_in_5_mem_last(CONSTANT,720)
    redist5_ChannelIn_in_2_Q_in_5_mem_last_q <= "01";

    -- redist5_ChannelIn_in_2_Q_in_5_cmp(LOGICAL,721)
    redist5_ChannelIn_in_2_Q_in_5_cmp_q <= "1" WHEN redist5_ChannelIn_in_2_Q_in_5_mem_last_q = redist5_ChannelIn_in_2_Q_in_5_rdcnt_q ELSE "0";

    -- redist5_ChannelIn_in_2_Q_in_5_cmpReg(REG,722)
    redist5_ChannelIn_in_2_Q_in_5_cmpReg_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_2_Q_in_5_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist5_ChannelIn_in_2_Q_in_5_cmpReg_q <= STD_LOGIC_VECTOR(redist5_ChannelIn_in_2_Q_in_5_cmp_q);
        END IF;
    END PROCESS;

    -- redist5_ChannelIn_in_2_Q_in_5_sticky_ena(REG,725)
    redist5_ChannelIn_in_2_Q_in_5_sticky_ena_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_2_Q_in_5_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist5_ChannelIn_in_2_Q_in_5_nor_q = "1") THEN
                redist5_ChannelIn_in_2_Q_in_5_sticky_ena_q <= STD_LOGIC_VECTOR(redist5_ChannelIn_in_2_Q_in_5_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_ChannelIn_in_2_Q_in_5_enaAnd(LOGICAL,726)
    redist5_ChannelIn_in_2_Q_in_5_enaAnd_q <= redist5_ChannelIn_in_2_Q_in_5_sticky_ena_q and VCC_q;

    -- redist5_ChannelIn_in_2_Q_in_5_rdcnt(COUNTER,718)
    -- low=0, high=2, step=1, init=0
    redist5_ChannelIn_in_2_Q_in_5_rdcnt_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_2_Q_in_5_rdcnt_i <= TO_UNSIGNED(0, 2);
            redist5_ChannelIn_in_2_Q_in_5_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist5_ChannelIn_in_2_Q_in_5_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                redist5_ChannelIn_in_2_Q_in_5_rdcnt_eq <= '1';
            ELSE
                redist5_ChannelIn_in_2_Q_in_5_rdcnt_eq <= '0';
            END IF;
            IF (redist5_ChannelIn_in_2_Q_in_5_rdcnt_eq = '1') THEN
                redist5_ChannelIn_in_2_Q_in_5_rdcnt_i <= redist5_ChannelIn_in_2_Q_in_5_rdcnt_i + 2;
            ELSE
                redist5_ChannelIn_in_2_Q_in_5_rdcnt_i <= redist5_ChannelIn_in_2_Q_in_5_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist5_ChannelIn_in_2_Q_in_5_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist5_ChannelIn_in_2_Q_in_5_rdcnt_i, 2)));

    -- redist5_ChannelIn_in_2_Q_in_5_wraddr(REG,719)
    redist5_ChannelIn_in_2_Q_in_5_wraddr_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_2_Q_in_5_wraddr_q <= "10";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist5_ChannelIn_in_2_Q_in_5_wraddr_q <= STD_LOGIC_VECTOR(redist5_ChannelIn_in_2_Q_in_5_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist5_ChannelIn_in_2_Q_in_5_mem(DUALMEM,717)
    redist5_ChannelIn_in_2_Q_in_5_mem_ia <= STD_LOGIC_VECTOR(in_2_Q_in);
    redist5_ChannelIn_in_2_Q_in_5_mem_aa <= redist5_ChannelIn_in_2_Q_in_5_wraddr_q;
    redist5_ChannelIn_in_2_Q_in_5_mem_ab <= redist5_ChannelIn_in_2_Q_in_5_rdcnt_q;
    redist5_ChannelIn_in_2_Q_in_5_mem_reset0 <= not (areset_n);
    redist5_ChannelIn_in_2_Q_in_5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 12,
        widthad_b => 2,
        numwords_b => 3,
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
        clocken1 => redist5_ChannelIn_in_2_Q_in_5_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist5_ChannelIn_in_2_Q_in_5_mem_reset0,
        clock1 => clk,
        address_a => redist5_ChannelIn_in_2_Q_in_5_mem_aa,
        data_a => redist5_ChannelIn_in_2_Q_in_5_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist5_ChannelIn_in_2_Q_in_5_mem_ab,
        q_b => redist5_ChannelIn_in_2_Q_in_5_mem_iq
    );
    redist5_ChannelIn_in_2_Q_in_5_mem_q <= redist5_ChannelIn_in_2_Q_in_5_mem_iq(11 downto 0);

    -- redist5_ChannelIn_in_2_Q_in_5_outputreg(DELAY,716)
    redist5_ChannelIn_in_2_Q_in_5_outputreg : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist5_ChannelIn_in_2_Q_in_5_mem_q, xout => redist5_ChannelIn_in_2_Q_in_5_outputreg_q, clk => clk, aclr => areset_n );

    -- CORDIC1_ShiftY_s0(BITSELECT,408)@5
    CORDIC1_ShiftY_s0_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => redist5_ChannelIn_in_2_Q_in_5_outputreg_q(11)) & redist5_ChannelIn_in_2_Q_in_5_outputreg_q));
    CORDIC1_ShiftY_s0_b <= STD_LOGIC_VECTOR(CORDIC1_ShiftY_s0_in(13 downto 0));

    -- redist4_ChannelIn_in_1_I_in_5_notEnable(LOGICAL,712)
    redist4_ChannelIn_in_1_I_in_5_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist4_ChannelIn_in_1_I_in_5_nor(LOGICAL,713)
    redist4_ChannelIn_in_1_I_in_5_nor_q <= not (redist4_ChannelIn_in_1_I_in_5_notEnable_q or redist4_ChannelIn_in_1_I_in_5_sticky_ena_q);

    -- redist4_ChannelIn_in_1_I_in_5_mem_last(CONSTANT,709)
    redist4_ChannelIn_in_1_I_in_5_mem_last_q <= "01";

    -- redist4_ChannelIn_in_1_I_in_5_cmp(LOGICAL,710)
    redist4_ChannelIn_in_1_I_in_5_cmp_q <= "1" WHEN redist4_ChannelIn_in_1_I_in_5_mem_last_q = redist4_ChannelIn_in_1_I_in_5_rdcnt_q ELSE "0";

    -- redist4_ChannelIn_in_1_I_in_5_cmpReg(REG,711)
    redist4_ChannelIn_in_1_I_in_5_cmpReg_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist4_ChannelIn_in_1_I_in_5_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist4_ChannelIn_in_1_I_in_5_cmpReg_q <= STD_LOGIC_VECTOR(redist4_ChannelIn_in_1_I_in_5_cmp_q);
        END IF;
    END PROCESS;

    -- redist4_ChannelIn_in_1_I_in_5_sticky_ena(REG,714)
    redist4_ChannelIn_in_1_I_in_5_sticky_ena_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist4_ChannelIn_in_1_I_in_5_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist4_ChannelIn_in_1_I_in_5_nor_q = "1") THEN
                redist4_ChannelIn_in_1_I_in_5_sticky_ena_q <= STD_LOGIC_VECTOR(redist4_ChannelIn_in_1_I_in_5_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist4_ChannelIn_in_1_I_in_5_enaAnd(LOGICAL,715)
    redist4_ChannelIn_in_1_I_in_5_enaAnd_q <= redist4_ChannelIn_in_1_I_in_5_sticky_ena_q and VCC_q;

    -- redist4_ChannelIn_in_1_I_in_5_rdcnt(COUNTER,707)
    -- low=0, high=2, step=1, init=0
    redist4_ChannelIn_in_1_I_in_5_rdcnt_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist4_ChannelIn_in_1_I_in_5_rdcnt_i <= TO_UNSIGNED(0, 2);
            redist4_ChannelIn_in_1_I_in_5_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist4_ChannelIn_in_1_I_in_5_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                redist4_ChannelIn_in_1_I_in_5_rdcnt_eq <= '1';
            ELSE
                redist4_ChannelIn_in_1_I_in_5_rdcnt_eq <= '0';
            END IF;
            IF (redist4_ChannelIn_in_1_I_in_5_rdcnt_eq = '1') THEN
                redist4_ChannelIn_in_1_I_in_5_rdcnt_i <= redist4_ChannelIn_in_1_I_in_5_rdcnt_i + 2;
            ELSE
                redist4_ChannelIn_in_1_I_in_5_rdcnt_i <= redist4_ChannelIn_in_1_I_in_5_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist4_ChannelIn_in_1_I_in_5_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist4_ChannelIn_in_1_I_in_5_rdcnt_i, 2)));

    -- redist4_ChannelIn_in_1_I_in_5_wraddr(REG,708)
    redist4_ChannelIn_in_1_I_in_5_wraddr_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist4_ChannelIn_in_1_I_in_5_wraddr_q <= "10";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist4_ChannelIn_in_1_I_in_5_wraddr_q <= STD_LOGIC_VECTOR(redist4_ChannelIn_in_1_I_in_5_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist4_ChannelIn_in_1_I_in_5_mem(DUALMEM,706)
    redist4_ChannelIn_in_1_I_in_5_mem_ia <= STD_LOGIC_VECTOR(in_1_I_in);
    redist4_ChannelIn_in_1_I_in_5_mem_aa <= redist4_ChannelIn_in_1_I_in_5_wraddr_q;
    redist4_ChannelIn_in_1_I_in_5_mem_ab <= redist4_ChannelIn_in_1_I_in_5_rdcnt_q;
    redist4_ChannelIn_in_1_I_in_5_mem_reset0 <= not (areset_n);
    redist4_ChannelIn_in_1_I_in_5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 12,
        widthad_b => 2,
        numwords_b => 3,
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
        clocken1 => redist4_ChannelIn_in_1_I_in_5_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist4_ChannelIn_in_1_I_in_5_mem_reset0,
        clock1 => clk,
        address_a => redist4_ChannelIn_in_1_I_in_5_mem_aa,
        data_a => redist4_ChannelIn_in_1_I_in_5_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist4_ChannelIn_in_1_I_in_5_mem_ab,
        q_b => redist4_ChannelIn_in_1_I_in_5_mem_iq
    );
    redist4_ChannelIn_in_1_I_in_5_mem_q <= redist4_ChannelIn_in_1_I_in_5_mem_iq(11 downto 0);

    -- redist4_ChannelIn_in_1_I_in_5_outputreg(DELAY,705)
    redist4_ChannelIn_in_1_I_in_5_outputreg : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist4_ChannelIn_in_1_I_in_5_mem_q, xout => redist4_ChannelIn_in_1_I_in_5_outputreg_q, clk => clk, aclr => areset_n );

    -- CORDIC1_Xout_s0(ADDSUB,409)@5
    CORDIC1_Xout_s0_s <= CORDIC1_CmpPLtZero_s0_q;
    CORDIC1_Xout_s0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => redist4_ChannelIn_in_1_I_in_5_outputreg_q(11)) & redist4_ChannelIn_in_1_I_in_5_outputreg_q));
    CORDIC1_Xout_s0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_ShiftY_s0_b(13)) & CORDIC1_ShiftY_s0_b));
    CORDIC1_Xout_s0_combproc: PROCESS (CORDIC1_Xout_s0_a, CORDIC1_Xout_s0_b, CORDIC1_Xout_s0_s)
    BEGIN
        IF (CORDIC1_Xout_s0_s = "1") THEN
            CORDIC1_Xout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s0_a) + SIGNED(CORDIC1_Xout_s0_b));
        ELSE
            CORDIC1_Xout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s0_a) - SIGNED(CORDIC1_Xout_s0_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s0_q <= CORDIC1_Xout_s0_o(13 downto 0);

    -- CORDIC1_ShiftX_s1(BITSELECT,420)@5
    CORDIC1_ShiftX_s1_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s0_q(13 downto 1));

    -- CORDIC1_CmpPGeZero_s0(LOGICAL,402)@5
    CORDIC1_CmpPGeZero_s0_q <= STD_LOGIC_VECTOR(not (CORDIC1_PAddSubPi_00_CORDIC1_SelectP_00_merged_q(13 downto 13)));

    -- CORDIC1_ShiftX_s0(BITSELECT,407)@5
    CORDIC1_ShiftX_s0_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => redist4_ChannelIn_in_1_I_in_5_outputreg_q(11)) & redist4_ChannelIn_in_1_I_in_5_outputreg_q));
    CORDIC1_ShiftX_s0_b <= STD_LOGIC_VECTOR(CORDIC1_ShiftX_s0_in(13 downto 0));

    -- CORDIC1_Yout_s0(ADDSUB,410)@5
    CORDIC1_Yout_s0_s <= CORDIC1_CmpPGeZero_s0_q;
    CORDIC1_Yout_s0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => redist5_ChannelIn_in_2_Q_in_5_outputreg_q(11)) & redist5_ChannelIn_in_2_Q_in_5_outputreg_q));
    CORDIC1_Yout_s0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_ShiftX_s0_b(13)) & CORDIC1_ShiftX_s0_b));
    CORDIC1_Yout_s0_combproc: PROCESS (CORDIC1_Yout_s0_a, CORDIC1_Yout_s0_b, CORDIC1_Yout_s0_s)
    BEGIN
        IF (CORDIC1_Yout_s0_s = "1") THEN
            CORDIC1_Yout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s0_a) + SIGNED(CORDIC1_Yout_s0_b));
        ELSE
            CORDIC1_Yout_s0_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s0_a) - SIGNED(CORDIC1_Yout_s0_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s0_q <= CORDIC1_Yout_s0_o(13 downto 0);

    -- CORDIC1_Yout_s1(ADDSUB,423)@5
    CORDIC1_Yout_s1_s <= CORDIC1_CmpPGeZero_s1_q;
    CORDIC1_Yout_s1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s0_q(13)) & CORDIC1_Yout_s0_q));
    CORDIC1_Yout_s1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 13 => CORDIC1_ShiftX_s1_b(12)) & CORDIC1_ShiftX_s1_b));
    CORDIC1_Yout_s1_combproc: PROCESS (CORDIC1_Yout_s1_a, CORDIC1_Yout_s1_b, CORDIC1_Yout_s1_s)
    BEGIN
        IF (CORDIC1_Yout_s1_s = "1") THEN
            CORDIC1_Yout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s1_a) + SIGNED(CORDIC1_Yout_s1_b));
        ELSE
            CORDIC1_Yout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s1_a) - SIGNED(CORDIC1_Yout_s1_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s1_q <= CORDIC1_Yout_s1_o(13 downto 0);

    -- CORDIC1_ShiftY_s2(BITSELECT,434)@5
    CORDIC1_ShiftY_s2_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s1_q(13 downto 2));

    -- CORDIC1_ShiftY_s1(BITSELECT,421)@5
    CORDIC1_ShiftY_s1_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s0_q(13 downto 1));

    -- CORDIC1_Xout_s1(ADDSUB,422)@5
    CORDIC1_Xout_s1_s <= CORDIC1_CmpPLtZero_s1_q;
    CORDIC1_Xout_s1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s0_q(13)) & CORDIC1_Xout_s0_q));
    CORDIC1_Xout_s1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 13 => CORDIC1_ShiftY_s1_b(12)) & CORDIC1_ShiftY_s1_b));
    CORDIC1_Xout_s1_combproc: PROCESS (CORDIC1_Xout_s1_a, CORDIC1_Xout_s1_b, CORDIC1_Xout_s1_s)
    BEGIN
        IF (CORDIC1_Xout_s1_s = "1") THEN
            CORDIC1_Xout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s1_a) + SIGNED(CORDIC1_Xout_s1_b));
        ELSE
            CORDIC1_Xout_s1_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s1_a) - SIGNED(CORDIC1_Xout_s1_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s1_q <= CORDIC1_Xout_s1_o(13 downto 0);

    -- CORDIC1_Xout_s2(ADDSUB,435)@5
    CORDIC1_Xout_s2_s <= CORDIC1_CmpPLtZero_s2_q;
    CORDIC1_Xout_s2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s1_q(13)) & CORDIC1_Xout_s1_q));
    CORDIC1_Xout_s2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC1_ShiftY_s2_b(11)) & CORDIC1_ShiftY_s2_b));
    CORDIC1_Xout_s2_combproc: PROCESS (CORDIC1_Xout_s2_a, CORDIC1_Xout_s2_b, CORDIC1_Xout_s2_s)
    BEGIN
        IF (CORDIC1_Xout_s2_s = "1") THEN
            CORDIC1_Xout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s2_a) + SIGNED(CORDIC1_Xout_s2_b));
        ELSE
            CORDIC1_Xout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s2_a) - SIGNED(CORDIC1_Xout_s2_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s2_q <= CORDIC1_Xout_s2_o(13 downto 0);

    -- CORDIC1_ShiftX_s3(BITSELECT,446)@5
    CORDIC1_ShiftX_s3_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s2_q(13 downto 3));

    -- CORDIC1_CmpPGeZero_s2(LOGICAL,428)@5
    CORDIC1_CmpPGeZero_s2_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s1_q(13 downto 13)));

    -- CORDIC1_ShiftX_s2(BITSELECT,433)@5
    CORDIC1_ShiftX_s2_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s1_q(13 downto 2));

    -- CORDIC1_Yout_s2(ADDSUB,436)@5
    CORDIC1_Yout_s2_s <= CORDIC1_CmpPGeZero_s2_q;
    CORDIC1_Yout_s2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s1_q(13)) & CORDIC1_Yout_s1_q));
    CORDIC1_Yout_s2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 12 => CORDIC1_ShiftX_s2_b(11)) & CORDIC1_ShiftX_s2_b));
    CORDIC1_Yout_s2_combproc: PROCESS (CORDIC1_Yout_s2_a, CORDIC1_Yout_s2_b, CORDIC1_Yout_s2_s)
    BEGIN
        IF (CORDIC1_Yout_s2_s = "1") THEN
            CORDIC1_Yout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s2_a) + SIGNED(CORDIC1_Yout_s2_b));
        ELSE
            CORDIC1_Yout_s2_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s2_a) - SIGNED(CORDIC1_Yout_s2_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s2_q <= CORDIC1_Yout_s2_o(13 downto 0);

    -- CORDIC1_Yout_s3(ADDSUB,449)@5
    CORDIC1_Yout_s3_s <= CORDIC1_CmpPGeZero_s3_q;
    CORDIC1_Yout_s3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s2_q(13)) & CORDIC1_Yout_s2_q));
    CORDIC1_Yout_s3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 11 => CORDIC1_ShiftX_s3_b(10)) & CORDIC1_ShiftX_s3_b));
    CORDIC1_Yout_s3_combproc: PROCESS (CORDIC1_Yout_s3_a, CORDIC1_Yout_s3_b, CORDIC1_Yout_s3_s)
    BEGIN
        IF (CORDIC1_Yout_s3_s = "1") THEN
            CORDIC1_Yout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s3_a) + SIGNED(CORDIC1_Yout_s3_b));
        ELSE
            CORDIC1_Yout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s3_a) - SIGNED(CORDIC1_Yout_s3_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s3_q <= CORDIC1_Yout_s3_o(13 downto 0);

    -- CORDIC1_ShiftY_s4(BITSELECT,460)@5
    CORDIC1_ShiftY_s4_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s3_q(13 downto 4));

    -- CORDIC1_ShiftY_s3(BITSELECT,447)@5
    CORDIC1_ShiftY_s3_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s2_q(13 downto 3));

    -- CORDIC1_Xout_s3(ADDSUB,448)@5
    CORDIC1_Xout_s3_s <= CORDIC1_CmpPLtZero_s3_q;
    CORDIC1_Xout_s3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s2_q(13)) & CORDIC1_Xout_s2_q));
    CORDIC1_Xout_s3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 11 => CORDIC1_ShiftY_s3_b(10)) & CORDIC1_ShiftY_s3_b));
    CORDIC1_Xout_s3_combproc: PROCESS (CORDIC1_Xout_s3_a, CORDIC1_Xout_s3_b, CORDIC1_Xout_s3_s)
    BEGIN
        IF (CORDIC1_Xout_s3_s = "1") THEN
            CORDIC1_Xout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s3_a) + SIGNED(CORDIC1_Xout_s3_b));
        ELSE
            CORDIC1_Xout_s3_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s3_a) - SIGNED(CORDIC1_Xout_s3_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s3_q <= CORDIC1_Xout_s3_o(13 downto 0);

    -- CORDIC1_Xout_s4(ADDSUB,461)@5
    CORDIC1_Xout_s4_s <= CORDIC1_CmpPLtZero_s4_q;
    CORDIC1_Xout_s4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s3_q(13)) & CORDIC1_Xout_s3_q));
    CORDIC1_Xout_s4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 10 => CORDIC1_ShiftY_s4_b(9)) & CORDIC1_ShiftY_s4_b));
    CORDIC1_Xout_s4_combproc: PROCESS (CORDIC1_Xout_s4_a, CORDIC1_Xout_s4_b, CORDIC1_Xout_s4_s)
    BEGIN
        IF (CORDIC1_Xout_s4_s = "1") THEN
            CORDIC1_Xout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s4_a) + SIGNED(CORDIC1_Xout_s4_b));
        ELSE
            CORDIC1_Xout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s4_a) - SIGNED(CORDIC1_Xout_s4_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s4_q <= CORDIC1_Xout_s4_o(13 downto 0);

    -- CORDIC1_ShiftX_s5(BITSELECT,472)@5
    CORDIC1_ShiftX_s5_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s4_q(13 downto 5));

    -- CORDIC1_CmpPGeZero_s4(LOGICAL,454)@5
    CORDIC1_CmpPGeZero_s4_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s3_q(13 downto 13)));

    -- CORDIC1_ShiftX_s4(BITSELECT,459)@5
    CORDIC1_ShiftX_s4_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s3_q(13 downto 4));

    -- CORDIC1_Yout_s4(ADDSUB,462)@5
    CORDIC1_Yout_s4_s <= CORDIC1_CmpPGeZero_s4_q;
    CORDIC1_Yout_s4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s3_q(13)) & CORDIC1_Yout_s3_q));
    CORDIC1_Yout_s4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 10 => CORDIC1_ShiftX_s4_b(9)) & CORDIC1_ShiftX_s4_b));
    CORDIC1_Yout_s4_combproc: PROCESS (CORDIC1_Yout_s4_a, CORDIC1_Yout_s4_b, CORDIC1_Yout_s4_s)
    BEGIN
        IF (CORDIC1_Yout_s4_s = "1") THEN
            CORDIC1_Yout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s4_a) + SIGNED(CORDIC1_Yout_s4_b));
        ELSE
            CORDIC1_Yout_s4_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s4_a) - SIGNED(CORDIC1_Yout_s4_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s4_q <= CORDIC1_Yout_s4_o(13 downto 0);

    -- CORDIC1_Yout_s5(ADDSUB,475)@5
    CORDIC1_Yout_s5_s <= CORDIC1_CmpPGeZero_s5_q;
    CORDIC1_Yout_s5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s4_q(13)) & CORDIC1_Yout_s4_q));
    CORDIC1_Yout_s5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 9 => CORDIC1_ShiftX_s5_b(8)) & CORDIC1_ShiftX_s5_b));
    CORDIC1_Yout_s5_combproc: PROCESS (CORDIC1_Yout_s5_a, CORDIC1_Yout_s5_b, CORDIC1_Yout_s5_s)
    BEGIN
        IF (CORDIC1_Yout_s5_s = "1") THEN
            CORDIC1_Yout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s5_a) + SIGNED(CORDIC1_Yout_s5_b));
        ELSE
            CORDIC1_Yout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s5_a) - SIGNED(CORDIC1_Yout_s5_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s5_q <= CORDIC1_Yout_s5_o(13 downto 0);

    -- CORDIC1_ShiftY_s6(BITSELECT,486)@5
    CORDIC1_ShiftY_s6_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s5_q(13 downto 6));

    -- CORDIC1_ShiftY_s5(BITSELECT,473)@5
    CORDIC1_ShiftY_s5_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s4_q(13 downto 5));

    -- CORDIC1_Xout_s5(ADDSUB,474)@5
    CORDIC1_Xout_s5_s <= CORDIC1_CmpPLtZero_s5_q;
    CORDIC1_Xout_s5_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s4_q(13)) & CORDIC1_Xout_s4_q));
    CORDIC1_Xout_s5_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 9 => CORDIC1_ShiftY_s5_b(8)) & CORDIC1_ShiftY_s5_b));
    CORDIC1_Xout_s5_combproc: PROCESS (CORDIC1_Xout_s5_a, CORDIC1_Xout_s5_b, CORDIC1_Xout_s5_s)
    BEGIN
        IF (CORDIC1_Xout_s5_s = "1") THEN
            CORDIC1_Xout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s5_a) + SIGNED(CORDIC1_Xout_s5_b));
        ELSE
            CORDIC1_Xout_s5_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s5_a) - SIGNED(CORDIC1_Xout_s5_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s5_q <= CORDIC1_Xout_s5_o(13 downto 0);

    -- CORDIC1_Xout_s6(ADDSUB,487)@5
    CORDIC1_Xout_s6_s <= CORDIC1_CmpPLtZero_s6_q;
    CORDIC1_Xout_s6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s5_q(13)) & CORDIC1_Xout_s5_q));
    CORDIC1_Xout_s6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 8 => CORDIC1_ShiftY_s6_b(7)) & CORDIC1_ShiftY_s6_b));
    CORDIC1_Xout_s6_combproc: PROCESS (CORDIC1_Xout_s6_a, CORDIC1_Xout_s6_b, CORDIC1_Xout_s6_s)
    BEGIN
        IF (CORDIC1_Xout_s6_s = "1") THEN
            CORDIC1_Xout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s6_a) + SIGNED(CORDIC1_Xout_s6_b));
        ELSE
            CORDIC1_Xout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s6_a) - SIGNED(CORDIC1_Xout_s6_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s6_q <= CORDIC1_Xout_s6_o(13 downto 0);

    -- CORDIC1_ShiftX_s7(BITSELECT,498)@5
    CORDIC1_ShiftX_s7_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s6_q(13 downto 7));

    -- CORDIC1_CmpPGeZero_s6(LOGICAL,480)@5
    CORDIC1_CmpPGeZero_s6_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s5_q(13 downto 13)));

    -- CORDIC1_ShiftX_s6(BITSELECT,485)@5
    CORDIC1_ShiftX_s6_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s5_q(13 downto 6));

    -- CORDIC1_Yout_s6(ADDSUB,488)@5
    CORDIC1_Yout_s6_s <= CORDIC1_CmpPGeZero_s6_q;
    CORDIC1_Yout_s6_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s5_q(13)) & CORDIC1_Yout_s5_q));
    CORDIC1_Yout_s6_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 8 => CORDIC1_ShiftX_s6_b(7)) & CORDIC1_ShiftX_s6_b));
    CORDIC1_Yout_s6_combproc: PROCESS (CORDIC1_Yout_s6_a, CORDIC1_Yout_s6_b, CORDIC1_Yout_s6_s)
    BEGIN
        IF (CORDIC1_Yout_s6_s = "1") THEN
            CORDIC1_Yout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s6_a) + SIGNED(CORDIC1_Yout_s6_b));
        ELSE
            CORDIC1_Yout_s6_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s6_a) - SIGNED(CORDIC1_Yout_s6_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s6_q <= CORDIC1_Yout_s6_o(13 downto 0);

    -- CORDIC1_Yout_s7(ADDSUB,501)@5
    CORDIC1_Yout_s7_s <= CORDIC1_CmpPGeZero_s7_q;
    CORDIC1_Yout_s7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s6_q(13)) & CORDIC1_Yout_s6_q));
    CORDIC1_Yout_s7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 7 => CORDIC1_ShiftX_s7_b(6)) & CORDIC1_ShiftX_s7_b));
    CORDIC1_Yout_s7_combproc: PROCESS (CORDIC1_Yout_s7_a, CORDIC1_Yout_s7_b, CORDIC1_Yout_s7_s)
    BEGIN
        IF (CORDIC1_Yout_s7_s = "1") THEN
            CORDIC1_Yout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s7_a) + SIGNED(CORDIC1_Yout_s7_b));
        ELSE
            CORDIC1_Yout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s7_a) - SIGNED(CORDIC1_Yout_s7_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s7_q <= CORDIC1_Yout_s7_o(13 downto 0);

    -- CORDIC1_ShiftY_s8(BITSELECT,512)@5
    CORDIC1_ShiftY_s8_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s7_q(13 downto 8));

    -- CORDIC1_ShiftY_s7(BITSELECT,499)@5
    CORDIC1_ShiftY_s7_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s6_q(13 downto 7));

    -- CORDIC1_Xout_s7(ADDSUB,500)@5
    CORDIC1_Xout_s7_s <= CORDIC1_CmpPLtZero_s7_q;
    CORDIC1_Xout_s7_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s6_q(13)) & CORDIC1_Xout_s6_q));
    CORDIC1_Xout_s7_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 7 => CORDIC1_ShiftY_s7_b(6)) & CORDIC1_ShiftY_s7_b));
    CORDIC1_Xout_s7_combproc: PROCESS (CORDIC1_Xout_s7_a, CORDIC1_Xout_s7_b, CORDIC1_Xout_s7_s)
    BEGIN
        IF (CORDIC1_Xout_s7_s = "1") THEN
            CORDIC1_Xout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s7_a) + SIGNED(CORDIC1_Xout_s7_b));
        ELSE
            CORDIC1_Xout_s7_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s7_a) - SIGNED(CORDIC1_Xout_s7_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s7_q <= CORDIC1_Xout_s7_o(13 downto 0);

    -- CORDIC1_Xout_s8(ADDSUB,513)@5
    CORDIC1_Xout_s8_s <= CORDIC1_CmpPLtZero_s8_q;
    CORDIC1_Xout_s8_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s7_q(13)) & CORDIC1_Xout_s7_q));
    CORDIC1_Xout_s8_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 6 => CORDIC1_ShiftY_s8_b(5)) & CORDIC1_ShiftY_s8_b));
    CORDIC1_Xout_s8_combproc: PROCESS (CORDIC1_Xout_s8_a, CORDIC1_Xout_s8_b, CORDIC1_Xout_s8_s)
    BEGIN
        IF (CORDIC1_Xout_s8_s = "1") THEN
            CORDIC1_Xout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s8_a) + SIGNED(CORDIC1_Xout_s8_b));
        ELSE
            CORDIC1_Xout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s8_a) - SIGNED(CORDIC1_Xout_s8_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s8_q <= CORDIC1_Xout_s8_o(13 downto 0);

    -- CORDIC1_ShiftX_s9(BITSELECT,524)@5
    CORDIC1_ShiftX_s9_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s8_q(13 downto 9));

    -- CORDIC1_CmpPGeZero_s8(LOGICAL,506)@5
    CORDIC1_CmpPGeZero_s8_q <= STD_LOGIC_VECTOR(not (CORDIC1_Pout_s7_q(13 downto 13)));

    -- CORDIC1_ShiftX_s8(BITSELECT,511)@5
    CORDIC1_ShiftX_s8_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s7_q(13 downto 8));

    -- CORDIC1_Yout_s8(ADDSUB,514)@5
    CORDIC1_Yout_s8_s <= CORDIC1_CmpPGeZero_s8_q;
    CORDIC1_Yout_s8_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s7_q(13)) & CORDIC1_Yout_s7_q));
    CORDIC1_Yout_s8_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 6 => CORDIC1_ShiftX_s8_b(5)) & CORDIC1_ShiftX_s8_b));
    CORDIC1_Yout_s8_combproc: PROCESS (CORDIC1_Yout_s8_a, CORDIC1_Yout_s8_b, CORDIC1_Yout_s8_s)
    BEGIN
        IF (CORDIC1_Yout_s8_s = "1") THEN
            CORDIC1_Yout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s8_a) + SIGNED(CORDIC1_Yout_s8_b));
        ELSE
            CORDIC1_Yout_s8_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s8_a) - SIGNED(CORDIC1_Yout_s8_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s8_q <= CORDIC1_Yout_s8_o(13 downto 0);

    -- CORDIC1_Yout_s9(ADDSUB,527)@5
    CORDIC1_Yout_s9_s <= CORDIC1_CmpPGeZero_s9_q;
    CORDIC1_Yout_s9_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s8_q(13)) & CORDIC1_Yout_s8_q));
    CORDIC1_Yout_s9_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 5 => CORDIC1_ShiftX_s9_b(4)) & CORDIC1_ShiftX_s9_b));
    CORDIC1_Yout_s9_combproc: PROCESS (CORDIC1_Yout_s9_a, CORDIC1_Yout_s9_b, CORDIC1_Yout_s9_s)
    BEGIN
        IF (CORDIC1_Yout_s9_s = "1") THEN
            CORDIC1_Yout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s9_a) + SIGNED(CORDIC1_Yout_s9_b));
        ELSE
            CORDIC1_Yout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s9_a) - SIGNED(CORDIC1_Yout_s9_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s9_q <= CORDIC1_Yout_s9_o(13 downto 0);

    -- CORDIC1_ShiftY_s10(BITSELECT,538)@5
    CORDIC1_ShiftY_s10_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s9_q(13 downto 10));

    -- CORDIC1_ShiftY_s9(BITSELECT,525)@5
    CORDIC1_ShiftY_s9_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s8_q(13 downto 9));

    -- CORDIC1_Xout_s9(ADDSUB,526)@5
    CORDIC1_Xout_s9_s <= CORDIC1_CmpPLtZero_s9_q;
    CORDIC1_Xout_s9_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s8_q(13)) & CORDIC1_Xout_s8_q));
    CORDIC1_Xout_s9_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 5 => CORDIC1_ShiftY_s9_b(4)) & CORDIC1_ShiftY_s9_b));
    CORDIC1_Xout_s9_combproc: PROCESS (CORDIC1_Xout_s9_a, CORDIC1_Xout_s9_b, CORDIC1_Xout_s9_s)
    BEGIN
        IF (CORDIC1_Xout_s9_s = "1") THEN
            CORDIC1_Xout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s9_a) + SIGNED(CORDIC1_Xout_s9_b));
        ELSE
            CORDIC1_Xout_s9_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s9_a) - SIGNED(CORDIC1_Xout_s9_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s9_q <= CORDIC1_Xout_s9_o(13 downto 0);

    -- CORDIC1_Xout_s10(ADDSUB,539)@5
    CORDIC1_Xout_s10_s <= CORDIC1_CmpPLtZero_s10_q;
    CORDIC1_Xout_s10_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s9_q(13)) & CORDIC1_Xout_s9_q));
    CORDIC1_Xout_s10_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 4 => CORDIC1_ShiftY_s10_b(3)) & CORDIC1_ShiftY_s10_b));
    CORDIC1_Xout_s10_combproc: PROCESS (CORDIC1_Xout_s10_a, CORDIC1_Xout_s10_b, CORDIC1_Xout_s10_s)
    BEGIN
        IF (CORDIC1_Xout_s10_s = "1") THEN
            CORDIC1_Xout_s10_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s10_a) + SIGNED(CORDIC1_Xout_s10_b));
        ELSE
            CORDIC1_Xout_s10_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s10_a) - SIGNED(CORDIC1_Xout_s10_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s10_q <= CORDIC1_Xout_s10_o(13 downto 0);

    -- CORDIC1_ShiftX_s11(BITSELECT,550)@5
    CORDIC1_ShiftX_s11_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s10_q(13 downto 11));

    -- CORDIC1_ShiftX_s10(BITSELECT,537)@5
    CORDIC1_ShiftX_s10_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s9_q(13 downto 10));

    -- CORDIC1_Yout_s10(ADDSUB,540)@5
    CORDIC1_Yout_s10_s <= CORDIC1_CmpPGeZero_s10_q;
    CORDIC1_Yout_s10_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s9_q(13)) & CORDIC1_Yout_s9_q));
    CORDIC1_Yout_s10_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 4 => CORDIC1_ShiftX_s10_b(3)) & CORDIC1_ShiftX_s10_b));
    CORDIC1_Yout_s10_combproc: PROCESS (CORDIC1_Yout_s10_a, CORDIC1_Yout_s10_b, CORDIC1_Yout_s10_s)
    BEGIN
        IF (CORDIC1_Yout_s10_s = "1") THEN
            CORDIC1_Yout_s10_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s10_a) + SIGNED(CORDIC1_Yout_s10_b));
        ELSE
            CORDIC1_Yout_s10_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s10_a) - SIGNED(CORDIC1_Yout_s10_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s10_q <= CORDIC1_Yout_s10_o(13 downto 0);

    -- CORDIC1_Yout_s11(ADDSUB,553)@5
    CORDIC1_Yout_s11_s <= CORDIC1_CmpPGeZero_s10_q;
    CORDIC1_Yout_s11_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s10_q(13)) & CORDIC1_Yout_s10_q));
    CORDIC1_Yout_s11_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 3 => CORDIC1_ShiftX_s11_b(2)) & CORDIC1_ShiftX_s11_b));
    CORDIC1_Yout_s11_combproc: PROCESS (CORDIC1_Yout_s11_a, CORDIC1_Yout_s11_b, CORDIC1_Yout_s11_s)
    BEGIN
        IF (CORDIC1_Yout_s11_s = "1") THEN
            CORDIC1_Yout_s11_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s11_a) + SIGNED(CORDIC1_Yout_s11_b));
        ELSE
            CORDIC1_Yout_s11_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s11_a) - SIGNED(CORDIC1_Yout_s11_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s11_q <= CORDIC1_Yout_s11_o(13 downto 0);

    -- CORDIC1_ShiftY_s12(BITSELECT,564)@5
    CORDIC1_ShiftY_s12_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s11_q(13 downto 12));

    -- CORDIC1_ShiftY_s11(BITSELECT,551)@5
    CORDIC1_ShiftY_s11_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s10_q(13 downto 11));

    -- CORDIC1_Xout_s11(ADDSUB,552)@5
    CORDIC1_Xout_s11_s <= CORDIC1_CmpPLtZero_s10_q;
    CORDIC1_Xout_s11_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s10_q(13)) & CORDIC1_Xout_s10_q));
    CORDIC1_Xout_s11_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 3 => CORDIC1_ShiftY_s11_b(2)) & CORDIC1_ShiftY_s11_b));
    CORDIC1_Xout_s11_combproc: PROCESS (CORDIC1_Xout_s11_a, CORDIC1_Xout_s11_b, CORDIC1_Xout_s11_s)
    BEGIN
        IF (CORDIC1_Xout_s11_s = "1") THEN
            CORDIC1_Xout_s11_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s11_a) + SIGNED(CORDIC1_Xout_s11_b));
        ELSE
            CORDIC1_Xout_s11_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s11_a) - SIGNED(CORDIC1_Xout_s11_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s11_q <= CORDIC1_Xout_s11_o(13 downto 0);

    -- CORDIC1_Xout_s12(ADDSUB,565)@5
    CORDIC1_Xout_s12_s <= CORDIC1_CmpPLtZero_s10_q;
    CORDIC1_Xout_s12_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s11_q(13)) & CORDIC1_Xout_s11_q));
    CORDIC1_Xout_s12_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 2 => CORDIC1_ShiftY_s12_b(1)) & CORDIC1_ShiftY_s12_b));
    CORDIC1_Xout_s12_combproc: PROCESS (CORDIC1_Xout_s12_a, CORDIC1_Xout_s12_b, CORDIC1_Xout_s12_s)
    BEGIN
        IF (CORDIC1_Xout_s12_s = "1") THEN
            CORDIC1_Xout_s12_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s12_a) + SIGNED(CORDIC1_Xout_s12_b));
        ELSE
            CORDIC1_Xout_s12_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s12_a) - SIGNED(CORDIC1_Xout_s12_b));
        END IF;
    END PROCESS;
    CORDIC1_Xout_s12_q <= CORDIC1_Xout_s12_o(13 downto 0);

    -- CORDIC1_ShiftX_s13(BITSELECT,576)@5
    CORDIC1_ShiftX_s13_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s12_q(13 downto 13));

    -- CORDIC1_ShiftX_s12(BITSELECT,563)@5
    CORDIC1_ShiftX_s12_b <= STD_LOGIC_VECTOR(CORDIC1_Xout_s11_q(13 downto 12));

    -- CORDIC1_Yout_s12(ADDSUB,566)@5
    CORDIC1_Yout_s12_s <= CORDIC1_CmpPGeZero_s10_q;
    CORDIC1_Yout_s12_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s11_q(13)) & CORDIC1_Yout_s11_q));
    CORDIC1_Yout_s12_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 2 => CORDIC1_ShiftX_s12_b(1)) & CORDIC1_ShiftX_s12_b));
    CORDIC1_Yout_s12_combproc: PROCESS (CORDIC1_Yout_s12_a, CORDIC1_Yout_s12_b, CORDIC1_Yout_s12_s)
    BEGIN
        IF (CORDIC1_Yout_s12_s = "1") THEN
            CORDIC1_Yout_s12_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s12_a) + SIGNED(CORDIC1_Yout_s12_b));
        ELSE
            CORDIC1_Yout_s12_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s12_a) - SIGNED(CORDIC1_Yout_s12_b));
        END IF;
    END PROCESS;
    CORDIC1_Yout_s12_q <= CORDIC1_Yout_s12_o(13 downto 0);

    -- CORDIC1_Yout_s13(ADDSUB,579)@5 + 1
    CORDIC1_Yout_s13_s <= CORDIC1_CmpPGeZero_s10_q;
    CORDIC1_Yout_s13_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s12_q(13)) & CORDIC1_Yout_s12_q));
    CORDIC1_Yout_s13_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 1 => CORDIC1_ShiftX_s13_b(0)) & CORDIC1_ShiftX_s13_b));
    CORDIC1_Yout_s13_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            CORDIC1_Yout_s13_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (CORDIC1_Yout_s13_s = "1") THEN
                CORDIC1_Yout_s13_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s13_a) + SIGNED(CORDIC1_Yout_s13_b));
            ELSE
                CORDIC1_Yout_s13_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Yout_s13_a) - SIGNED(CORDIC1_Yout_s13_b));
            END IF;
        END IF;
    END PROCESS;
    CORDIC1_Yout_s13_q <= CORDIC1_Yout_s13_o(13 downto 0);

    -- CORDIC1_ConstZero_Last(CONSTANT,581)
    CORDIC1_ConstZero_Last_q <= "00000000000000";

    -- CORDIC1_ZeroAddSubY_Last(ADDSUB,585)@6 + 1
    CORDIC1_ZeroAddSubY_Last_s <= redist1_CORDIC1_AorB_00_q_2_q;
    CORDIC1_ZeroAddSubY_Last_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_ConstZero_Last_q(13)) & CORDIC1_ConstZero_Last_q));
    CORDIC1_ZeroAddSubY_Last_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Yout_s13_q(13)) & CORDIC1_Yout_s13_q));
    CORDIC1_ZeroAddSubY_Last_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            CORDIC1_ZeroAddSubY_Last_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (CORDIC1_ZeroAddSubY_Last_s = "1") THEN
                CORDIC1_ZeroAddSubY_Last_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_ZeroAddSubY_Last_a) + SIGNED(CORDIC1_ZeroAddSubY_Last_b));
            ELSE
                CORDIC1_ZeroAddSubY_Last_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_ZeroAddSubY_Last_a) - SIGNED(CORDIC1_ZeroAddSubY_Last_b));
            END IF;
        END IF;
    END PROCESS;
    CORDIC1_ZeroAddSubY_Last_q <= CORDIC1_ZeroAddSubY_Last_o(13 downto 0);

    -- CORDIC1_ShiftY_s13(BITSELECT,577)@5
    CORDIC1_ShiftY_s13_b <= STD_LOGIC_VECTOR(CORDIC1_Yout_s12_q(13 downto 13));

    -- CORDIC1_Xout_s13(ADDSUB,578)@5 + 1
    CORDIC1_Xout_s13_s <= CORDIC1_CmpPLtZero_s10_q;
    CORDIC1_Xout_s13_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s12_q(13)) & CORDIC1_Xout_s12_q));
    CORDIC1_Xout_s13_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 1 => CORDIC1_ShiftY_s13_b(0)) & CORDIC1_ShiftY_s13_b));
    CORDIC1_Xout_s13_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            CORDIC1_Xout_s13_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (CORDIC1_Xout_s13_s = "1") THEN
                CORDIC1_Xout_s13_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s13_a) + SIGNED(CORDIC1_Xout_s13_b));
            ELSE
                CORDIC1_Xout_s13_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_Xout_s13_a) - SIGNED(CORDIC1_Xout_s13_b));
            END IF;
        END IF;
    END PROCESS;
    CORDIC1_Xout_s13_q <= CORDIC1_Xout_s13_o(13 downto 0);

    -- CORDIC1_ZeroAddSubX_Last(ADDSUB,584)@6 + 1
    CORDIC1_ZeroAddSubX_Last_s <= redist1_CORDIC1_AorB_00_q_2_q;
    CORDIC1_ZeroAddSubX_Last_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_ConstZero_Last_q(13)) & CORDIC1_ConstZero_Last_q));
    CORDIC1_ZeroAddSubX_Last_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => CORDIC1_Xout_s13_q(13)) & CORDIC1_Xout_s13_q));
    CORDIC1_ZeroAddSubX_Last_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            CORDIC1_ZeroAddSubX_Last_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (CORDIC1_ZeroAddSubX_Last_s = "1") THEN
                CORDIC1_ZeroAddSubX_Last_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_ZeroAddSubX_Last_a) + SIGNED(CORDIC1_ZeroAddSubX_Last_b));
            ELSE
                CORDIC1_ZeroAddSubX_Last_o <= STD_LOGIC_VECTOR(SIGNED(CORDIC1_ZeroAddSubX_Last_a) - SIGNED(CORDIC1_ZeroAddSubX_Last_b));
            END IF;
        END IF;
    END PROCESS;
    CORDIC1_ZeroAddSubX_Last_q <= CORDIC1_ZeroAddSubX_Last_o(13 downto 0);

    -- redist3_ChannelIn_in_4_dc_7_notEnable(LOGICAL,701)
    redist3_ChannelIn_in_4_dc_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist3_ChannelIn_in_4_dc_7_nor(LOGICAL,702)
    redist3_ChannelIn_in_4_dc_7_nor_q <= not (redist3_ChannelIn_in_4_dc_7_notEnable_q or redist3_ChannelIn_in_4_dc_7_sticky_ena_q);

    -- redist3_ChannelIn_in_4_dc_7_mem_last(CONSTANT,698)
    redist3_ChannelIn_in_4_dc_7_mem_last_q <= "011";

    -- redist3_ChannelIn_in_4_dc_7_cmp(LOGICAL,699)
    redist3_ChannelIn_in_4_dc_7_cmp_q <= "1" WHEN redist3_ChannelIn_in_4_dc_7_mem_last_q = redist3_ChannelIn_in_4_dc_7_rdcnt_q ELSE "0";

    -- redist3_ChannelIn_in_4_dc_7_cmpReg(REG,700)
    redist3_ChannelIn_in_4_dc_7_cmpReg_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist3_ChannelIn_in_4_dc_7_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist3_ChannelIn_in_4_dc_7_cmpReg_q <= STD_LOGIC_VECTOR(redist3_ChannelIn_in_4_dc_7_cmp_q);
        END IF;
    END PROCESS;

    -- redist3_ChannelIn_in_4_dc_7_sticky_ena(REG,703)
    redist3_ChannelIn_in_4_dc_7_sticky_ena_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist3_ChannelIn_in_4_dc_7_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist3_ChannelIn_in_4_dc_7_nor_q = "1") THEN
                redist3_ChannelIn_in_4_dc_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist3_ChannelIn_in_4_dc_7_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist3_ChannelIn_in_4_dc_7_enaAnd(LOGICAL,704)
    redist3_ChannelIn_in_4_dc_7_enaAnd_q <= redist3_ChannelIn_in_4_dc_7_sticky_ena_q and VCC_q;

    -- redist3_ChannelIn_in_4_dc_7_rdcnt(COUNTER,696)
    -- low=0, high=4, step=1, init=0
    redist3_ChannelIn_in_4_dc_7_rdcnt_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist3_ChannelIn_in_4_dc_7_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist3_ChannelIn_in_4_dc_7_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist3_ChannelIn_in_4_dc_7_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                redist3_ChannelIn_in_4_dc_7_rdcnt_eq <= '1';
            ELSE
                redist3_ChannelIn_in_4_dc_7_rdcnt_eq <= '0';
            END IF;
            IF (redist3_ChannelIn_in_4_dc_7_rdcnt_eq = '1') THEN
                redist3_ChannelIn_in_4_dc_7_rdcnt_i <= redist3_ChannelIn_in_4_dc_7_rdcnt_i + 4;
            ELSE
                redist3_ChannelIn_in_4_dc_7_rdcnt_i <= redist3_ChannelIn_in_4_dc_7_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist3_ChannelIn_in_4_dc_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist3_ChannelIn_in_4_dc_7_rdcnt_i, 3)));

    -- redist3_ChannelIn_in_4_dc_7_wraddr(REG,697)
    redist3_ChannelIn_in_4_dc_7_wraddr_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist3_ChannelIn_in_4_dc_7_wraddr_q <= "100";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist3_ChannelIn_in_4_dc_7_wraddr_q <= STD_LOGIC_VECTOR(redist3_ChannelIn_in_4_dc_7_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist3_ChannelIn_in_4_dc_7_mem(DUALMEM,695)
    redist3_ChannelIn_in_4_dc_7_mem_ia <= STD_LOGIC_VECTOR(in_4_dc);
    redist3_ChannelIn_in_4_dc_7_mem_aa <= redist3_ChannelIn_in_4_dc_7_wraddr_q;
    redist3_ChannelIn_in_4_dc_7_mem_ab <= redist3_ChannelIn_in_4_dc_7_rdcnt_q;
    redist3_ChannelIn_in_4_dc_7_mem_reset0 <= not (areset_n);
    redist3_ChannelIn_in_4_dc_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 5,
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
        clocken1 => redist3_ChannelIn_in_4_dc_7_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist3_ChannelIn_in_4_dc_7_mem_reset0,
        clock1 => clk,
        address_a => redist3_ChannelIn_in_4_dc_7_mem_aa,
        data_a => redist3_ChannelIn_in_4_dc_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist3_ChannelIn_in_4_dc_7_mem_ab,
        q_b => redist3_ChannelIn_in_4_dc_7_mem_iq
    );
    redist3_ChannelIn_in_4_dc_7_mem_q <= redist3_ChannelIn_in_4_dc_7_mem_iq(7 downto 0);

    -- redist3_ChannelIn_in_4_dc_7_outputreg(DELAY,694)
    redist3_ChannelIn_in_4_dc_7_outputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist3_ChannelIn_in_4_dc_7_mem_q, xout => redist3_ChannelIn_in_4_dc_7_outputreg_q, clk => clk, aclr => areset_n );

    -- redist2_ChannelIn_in_3_dv_7(DELAY,690)
    redist2_ChannelIn_in_3_dv_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_3_dv, xout => redist2_ChannelIn_in_3_dv_7_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,6)@7 + 1
    out_3_Qv <= redist2_ChannelIn_in_3_dv_7_q;
    out_4_Qc <= redist3_ChannelIn_in_4_dc_7_outputreg_q;
    out_1_I_Out <= CORDIC1_ZeroAddSubX_Last_q;
    out_2_Q_Out <= CORDIC1_ZeroAddSubY_Last_q;

END normal;
