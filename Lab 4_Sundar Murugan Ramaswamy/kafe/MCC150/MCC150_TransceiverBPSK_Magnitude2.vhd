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

-- VHDL created from MCC150_TransceiverBPSK_Magnitude2
-- VHDL created on Wed May 26 13:29:52 2021


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
entity MCC150_TransceiverBPSK_Magnitude2 is
    port (
        in_3_dv : in std_logic_vector(0 downto 0);  -- ufix1
        in_4_dc : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_I : in std_logic_vector(11 downto 0);  -- sfix12
        in_2_Q : in std_logic_vector(11 downto 0);  -- sfix12
        out_1_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_Mag : out std_logic_vector(11 downto 0);  -- ufix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_Magnitude2;

architecture normal of MCC150_TransceiverBPSK_Magnitude2 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Convert_sel_x_b : STD_LOGIC_VECTOR (11 downto 0);
    signal inputSign_uid11_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cst0ForNegInput_uid12_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal xFxpPosInput_uid13_Sqrt_in : STD_LOGIC_VECTOR (23 downto 0);
    signal xFxpPosInput_uid13_Sqrt_b : STD_LOGIC_VECTOR (23 downto 0);
    signal xFxp_uid14_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal xFxp_uid14_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal shiftConstant_uid16_Sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal inExponent_uid17_Sqrt_a : STD_LOGIC_VECTOR (6 downto 0);
    signal inExponent_uid17_Sqrt_b : STD_LOGIC_VECTOR (6 downto 0);
    signal inExponent_uid17_Sqrt_o : STD_LOGIC_VECTOR (6 downto 0);
    signal inExponent_uid17_Sqrt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal parityOddOriginal_uid20_Sqrt_in : STD_LOGIC_VECTOR (0 downto 0);
    signal parityOddOriginal_uid20_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal parityOddOriginalInv_uid21_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal outExponentOdd_uid25_Sqrt_a : STD_LOGIC_VECTOR (8 downto 0);
    signal outExponentOdd_uid25_Sqrt_b : STD_LOGIC_VECTOR (8 downto 0);
    signal outExponentOdd_uid25_Sqrt_o : STD_LOGIC_VECTOR (8 downto 0);
    signal outExponentOdd_uid25_Sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal outExponentOdd_uid26_Sqrt_in : STD_LOGIC_VECTOR (6 downto 0);
    signal outExponentOdd_uid26_Sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal outExponentEven_uid27_Sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal outputExponent_uid28_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal outputExponent_uid28_Sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftOutVal_uid30_Sqrt_a : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftOutVal_uid30_Sqrt_b : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftOutVal_uid30_Sqrt_o : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftOutVal_uid30_Sqrt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal x1_uid33_Sqrt_b : STD_LOGIC_VECTOR (12 downto 0);
    signal x_mp1_uid34_Sqrt_in : STD_LOGIC_VECTOR (10 downto 0);
    signal x_mp1_uid34_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal neg_x_mp1_uid35_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal x2_uid36_Sqrt_in : STD_LOGIC_VECTOR (9 downto 0);
    signal x2_uid36_Sqrt_b : STD_LOGIC_VECTOR (9 downto 0);
    signal x_prime_tmp_uid37_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal addrTable_uid39_Sqrt_in : STD_LOGIC_VECTOR (11 downto 0);
    signal addrTable_uid39_Sqrt_b : STD_LOGIC_VECTOR (11 downto 0);
    signal os_uid46_Sqrt_q : STD_LOGIC_VECTOR (25 downto 0);
    signal result_uid49_Sqrt_in : STD_LOGIC_VECTOR (49 downto 0);
    signal result_uid49_Sqrt_b : STD_LOGIC_VECTOR (25 downto 0);
    signal finalMultLSBRange_uid51_Sqrt_b : STD_LOGIC_VECTOR (24 downto 0);
    signal invNegShiftEven_uid52_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftEven_uid53_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftOdd_uid54_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftOdd_uid55_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal EvenBranchAndNegUpdate_uid57_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal OddBranchAndNegUpdate_uid58_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftUpdateValue_uid59_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal negShiftEvenParityOdd_uid60_Sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal finalMultBottomBits_uid61_Sqrt_in : STD_LOGIC_VECTOR (24 downto 0);
    signal finalMultBottomBits_uid61_Sqrt_b : STD_LOGIC_VECTOR (24 downto 0);
    signal resultBottomBits_uid62_Sqrt_in : STD_LOGIC_VECTOR (24 downto 0);
    signal resultBottomBits_uid62_Sqrt_b : STD_LOGIC_VECTOR (24 downto 0);
    signal resultUpperRange_uid64_Sqrt_b : STD_LOGIC_VECTOR (24 downto 0);
    signal shifterInData_uid65_Sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal shifterInData_uid65_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal shiftOutValUpdated_uid66_Sqrt_a : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftOutValUpdated_uid66_Sqrt_b : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftOutValUpdated_uid66_Sqrt_o : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftOutValUpdated_uid66_Sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal sat_uid67_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFinalPostRnd_uid73_Sqrt_a : STD_LOGIC_VECTOR (25 downto 0);
    signal resultFinalPostRnd_uid73_Sqrt_b : STD_LOGIC_VECTOR (25 downto 0);
    signal resultFinalPostRnd_uid73_Sqrt_o : STD_LOGIC_VECTOR (25 downto 0);
    signal resultFinalPostRnd_uid73_Sqrt_q : STD_LOGIC_VECTOR (25 downto 0);
    signal satOrOvfPostRnd_uid76_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFinalPostOvf_uid77_Sqrt_b : STD_LOGIC_VECTOR (23 downto 0);
    signal resultFinalPostOvf_uid77_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal cstW_uid78_Sqrt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal inputAllZeros_uid79_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal inputNotAllZeros_uid80_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal resultFinal_uid81_Sqrt_b : STD_LOGIC_VECTOR (23 downto 0);
    signal resultFinal_uid81_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal resultFinalPostSignedOutput_uid82_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal zs_uid84_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid85_leadingZeros_uid15_Sqrt_b : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid86_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid87_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vStage_uid88_leadingZeros_uid15_Sqrt_in : STD_LOGIC_VECTOR (7 downto 0);
    signal vStage_uid88_leadingZeros_uid15_Sqrt_b : STD_LOGIC_VECTOR (7 downto 0);
    signal cStage_uid89_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid91_leadingZeros_uid15_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid92_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid94_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_leadingZeros_uid15_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid98_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid100_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_leadingZeros_uid15_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid104_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid106_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_leadingZeros_uid15_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid111_leadingZeros_uid15_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid112_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid113_leadingZeros_uid15_Sqrt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal xv0_uid115_finalMult_uid50_Sqrt_in : STD_LOGIC_VECTOR (5 downto 0);
    signal xv0_uid115_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv1_uid116_finalMult_uid50_Sqrt_in : STD_LOGIC_VECTOR (11 downto 0);
    signal xv1_uid116_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv2_uid117_finalMult_uid50_Sqrt_in : STD_LOGIC_VECTOR (17 downto 0);
    signal xv2_uid117_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv3_uid118_finalMult_uid50_Sqrt_in : STD_LOGIC_VECTOR (23 downto 0);
    signal xv3_uid118_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv4_uid119_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal p4_uid120_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (29 downto 0);
    signal p3_uid121_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (27 downto 0);
    signal p2_uid122_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (21 downto 0);
    signal p1_uid123_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (15 downto 0);
    signal p0_uid124_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (9 downto 0);
    signal lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_a : STD_LOGIC_VECTOR (30 downto 0);
    signal lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (30 downto 0);
    signal lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_o : STD_LOGIC_VECTOR (30 downto 0);
    signal lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (30 downto 0);
    signal lev1_a0_uid128_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (31 downto 0);
    signal lev1_a1_uid129_finalMult_uid50_Sqrt_a : STD_LOGIC_VECTOR (22 downto 0);
    signal lev1_a1_uid129_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (22 downto 0);
    signal lev1_a1_uid129_finalMult_uid50_Sqrt_o : STD_LOGIC_VECTOR (22 downto 0);
    signal lev1_a1_uid129_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (22 downto 0);
    signal lev2_a0_uid130_finalMult_uid50_Sqrt_a : STD_LOGIC_VECTOR (32 downto 0);
    signal lev2_a0_uid130_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (32 downto 0);
    signal lev2_a0_uid130_finalMult_uid50_Sqrt_o : STD_LOGIC_VECTOR (32 downto 0);
    signal lev2_a0_uid130_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (32 downto 0);
    signal lev3_a0_uid131_finalMult_uid50_Sqrt_a : STD_LOGIC_VECTOR (33 downto 0);
    signal lev3_a0_uid131_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (33 downto 0);
    signal lev3_a0_uid131_finalMult_uid50_Sqrt_o : STD_LOGIC_VECTOR (33 downto 0);
    signal lev3_a0_uid131_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (33 downto 0);
    signal maxValInOutFormat_uid132_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (25 downto 0);
    signal minValueInFormat_uid133_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (25 downto 0);
    signal updatedX_uid135_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (29 downto 0);
    signal ovf_uid134_finalMult_uid50_Sqrt_a : STD_LOGIC_VECTOR (35 downto 0);
    signal ovf_uid134_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (35 downto 0);
    signal ovf_uid134_finalMult_uid50_Sqrt_o : STD_LOGIC_VECTOR (35 downto 0);
    signal ovf_uid134_finalMult_uid50_Sqrt_c : STD_LOGIC_VECTOR (0 downto 0);
    signal updatedY_uid138_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (29 downto 0);
    signal udf_uid137_finalMult_uid50_Sqrt_a : STD_LOGIC_VECTOR (35 downto 0);
    signal udf_uid137_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (35 downto 0);
    signal udf_uid137_finalMult_uid50_Sqrt_o : STD_LOGIC_VECTOR (35 downto 0);
    signal udf_uid137_finalMult_uid50_Sqrt_c : STD_LOGIC_VECTOR (0 downto 0);
    signal ovfudfcond_uid140_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sR_uid141_finalMult_uid50_Sqrt_in : STD_LOGIC_VECTOR (29 downto 0);
    signal sR_uid141_finalMult_uid50_Sqrt_b : STD_LOGIC_VECTOR (25 downto 0);
    signal sRA0_uid142_finalMult_uid50_Sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal sRA0_uid142_finalMult_uid50_Sqrt_q : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx1_uid175_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx2_uid178_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStageSel4Dto3_uid180_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx1_uid184_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage1Idx2_uid187_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx3Pad6_uid188_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (17 downto 0);
    signal leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (17 downto 0);
    signal leftShiftStage1Idx3_uid190_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (22 downto 0);
    signal leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (22 downto 0);
    signal leftShiftStage2Idx1_uid195_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt_in : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q : STD_LOGIC_VECTOR (23 downto 0);
    signal cPrimeTableOut_uid40_Sqrt_lutmem_reset0 : std_logic;
    signal cPrimeTableOut_uid40_Sqrt_lutmem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid40_Sqrt_lutmem_aa : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid40_Sqrt_lutmem_ab : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid40_Sqrt_lutmem_ir : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid40_Sqrt_lutmem_r : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid41_Sqrt_lutmem_reset0 : std_logic;
    signal cPrimeTableOut_uid41_Sqrt_lutmem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid41_Sqrt_lutmem_aa : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid41_Sqrt_lutmem_ab : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid41_Sqrt_lutmem_ir : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid41_Sqrt_lutmem_r : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid42_Sqrt_lutmem_reset0 : std_logic;
    signal cPrimeTableOut_uid42_Sqrt_lutmem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid42_Sqrt_lutmem_aa : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid42_Sqrt_lutmem_ab : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid42_Sqrt_lutmem_ir : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid42_Sqrt_lutmem_r : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid43_Sqrt_lutmem_reset0 : std_logic;
    signal cPrimeTableOut_uid43_Sqrt_lutmem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid43_Sqrt_lutmem_aa : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid43_Sqrt_lutmem_ab : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid43_Sqrt_lutmem_ir : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid43_Sqrt_lutmem_r : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid44_Sqrt_lutmem_reset0 : std_logic;
    signal cPrimeTableOut_uid44_Sqrt_lutmem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid44_Sqrt_lutmem_aa : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid44_Sqrt_lutmem_ab : STD_LOGIC_VECTOR (11 downto 0);
    signal cPrimeTableOut_uid44_Sqrt_lutmem_ir : STD_LOGIC_VECTOR (4 downto 0);
    signal cPrimeTableOut_uid44_Sqrt_lutmem_r : STD_LOGIC_VECTOR (4 downto 0);
    signal wIntCst_uid206_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_a : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_o : STD_LOGIC_VECTOR (9 downto 0);
    signal shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng8_uid208_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage0Idx1_uid210_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage0Idx2Rng16_uid211_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftStage0Idx2_uid213_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage0Idx3Rng24_uid214_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx3_uid216_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt_in : STD_LOGIC_VECTOR (4 downto 0);
    signal rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage1Idx1Rng2_uid219_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (22 downto 0);
    signal rightShiftStage1Idx1_uid221_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage1Idx2Rng4_uid222_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (20 downto 0);
    signal rightShiftStage1Idx2_uid224_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage1Idx3Rng6_uid225_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (18 downto 0);
    signal rightShiftStage1Idx3_uid227_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt_in : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStage2Idx1Rng1_uid230_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage2Idx1_uid232_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt_in : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal zeroOutCst_uid235_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal r_uid236_xRightShiftFinal_uid69_Sqrt_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid236_xRightShiftFinal_uid69_Sqrt_q : STD_LOGIC_VECTOR (24 downto 0);
    signal resultFull_uid48_Sqrt_cma_reset : std_logic;
    type resultFull_uid48_Sqrt_cma_a0type is array(NATURAL range <>) of UNSIGNED(24 downto 0);
    signal resultFull_uid48_Sqrt_cma_a0 : resultFull_uid48_Sqrt_cma_a0type(0 to 0);
    attribute preserve : boolean;
    attribute preserve of resultFull_uid48_Sqrt_cma_a0 : signal is true;
    attribute altera_attribute of resultFull_uid48_Sqrt_cma_a0 : signal is "-name allow_synch_ctrl_usage off";
    signal resultFull_uid48_Sqrt_cma_a1 : resultFull_uid48_Sqrt_cma_a0type(0 to 0);
    attribute preserve of resultFull_uid48_Sqrt_cma_a1 : signal is true;
    attribute altera_attribute of resultFull_uid48_Sqrt_cma_a1 : signal is "-name allow_synch_ctrl_usage off";
    type resultFull_uid48_Sqrt_cma_c0type is array(NATURAL range <>) of UNSIGNED(25 downto 0);
    signal resultFull_uid48_Sqrt_cma_c0 : resultFull_uid48_Sqrt_cma_c0type(0 to 0);
    attribute preserve of resultFull_uid48_Sqrt_cma_c0 : signal is true;
    attribute altera_attribute of resultFull_uid48_Sqrt_cma_c0 : signal is "-name allow_synch_ctrl_usage off";
    signal resultFull_uid48_Sqrt_cma_c1 : resultFull_uid48_Sqrt_cma_c0type(0 to 0);
    attribute preserve of resultFull_uid48_Sqrt_cma_c1 : signal is true;
    attribute altera_attribute of resultFull_uid48_Sqrt_cma_c1 : signal is "-name allow_synch_ctrl_usage off";
    type resultFull_uid48_Sqrt_cma_ptype is array(NATURAL range <>) of UNSIGNED(50 downto 0);
    signal resultFull_uid48_Sqrt_cma_p : resultFull_uid48_Sqrt_cma_ptype(0 to 0);
    signal resultFull_uid48_Sqrt_cma_u : resultFull_uid48_Sqrt_cma_ptype(0 to 0);
    signal resultFull_uid48_Sqrt_cma_w : resultFull_uid48_Sqrt_cma_ptype(0 to 0);
    signal resultFull_uid48_Sqrt_cma_x : resultFull_uid48_Sqrt_cma_ptype(0 to 0);
    signal resultFull_uid48_Sqrt_cma_y : resultFull_uid48_Sqrt_cma_ptype(0 to 0);
    signal resultFull_uid48_Sqrt_cma_s : resultFull_uid48_Sqrt_cma_ptype(0 to 0);
    signal resultFull_uid48_Sqrt_cma_qq : STD_LOGIC_VECTOR (50 downto 0);
    signal resultFull_uid48_Sqrt_cma_q : STD_LOGIC_VECTOR (50 downto 0);
    signal resultFull_uid48_Sqrt_cma_ena0 : std_logic;
    signal resultFull_uid48_Sqrt_cma_ena1 : std_logic;
    signal resultFull_uid48_Sqrt_cma_ena2 : std_logic;
    signal Mult_Add_Mult1_merged_cma_reset : std_logic;
    type Mult_Add_Mult1_merged_cma_a0type is array(NATURAL range <>) of SIGNED(11 downto 0);
    signal Mult_Add_Mult1_merged_cma_a0 : Mult_Add_Mult1_merged_cma_a0type(0 to 1);
    attribute preserve of Mult_Add_Mult1_merged_cma_a0 : signal is true;
    attribute altera_attribute of Mult_Add_Mult1_merged_cma_a0 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Add_Mult1_merged_cma_a1 : Mult_Add_Mult1_merged_cma_a0type(0 to 1);
    attribute preserve of Mult_Add_Mult1_merged_cma_a1 : signal is true;
    attribute altera_attribute of Mult_Add_Mult1_merged_cma_a1 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Add_Mult1_merged_cma_c0 : Mult_Add_Mult1_merged_cma_a0type(0 to 1);
    attribute preserve of Mult_Add_Mult1_merged_cma_c0 : signal is true;
    attribute altera_attribute of Mult_Add_Mult1_merged_cma_c0 : signal is "-name allow_synch_ctrl_usage off";
    signal Mult_Add_Mult1_merged_cma_c1 : Mult_Add_Mult1_merged_cma_a0type(0 to 1);
    attribute preserve of Mult_Add_Mult1_merged_cma_c1 : signal is true;
    attribute altera_attribute of Mult_Add_Mult1_merged_cma_c1 : signal is "-name allow_synch_ctrl_usage off";
    type Mult_Add_Mult1_merged_cma_ptype is array(NATURAL range <>) of SIGNED(23 downto 0);
    signal Mult_Add_Mult1_merged_cma_p : Mult_Add_Mult1_merged_cma_ptype(0 to 1);
    type Mult_Add_Mult1_merged_cma_utype is array(NATURAL range <>) of SIGNED(24 downto 0);
    signal Mult_Add_Mult1_merged_cma_u : Mult_Add_Mult1_merged_cma_utype(0 to 1);
    signal Mult_Add_Mult1_merged_cma_w : Mult_Add_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Add_Mult1_merged_cma_x : Mult_Add_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Add_Mult1_merged_cma_y : Mult_Add_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Add_Mult1_merged_cma_s : Mult_Add_Mult1_merged_cma_utype(0 to 0);
    signal Mult_Add_Mult1_merged_cma_qq : STD_LOGIC_VECTOR (24 downto 0);
    signal Mult_Add_Mult1_merged_cma_q : STD_LOGIC_VECTOR (24 downto 0);
    signal Mult_Add_Mult1_merged_cma_ena0 : std_logic;
    signal Mult_Add_Mult1_merged_cma_ena1 : std_logic;
    signal Mult_Add_Mult1_merged_cma_ena2 : std_logic;
    signal resultFinalPreSat_uid74_Sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (23 downto 0);
    signal resultFinalPreSat_uid74_Sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select_c : STD_LOGIC_VECTOR (26 downto 0);
    signal redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist1_x2_uid36_Sqrt_b_2_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist2_x_mp1_uid34_Sqrt_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_x1_uid33_Sqrt_b_2_q : STD_LOGIC_VECTOR (12 downto 0);
    signal redist4_ChannelIn_in_3_dv_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_Convert_sel_x_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_outputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_mem_reset0 : std_logic;
    signal redist5_ChannelIn_in_4_dc_9_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist5_ChannelIn_in_4_dc_9_rdcnt_i : signal is true;
    signal redist5_ChannelIn_in_4_dc_9_rdcnt_eq : std_logic;
    attribute preserve of redist5_ChannelIn_in_4_dc_9_rdcnt_eq : signal is true;
    signal redist5_ChannelIn_in_4_dc_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_ChannelIn_in_4_dc_9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of redist5_ChannelIn_in_4_dc_9_sticky_ena_q : signal is true;
    signal redist5_ChannelIn_in_4_dc_9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- cstW_uid78_Sqrt(CONSTANT,77)
    cstW_uid78_Sqrt_q <= "11000";

    -- zs_uid84_leadingZeros_uid15_Sqrt(CONSTANT,83)
    zs_uid84_leadingZeros_uid15_Sqrt_q <= "0000000000000000";

    -- cst0ForNegInput_uid12_Sqrt(CONSTANT,11)
    cst0ForNegInput_uid12_Sqrt_q <= "000000000000000000000000";

    -- Mult_Add_Mult1_merged_cma(CHAINMULTADD,239)@0 + 3
    Mult_Add_Mult1_merged_cma_reset <= not (areset_n);
    Mult_Add_Mult1_merged_cma_ena0 <= '1';
    Mult_Add_Mult1_merged_cma_ena1 <= Mult_Add_Mult1_merged_cma_ena0;
    Mult_Add_Mult1_merged_cma_ena2 <= Mult_Add_Mult1_merged_cma_ena0;
    Mult_Add_Mult1_merged_cma_p(0) <= Mult_Add_Mult1_merged_cma_a1(0) * Mult_Add_Mult1_merged_cma_c1(0);
    Mult_Add_Mult1_merged_cma_p(1) <= Mult_Add_Mult1_merged_cma_a1(1) * Mult_Add_Mult1_merged_cma_c1(1);
    Mult_Add_Mult1_merged_cma_u(0) <= RESIZE(Mult_Add_Mult1_merged_cma_p(0),25);
    Mult_Add_Mult1_merged_cma_u(1) <= RESIZE(Mult_Add_Mult1_merged_cma_p(1),25);
    Mult_Add_Mult1_merged_cma_w(0) <= Mult_Add_Mult1_merged_cma_u(0) + Mult_Add_Mult1_merged_cma_u(1);
    Mult_Add_Mult1_merged_cma_x(0) <= Mult_Add_Mult1_merged_cma_w(0);
    Mult_Add_Mult1_merged_cma_y(0) <= Mult_Add_Mult1_merged_cma_x(0);
    Mult_Add_Mult1_merged_cma_chainmultadd_input: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult_Add_Mult1_merged_cma_a0 <= (others => (others => '0'));
            Mult_Add_Mult1_merged_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult_Add_Mult1_merged_cma_ena0 = '1') THEN
                Mult_Add_Mult1_merged_cma_a0(0) <= RESIZE(SIGNED(in_2_Q),12);
                Mult_Add_Mult1_merged_cma_a0(1) <= RESIZE(SIGNED(in_1_I),12);
                Mult_Add_Mult1_merged_cma_c0(0) <= RESIZE(SIGNED(in_2_Q),12);
                Mult_Add_Mult1_merged_cma_c0(1) <= RESIZE(SIGNED(in_1_I),12);
            END IF;
        END IF;
    END PROCESS;
    Mult_Add_Mult1_merged_cma_chainmultadd_pipe: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult_Add_Mult1_merged_cma_a1 <= (others => (others => '0'));
            Mult_Add_Mult1_merged_cma_c1 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult_Add_Mult1_merged_cma_ena2 = '1') THEN
                Mult_Add_Mult1_merged_cma_a1 <= Mult_Add_Mult1_merged_cma_a0;
                Mult_Add_Mult1_merged_cma_c1 <= Mult_Add_Mult1_merged_cma_c0;
            END IF;
        END IF;
    END PROCESS;
    Mult_Add_Mult1_merged_cma_chainmultadd_output: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Mult_Add_Mult1_merged_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Mult_Add_Mult1_merged_cma_ena1 = '1') THEN
                Mult_Add_Mult1_merged_cma_s(0) <= Mult_Add_Mult1_merged_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    Mult_Add_Mult1_merged_cma_delay : dspba_delay
    GENERIC MAP ( width => 25, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(Mult_Add_Mult1_merged_cma_s(0)(24 downto 0)), xout => Mult_Add_Mult1_merged_cma_qq, clk => clk, aclr => areset_n );
    Mult_Add_Mult1_merged_cma_q <= STD_LOGIC_VECTOR(Mult_Add_Mult1_merged_cma_qq(24 downto 0));

    -- xFxpPosInput_uid13_Sqrt(BITSELECT,12)@3
    xFxpPosInput_uid13_Sqrt_in <= Mult_Add_Mult1_merged_cma_q(23 downto 0);
    xFxpPosInput_uid13_Sqrt_b <= xFxpPosInput_uid13_Sqrt_in(23 downto 0);

    -- inputSign_uid11_Sqrt(BITSELECT,10)@3
    inputSign_uid11_Sqrt_b <= STD_LOGIC_VECTOR(Mult_Add_Mult1_merged_cma_q(24 downto 24));

    -- xFxp_uid14_Sqrt(MUX,13)@3
    xFxp_uid14_Sqrt_s <= inputSign_uid11_Sqrt_b;
    xFxp_uid14_Sqrt_combproc: PROCESS (xFxp_uid14_Sqrt_s, xFxpPosInput_uid13_Sqrt_b, cst0ForNegInput_uid12_Sqrt_q)
    BEGIN
        CASE (xFxp_uid14_Sqrt_s) IS
            WHEN "0" => xFxp_uid14_Sqrt_q <= xFxpPosInput_uid13_Sqrt_b;
            WHEN "1" => xFxp_uid14_Sqrt_q <= cst0ForNegInput_uid12_Sqrt_q;
            WHEN OTHERS => xFxp_uid14_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid85_leadingZeros_uid15_Sqrt(BITSELECT,84)@3
    rVStage_uid85_leadingZeros_uid15_Sqrt_b <= xFxp_uid14_Sqrt_q(23 downto 8);

    -- vCount_uid86_leadingZeros_uid15_Sqrt(LOGICAL,85)@3
    vCount_uid86_leadingZeros_uid15_Sqrt_q <= "1" WHEN rVStage_uid85_leadingZeros_uid15_Sqrt_b = zs_uid84_leadingZeros_uid15_Sqrt_q ELSE "0";

    -- zs_uid92_leadingZeros_uid15_Sqrt(CONSTANT,91)
    zs_uid92_leadingZeros_uid15_Sqrt_q <= "00000000";

    -- vStage_uid88_leadingZeros_uid15_Sqrt(BITSELECT,87)@3
    vStage_uid88_leadingZeros_uid15_Sqrt_in <= xFxp_uid14_Sqrt_q(7 downto 0);
    vStage_uid88_leadingZeros_uid15_Sqrt_b <= vStage_uid88_leadingZeros_uid15_Sqrt_in(7 downto 0);

    -- mO_uid87_leadingZeros_uid15_Sqrt(CONSTANT,86)
    mO_uid87_leadingZeros_uid15_Sqrt_q <= "11111111";

    -- cStage_uid89_leadingZeros_uid15_Sqrt(BITJOIN,88)@3
    cStage_uid89_leadingZeros_uid15_Sqrt_q <= vStage_uid88_leadingZeros_uid15_Sqrt_b & mO_uid87_leadingZeros_uid15_Sqrt_q;

    -- vStagei_uid91_leadingZeros_uid15_Sqrt(MUX,90)@3
    vStagei_uid91_leadingZeros_uid15_Sqrt_s <= vCount_uid86_leadingZeros_uid15_Sqrt_q;
    vStagei_uid91_leadingZeros_uid15_Sqrt_combproc: PROCESS (vStagei_uid91_leadingZeros_uid15_Sqrt_s, rVStage_uid85_leadingZeros_uid15_Sqrt_b, cStage_uid89_leadingZeros_uid15_Sqrt_q)
    BEGIN
        CASE (vStagei_uid91_leadingZeros_uid15_Sqrt_s) IS
            WHEN "0" => vStagei_uid91_leadingZeros_uid15_Sqrt_q <= rVStage_uid85_leadingZeros_uid15_Sqrt_b;
            WHEN "1" => vStagei_uid91_leadingZeros_uid15_Sqrt_q <= cStage_uid89_leadingZeros_uid15_Sqrt_q;
            WHEN OTHERS => vStagei_uid91_leadingZeros_uid15_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select(BITSELECT,241)@3
    rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_b <= vStagei_uid91_leadingZeros_uid15_Sqrt_q(15 downto 8);
    rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_c <= vStagei_uid91_leadingZeros_uid15_Sqrt_q(7 downto 0);

    -- vCount_uid94_leadingZeros_uid15_Sqrt(LOGICAL,93)@3
    vCount_uid94_leadingZeros_uid15_Sqrt_q <= "1" WHEN rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_b = zs_uid92_leadingZeros_uid15_Sqrt_q ELSE "0";

    -- zs_uid98_leadingZeros_uid15_Sqrt(CONSTANT,97)
    zs_uid98_leadingZeros_uid15_Sqrt_q <= "0000";

    -- vStagei_uid97_leadingZeros_uid15_Sqrt(MUX,96)@3
    vStagei_uid97_leadingZeros_uid15_Sqrt_s <= vCount_uid94_leadingZeros_uid15_Sqrt_q;
    vStagei_uid97_leadingZeros_uid15_Sqrt_combproc: PROCESS (vStagei_uid97_leadingZeros_uid15_Sqrt_s, rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_b, rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid97_leadingZeros_uid15_Sqrt_s) IS
            WHEN "0" => vStagei_uid97_leadingZeros_uid15_Sqrt_q <= rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_b;
            WHEN "1" => vStagei_uid97_leadingZeros_uid15_Sqrt_q <= rVStage_uid93_leadingZeros_uid15_Sqrt_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid97_leadingZeros_uid15_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select(BITSELECT,242)@3
    rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_b <= vStagei_uid97_leadingZeros_uid15_Sqrt_q(7 downto 4);
    rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_c <= vStagei_uid97_leadingZeros_uid15_Sqrt_q(3 downto 0);

    -- vCount_uid100_leadingZeros_uid15_Sqrt(LOGICAL,99)@3
    vCount_uid100_leadingZeros_uid15_Sqrt_q <= "1" WHEN rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_b = zs_uid98_leadingZeros_uid15_Sqrt_q ELSE "0";

    -- zs_uid104_leadingZeros_uid15_Sqrt(CONSTANT,103)
    zs_uid104_leadingZeros_uid15_Sqrt_q <= "00";

    -- vStagei_uid103_leadingZeros_uid15_Sqrt(MUX,102)@3
    vStagei_uid103_leadingZeros_uid15_Sqrt_s <= vCount_uid100_leadingZeros_uid15_Sqrt_q;
    vStagei_uid103_leadingZeros_uid15_Sqrt_combproc: PROCESS (vStagei_uid103_leadingZeros_uid15_Sqrt_s, rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_b, rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid103_leadingZeros_uid15_Sqrt_s) IS
            WHEN "0" => vStagei_uid103_leadingZeros_uid15_Sqrt_q <= rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_b;
            WHEN "1" => vStagei_uid103_leadingZeros_uid15_Sqrt_q <= rVStage_uid99_leadingZeros_uid15_Sqrt_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid103_leadingZeros_uid15_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select(BITSELECT,243)@3
    rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_b <= vStagei_uid103_leadingZeros_uid15_Sqrt_q(3 downto 2);
    rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_c <= vStagei_uid103_leadingZeros_uid15_Sqrt_q(1 downto 0);

    -- vCount_uid106_leadingZeros_uid15_Sqrt(LOGICAL,105)@3
    vCount_uid106_leadingZeros_uid15_Sqrt_q <= "1" WHEN rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_b = zs_uid104_leadingZeros_uid15_Sqrt_q ELSE "0";

    -- vStagei_uid109_leadingZeros_uid15_Sqrt(MUX,108)@3
    vStagei_uid109_leadingZeros_uid15_Sqrt_s <= vCount_uid106_leadingZeros_uid15_Sqrt_q;
    vStagei_uid109_leadingZeros_uid15_Sqrt_combproc: PROCESS (vStagei_uid109_leadingZeros_uid15_Sqrt_s, rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_b, rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid109_leadingZeros_uid15_Sqrt_s) IS
            WHEN "0" => vStagei_uid109_leadingZeros_uid15_Sqrt_q <= rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_b;
            WHEN "1" => vStagei_uid109_leadingZeros_uid15_Sqrt_q <= rVStage_uid105_leadingZeros_uid15_Sqrt_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid109_leadingZeros_uid15_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid111_leadingZeros_uid15_Sqrt(BITSELECT,110)@3
    rVStage_uid111_leadingZeros_uid15_Sqrt_b <= vStagei_uid109_leadingZeros_uid15_Sqrt_q(1 downto 1);

    -- vCount_uid112_leadingZeros_uid15_Sqrt(LOGICAL,111)@3
    vCount_uid112_leadingZeros_uid15_Sqrt_q <= "1" WHEN rVStage_uid111_leadingZeros_uid15_Sqrt_b = GND_q ELSE "0";

    -- r_uid113_leadingZeros_uid15_Sqrt(BITJOIN,112)@3
    r_uid113_leadingZeros_uid15_Sqrt_q <= vCount_uid86_leadingZeros_uid15_Sqrt_q & vCount_uid94_leadingZeros_uid15_Sqrt_q & vCount_uid100_leadingZeros_uid15_Sqrt_q & vCount_uid106_leadingZeros_uid15_Sqrt_q & vCount_uid112_leadingZeros_uid15_Sqrt_q;

    -- redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5(DELAY,245)
    redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5 : dspba_delay
    GENERIC MAP ( width => 5, depth => 5, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => r_uid113_leadingZeros_uid15_Sqrt_q, xout => redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5_q, clk => clk, aclr => areset_n );

    -- inputAllZeros_uid79_Sqrt(LOGICAL,78)@8
    inputAllZeros_uid79_Sqrt_q <= "1" WHEN redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5_q = cstW_uid78_Sqrt_q ELSE "0";

    -- inputNotAllZeros_uid80_Sqrt(LOGICAL,79)@8
    inputNotAllZeros_uid80_Sqrt_q <= not (inputAllZeros_uid79_Sqrt_q);

    -- leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt(BITSELECT,193)@3
    leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt_in <= leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q(22 downto 0);
    leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt_b <= leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt_in(22 downto 0);

    -- leftShiftStage2Idx1_uid195_xLeftShift_uid31_Sqrt(BITJOIN,194)@3
    leftShiftStage2Idx1_uid195_xLeftShift_uid31_Sqrt_q <= leftShiftStage2Idx1Rng1_uid194_xLeftShift_uid31_Sqrt_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt(BITSELECT,188)@3
    leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt_in <= leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q(17 downto 0);
    leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt_b <= leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt_in(17 downto 0);

    -- leftShiftStage1Idx3Pad6_uid188_xLeftShift_uid31_Sqrt(CONSTANT,187)
    leftShiftStage1Idx3Pad6_uid188_xLeftShift_uid31_Sqrt_q <= "000000";

    -- leftShiftStage1Idx3_uid190_xLeftShift_uid31_Sqrt(BITJOIN,189)@3
    leftShiftStage1Idx3_uid190_xLeftShift_uid31_Sqrt_q <= leftShiftStage1Idx3Rng6_uid189_xLeftShift_uid31_Sqrt_b & leftShiftStage1Idx3Pad6_uid188_xLeftShift_uid31_Sqrt_q;

    -- leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt(BITSELECT,185)@3
    leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt_in <= leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q(19 downto 0);
    leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt_b <= leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt_in(19 downto 0);

    -- leftShiftStage1Idx2_uid187_xLeftShift_uid31_Sqrt(BITJOIN,186)@3
    leftShiftStage1Idx2_uid187_xLeftShift_uid31_Sqrt_q <= leftShiftStage1Idx2Rng4_uid186_xLeftShift_uid31_Sqrt_b & zs_uid98_leadingZeros_uid15_Sqrt_q;

    -- leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt(BITSELECT,182)@3
    leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt_in <= leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q(21 downto 0);
    leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt_b <= leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt_in(21 downto 0);

    -- leftShiftStage1Idx1_uid184_xLeftShift_uid31_Sqrt(BITJOIN,183)@3
    leftShiftStage1Idx1_uid184_xLeftShift_uid31_Sqrt_q <= leftShiftStage1Idx1Rng2_uid183_xLeftShift_uid31_Sqrt_b & zs_uid104_leadingZeros_uid15_Sqrt_q;

    -- leftShiftStage0Idx2_uid178_xLeftShift_uid31_Sqrt(BITJOIN,177)@3
    leftShiftStage0Idx2_uid178_xLeftShift_uid31_Sqrt_q <= vStage_uid88_leadingZeros_uid15_Sqrt_b & zs_uid84_leadingZeros_uid15_Sqrt_q;

    -- leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt(BITSELECT,173)@3
    leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt_in <= xFxp_uid14_Sqrt_q(15 downto 0);
    leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt_b <= leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt_in(15 downto 0);

    -- leftShiftStage0Idx1_uid175_xLeftShift_uid31_Sqrt(BITJOIN,174)@3
    leftShiftStage0Idx1_uid175_xLeftShift_uid31_Sqrt_q <= leftShiftStage0Idx1Rng8_uid174_xLeftShift_uid31_Sqrt_b & zs_uid92_leadingZeros_uid15_Sqrt_q;

    -- leftShiftStageSel4Dto3_uid180_xLeftShift_uid31_Sqrt(BITSELECT,179)@3
    leftShiftStageSel4Dto3_uid180_xLeftShift_uid31_Sqrt_b <= r_uid113_leadingZeros_uid15_Sqrt_q(4 downto 3);

    -- leftShiftStage0_uid181_xLeftShift_uid31_Sqrt(MUX,180)@3
    leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_s <= leftShiftStageSel4Dto3_uid180_xLeftShift_uid31_Sqrt_b;
    leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_combproc: PROCESS (leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_s, xFxp_uid14_Sqrt_q, leftShiftStage0Idx1_uid175_xLeftShift_uid31_Sqrt_q, leftShiftStage0Idx2_uid178_xLeftShift_uid31_Sqrt_q, cst0ForNegInput_uid12_Sqrt_q)
    BEGIN
        CASE (leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_s) IS
            WHEN "00" => leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q <= xFxp_uid14_Sqrt_q;
            WHEN "01" => leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q <= leftShiftStage0Idx1_uid175_xLeftShift_uid31_Sqrt_q;
            WHEN "10" => leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q <= leftShiftStage0Idx2_uid178_xLeftShift_uid31_Sqrt_q;
            WHEN "11" => leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q <= cst0ForNegInput_uid12_Sqrt_q;
            WHEN OTHERS => leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt(BITSELECT,190)@3
    leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt_in <= r_uid113_leadingZeros_uid15_Sqrt_q(2 downto 0);
    leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt_b <= leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt_in(2 downto 1);

    -- leftShiftStage1_uid192_xLeftShift_uid31_Sqrt(MUX,191)@3
    leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_s <= leftShiftStageSel2Dto1_uid191_xLeftShift_uid31_Sqrt_b;
    leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_combproc: PROCESS (leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_s, leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q, leftShiftStage1Idx1_uid184_xLeftShift_uid31_Sqrt_q, leftShiftStage1Idx2_uid187_xLeftShift_uid31_Sqrt_q, leftShiftStage1Idx3_uid190_xLeftShift_uid31_Sqrt_q)
    BEGIN
        CASE (leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_s) IS
            WHEN "00" => leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q <= leftShiftStage0_uid181_xLeftShift_uid31_Sqrt_q;
            WHEN "01" => leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q <= leftShiftStage1Idx1_uid184_xLeftShift_uid31_Sqrt_q;
            WHEN "10" => leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q <= leftShiftStage1Idx2_uid187_xLeftShift_uid31_Sqrt_q;
            WHEN "11" => leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q <= leftShiftStage1Idx3_uid190_xLeftShift_uid31_Sqrt_q;
            WHEN OTHERS => leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt(BITSELECT,195)@3
    leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt_in <= r_uid113_leadingZeros_uid15_Sqrt_q(0 downto 0);
    leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt_b <= leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt_in(0 downto 0);

    -- leftShiftStage2_uid197_xLeftShift_uid31_Sqrt(MUX,196)@3
    leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_s <= leftShiftStageSel0Dto0_uid196_xLeftShift_uid31_Sqrt_b;
    leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_combproc: PROCESS (leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_s, leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q, leftShiftStage2Idx1_uid195_xLeftShift_uid31_Sqrt_q)
    BEGIN
        CASE (leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_s) IS
            WHEN "0" => leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q <= leftShiftStage1_uid192_xLeftShift_uid31_Sqrt_q;
            WHEN "1" => leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q <= leftShiftStage2Idx1_uid195_xLeftShift_uid31_Sqrt_q;
            WHEN OTHERS => leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- x1_uid33_Sqrt(BITSELECT,32)@3
    x1_uid33_Sqrt_b <= leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q(23 downto 11);

    -- addrTable_uid39_Sqrt(BITSELECT,38)@3
    addrTable_uid39_Sqrt_in <= x1_uid33_Sqrt_b(11 downto 0);
    addrTable_uid39_Sqrt_b <= addrTable_uid39_Sqrt_in(11 downto 0);

    -- cPrimeTableOut_uid44_Sqrt_lutmem(DUALMEM,202)@3 + 2
    -- in j@20000000
    cPrimeTableOut_uid44_Sqrt_lutmem_aa <= addrTable_uid39_Sqrt_b;
    cPrimeTableOut_uid44_Sqrt_lutmem_reset0 <= not (areset_n);
    cPrimeTableOut_uid44_Sqrt_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 5,
        widthad_a => 12,
        numwords_a => 4096,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("MCC150/MCC150_TransceiverBPSK_Magnitude2_cPrimeTableOut_uid44_Sqrt_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        aclr0 => cPrimeTableOut_uid44_Sqrt_lutmem_reset0,
        clock0 => clk,
        address_a => cPrimeTableOut_uid44_Sqrt_lutmem_aa,
        q_a => cPrimeTableOut_uid44_Sqrt_lutmem_ir
    );
    cPrimeTableOut_uid44_Sqrt_lutmem_r <= cPrimeTableOut_uid44_Sqrt_lutmem_ir(4 downto 0);

    -- cPrimeTableOut_uid43_Sqrt_lutmem(DUALMEM,201)@3 + 2
    -- in j@20000000
    cPrimeTableOut_uid43_Sqrt_lutmem_aa <= addrTable_uid39_Sqrt_b;
    cPrimeTableOut_uid43_Sqrt_lutmem_reset0 <= not (areset_n);
    cPrimeTableOut_uid43_Sqrt_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 5,
        widthad_a => 12,
        numwords_a => 4096,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("MCC150/MCC150_TransceiverBPSK_Magnitude2_cPrimeTableOut_uid43_Sqrt_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        aclr0 => cPrimeTableOut_uid43_Sqrt_lutmem_reset0,
        clock0 => clk,
        address_a => cPrimeTableOut_uid43_Sqrt_lutmem_aa,
        q_a => cPrimeTableOut_uid43_Sqrt_lutmem_ir
    );
    cPrimeTableOut_uid43_Sqrt_lutmem_r <= cPrimeTableOut_uid43_Sqrt_lutmem_ir(4 downto 0);

    -- cPrimeTableOut_uid42_Sqrt_lutmem(DUALMEM,200)@3 + 2
    -- in j@20000000
    cPrimeTableOut_uid42_Sqrt_lutmem_aa <= addrTable_uid39_Sqrt_b;
    cPrimeTableOut_uid42_Sqrt_lutmem_reset0 <= not (areset_n);
    cPrimeTableOut_uid42_Sqrt_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 5,
        widthad_a => 12,
        numwords_a => 4096,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("MCC150/MCC150_TransceiverBPSK_Magnitude2_cPrimeTableOut_uid42_Sqrt_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        aclr0 => cPrimeTableOut_uid42_Sqrt_lutmem_reset0,
        clock0 => clk,
        address_a => cPrimeTableOut_uid42_Sqrt_lutmem_aa,
        q_a => cPrimeTableOut_uid42_Sqrt_lutmem_ir
    );
    cPrimeTableOut_uid42_Sqrt_lutmem_r <= cPrimeTableOut_uid42_Sqrt_lutmem_ir(4 downto 0);

    -- cPrimeTableOut_uid41_Sqrt_lutmem(DUALMEM,199)@3 + 2
    -- in j@20000000
    cPrimeTableOut_uid41_Sqrt_lutmem_aa <= addrTable_uid39_Sqrt_b;
    cPrimeTableOut_uid41_Sqrt_lutmem_reset0 <= not (areset_n);
    cPrimeTableOut_uid41_Sqrt_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 5,
        widthad_a => 12,
        numwords_a => 4096,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("MCC150/MCC150_TransceiverBPSK_Magnitude2_cPrimeTableOut_uid41_Sqrt_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        aclr0 => cPrimeTableOut_uid41_Sqrt_lutmem_reset0,
        clock0 => clk,
        address_a => cPrimeTableOut_uid41_Sqrt_lutmem_aa,
        q_a => cPrimeTableOut_uid41_Sqrt_lutmem_ir
    );
    cPrimeTableOut_uid41_Sqrt_lutmem_r <= cPrimeTableOut_uid41_Sqrt_lutmem_ir(4 downto 0);

    -- cPrimeTableOut_uid40_Sqrt_lutmem(DUALMEM,198)@3 + 2
    -- in j@20000000
    cPrimeTableOut_uid40_Sqrt_lutmem_aa <= addrTable_uid39_Sqrt_b;
    cPrimeTableOut_uid40_Sqrt_lutmem_reset0 <= not (areset_n);
    cPrimeTableOut_uid40_Sqrt_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 5,
        widthad_a => 12,
        numwords_a => 4096,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("MCC150/MCC150_TransceiverBPSK_Magnitude2_cPrimeTableOut_uid40_Sqrt_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => VCC_q(0),
        aclr0 => cPrimeTableOut_uid40_Sqrt_lutmem_reset0,
        clock0 => clk,
        address_a => cPrimeTableOut_uid40_Sqrt_lutmem_aa,
        q_a => cPrimeTableOut_uid40_Sqrt_lutmem_ir
    );
    cPrimeTableOut_uid40_Sqrt_lutmem_r <= cPrimeTableOut_uid40_Sqrt_lutmem_ir(4 downto 0);

    -- os_uid46_Sqrt(BITJOIN,45)@5
    os_uid46_Sqrt_q <= GND_q & cPrimeTableOut_uid44_Sqrt_lutmem_r & cPrimeTableOut_uid43_Sqrt_lutmem_r & cPrimeTableOut_uid42_Sqrt_lutmem_r & cPrimeTableOut_uid41_Sqrt_lutmem_r & cPrimeTableOut_uid40_Sqrt_lutmem_r;

    -- redist3_x1_uid33_Sqrt_b_2(DELAY,248)
    redist3_x1_uid33_Sqrt_b_2 : dspba_delay
    GENERIC MAP ( width => 13, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => x1_uid33_Sqrt_b, xout => redist3_x1_uid33_Sqrt_b_2_q, clk => clk, aclr => areset_n );

    -- x_mp1_uid34_Sqrt(BITSELECT,33)@3
    x_mp1_uid34_Sqrt_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q(10 downto 0));
    x_mp1_uid34_Sqrt_b <= STD_LOGIC_VECTOR(x_mp1_uid34_Sqrt_in(10 downto 10));

    -- redist2_x_mp1_uid34_Sqrt_b_2(DELAY,247)
    redist2_x_mp1_uid34_Sqrt_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => x_mp1_uid34_Sqrt_b, xout => redist2_x_mp1_uid34_Sqrt_b_2_q, clk => clk, aclr => areset_n );

    -- neg_x_mp1_uid35_Sqrt(LOGICAL,34)@5
    neg_x_mp1_uid35_Sqrt_q <= not (redist2_x_mp1_uid34_Sqrt_b_2_q);

    -- x2_uid36_Sqrt(BITSELECT,35)@3
    x2_uid36_Sqrt_in <= leftShiftStage2_uid197_xLeftShift_uid31_Sqrt_q(9 downto 0);
    x2_uid36_Sqrt_b <= x2_uid36_Sqrt_in(9 downto 0);

    -- redist1_x2_uid36_Sqrt_b_2(DELAY,246)
    redist1_x2_uid36_Sqrt_b_2 : dspba_delay
    GENERIC MAP ( width => 10, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => x2_uid36_Sqrt_b, xout => redist1_x2_uid36_Sqrt_b_2_q, clk => clk, aclr => areset_n );

    -- x_prime_tmp_uid37_Sqrt(BITJOIN,36)@5
    x_prime_tmp_uid37_Sqrt_q <= redist3_x1_uid33_Sqrt_b_2_q & redist2_x_mp1_uid34_Sqrt_b_2_q & neg_x_mp1_uid35_Sqrt_q & redist1_x2_uid36_Sqrt_b_2_q;

    -- resultFull_uid48_Sqrt_cma(CHAINMULTADD,238)@5 + 3
    resultFull_uid48_Sqrt_cma_reset <= not (areset_n);
    resultFull_uid48_Sqrt_cma_ena0 <= '1';
    resultFull_uid48_Sqrt_cma_ena1 <= resultFull_uid48_Sqrt_cma_ena0;
    resultFull_uid48_Sqrt_cma_ena2 <= resultFull_uid48_Sqrt_cma_ena0;
    resultFull_uid48_Sqrt_cma_p(0) <= resultFull_uid48_Sqrt_cma_a1(0) * resultFull_uid48_Sqrt_cma_c1(0);
    resultFull_uid48_Sqrt_cma_u(0) <= RESIZE(resultFull_uid48_Sqrt_cma_p(0),51);
    resultFull_uid48_Sqrt_cma_w(0) <= resultFull_uid48_Sqrt_cma_u(0);
    resultFull_uid48_Sqrt_cma_x(0) <= resultFull_uid48_Sqrt_cma_w(0);
    resultFull_uid48_Sqrt_cma_y(0) <= resultFull_uid48_Sqrt_cma_x(0);
    resultFull_uid48_Sqrt_cma_chainmultadd_input: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            resultFull_uid48_Sqrt_cma_a0 <= (others => (others => '0'));
            resultFull_uid48_Sqrt_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (resultFull_uid48_Sqrt_cma_ena0 = '1') THEN
                resultFull_uid48_Sqrt_cma_a0(0) <= RESIZE(UNSIGNED(x_prime_tmp_uid37_Sqrt_q),25);
                resultFull_uid48_Sqrt_cma_c0(0) <= RESIZE(UNSIGNED(os_uid46_Sqrt_q),26);
            END IF;
        END IF;
    END PROCESS;
    resultFull_uid48_Sqrt_cma_chainmultadd_pipe: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            resultFull_uid48_Sqrt_cma_a1 <= (others => (others => '0'));
            resultFull_uid48_Sqrt_cma_c1 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (resultFull_uid48_Sqrt_cma_ena2 = '1') THEN
                resultFull_uid48_Sqrt_cma_a1 <= resultFull_uid48_Sqrt_cma_a0;
                resultFull_uid48_Sqrt_cma_c1 <= resultFull_uid48_Sqrt_cma_c0;
            END IF;
        END IF;
    END PROCESS;
    resultFull_uid48_Sqrt_cma_chainmultadd_output: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            resultFull_uid48_Sqrt_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (resultFull_uid48_Sqrt_cma_ena1 = '1') THEN
                resultFull_uid48_Sqrt_cma_s(0) <= resultFull_uid48_Sqrt_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    resultFull_uid48_Sqrt_cma_delay : dspba_delay
    GENERIC MAP ( width => 51, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(resultFull_uid48_Sqrt_cma_s(0)(50 downto 0)), xout => resultFull_uid48_Sqrt_cma_qq, clk => clk, aclr => areset_n );
    resultFull_uid48_Sqrt_cma_q <= STD_LOGIC_VECTOR(resultFull_uid48_Sqrt_cma_qq(50 downto 0));

    -- result_uid49_Sqrt(BITSELECT,48)@8
    result_uid49_Sqrt_in <= resultFull_uid48_Sqrt_cma_q(49 downto 0);
    result_uid49_Sqrt_b <= result_uid49_Sqrt_in(49 downto 24);

    -- invNegShiftEven_uid52_Sqrt(BITSELECT,51)@8
    invNegShiftEven_uid52_Sqrt_b <= STD_LOGIC_VECTOR(result_uid49_Sqrt_b(25 downto 25));

    -- negShiftEven_uid53_Sqrt(LOGICAL,52)@8
    negShiftEven_uid53_Sqrt_q <= not (invNegShiftEven_uid52_Sqrt_b);

    -- parityOddOriginal_uid20_Sqrt(BITSELECT,19)@8
    parityOddOriginal_uid20_Sqrt_in <= STD_LOGIC_VECTOR(redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5_q(0 downto 0));
    parityOddOriginal_uid20_Sqrt_b <= STD_LOGIC_VECTOR(parityOddOriginal_uid20_Sqrt_in(0 downto 0));

    -- EvenBranchAndNegUpdate_uid57_Sqrt(LOGICAL,56)@8
    EvenBranchAndNegUpdate_uid57_Sqrt_q <= parityOddOriginal_uid20_Sqrt_b and negShiftEven_uid53_Sqrt_q;

    -- maxValInOutFormat_uid132_finalMult_uid50_Sqrt(CONSTANT,131)
    maxValInOutFormat_uid132_finalMult_uid50_Sqrt_q <= "11111111111111111111111111";

    -- minValueInFormat_uid133_finalMult_uid50_Sqrt(CONSTANT,132)
    minValueInFormat_uid133_finalMult_uid50_Sqrt_q <= "00000000000000000000000000";

    -- xv0_uid115_finalMult_uid50_Sqrt(BITSELECT,114)@8
    xv0_uid115_finalMult_uid50_Sqrt_in <= result_uid49_Sqrt_b(5 downto 0);
    xv0_uid115_finalMult_uid50_Sqrt_b <= xv0_uid115_finalMult_uid50_Sqrt_in(5 downto 0);

    -- p0_uid124_finalMult_uid50_Sqrt(LOOKUP,123)@8
    p0_uid124_finalMult_uid50_Sqrt_combproc: PROCESS (xv0_uid115_finalMult_uid50_Sqrt_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv0_uid115_finalMult_uid50_Sqrt_b) IS
            WHEN "000000" => p0_uid124_finalMult_uid50_Sqrt_q <= "0000000000";
            WHEN "000001" => p0_uid124_finalMult_uid50_Sqrt_q <= "0000001011";
            WHEN "000010" => p0_uid124_finalMult_uid50_Sqrt_q <= "0000010110";
            WHEN "000011" => p0_uid124_finalMult_uid50_Sqrt_q <= "0000100001";
            WHEN "000100" => p0_uid124_finalMult_uid50_Sqrt_q <= "0000101101";
            WHEN "000101" => p0_uid124_finalMult_uid50_Sqrt_q <= "0000111000";
            WHEN "000110" => p0_uid124_finalMult_uid50_Sqrt_q <= "0001000011";
            WHEN "000111" => p0_uid124_finalMult_uid50_Sqrt_q <= "0001001111";
            WHEN "001000" => p0_uid124_finalMult_uid50_Sqrt_q <= "0001011010";
            WHEN "001001" => p0_uid124_finalMult_uid50_Sqrt_q <= "0001100101";
            WHEN "001010" => p0_uid124_finalMult_uid50_Sqrt_q <= "0001110001";
            WHEN "001011" => p0_uid124_finalMult_uid50_Sqrt_q <= "0001111100";
            WHEN "001100" => p0_uid124_finalMult_uid50_Sqrt_q <= "0010000111";
            WHEN "001101" => p0_uid124_finalMult_uid50_Sqrt_q <= "0010010011";
            WHEN "001110" => p0_uid124_finalMult_uid50_Sqrt_q <= "0010011110";
            WHEN "001111" => p0_uid124_finalMult_uid50_Sqrt_q <= "0010101001";
            WHEN "010000" => p0_uid124_finalMult_uid50_Sqrt_q <= "0010110101";
            WHEN "010001" => p0_uid124_finalMult_uid50_Sqrt_q <= "0011000000";
            WHEN "010010" => p0_uid124_finalMult_uid50_Sqrt_q <= "0011001011";
            WHEN "010011" => p0_uid124_finalMult_uid50_Sqrt_q <= "0011010110";
            WHEN "010100" => p0_uid124_finalMult_uid50_Sqrt_q <= "0011100010";
            WHEN "010101" => p0_uid124_finalMult_uid50_Sqrt_q <= "0011101101";
            WHEN "010110" => p0_uid124_finalMult_uid50_Sqrt_q <= "0011111000";
            WHEN "010111" => p0_uid124_finalMult_uid50_Sqrt_q <= "0100000100";
            WHEN "011000" => p0_uid124_finalMult_uid50_Sqrt_q <= "0100001111";
            WHEN "011001" => p0_uid124_finalMult_uid50_Sqrt_q <= "0100011010";
            WHEN "011010" => p0_uid124_finalMult_uid50_Sqrt_q <= "0100100110";
            WHEN "011011" => p0_uid124_finalMult_uid50_Sqrt_q <= "0100110001";
            WHEN "011100" => p0_uid124_finalMult_uid50_Sqrt_q <= "0100111100";
            WHEN "011101" => p0_uid124_finalMult_uid50_Sqrt_q <= "0101001000";
            WHEN "011110" => p0_uid124_finalMult_uid50_Sqrt_q <= "0101010011";
            WHEN "011111" => p0_uid124_finalMult_uid50_Sqrt_q <= "0101011110";
            WHEN "100000" => p0_uid124_finalMult_uid50_Sqrt_q <= "0101101010";
            WHEN "100001" => p0_uid124_finalMult_uid50_Sqrt_q <= "0101110101";
            WHEN "100010" => p0_uid124_finalMult_uid50_Sqrt_q <= "0110000000";
            WHEN "100011" => p0_uid124_finalMult_uid50_Sqrt_q <= "0110001011";
            WHEN "100100" => p0_uid124_finalMult_uid50_Sqrt_q <= "0110010111";
            WHEN "100101" => p0_uid124_finalMult_uid50_Sqrt_q <= "0110100010";
            WHEN "100110" => p0_uid124_finalMult_uid50_Sqrt_q <= "0110101101";
            WHEN "100111" => p0_uid124_finalMult_uid50_Sqrt_q <= "0110111001";
            WHEN "101000" => p0_uid124_finalMult_uid50_Sqrt_q <= "0111000100";
            WHEN "101001" => p0_uid124_finalMult_uid50_Sqrt_q <= "0111001111";
            WHEN "101010" => p0_uid124_finalMult_uid50_Sqrt_q <= "0111011011";
            WHEN "101011" => p0_uid124_finalMult_uid50_Sqrt_q <= "0111100110";
            WHEN "101100" => p0_uid124_finalMult_uid50_Sqrt_q <= "0111110001";
            WHEN "101101" => p0_uid124_finalMult_uid50_Sqrt_q <= "0111111101";
            WHEN "101110" => p0_uid124_finalMult_uid50_Sqrt_q <= "1000001000";
            WHEN "101111" => p0_uid124_finalMult_uid50_Sqrt_q <= "1000010011";
            WHEN "110000" => p0_uid124_finalMult_uid50_Sqrt_q <= "1000011111";
            WHEN "110001" => p0_uid124_finalMult_uid50_Sqrt_q <= "1000101010";
            WHEN "110010" => p0_uid124_finalMult_uid50_Sqrt_q <= "1000110101";
            WHEN "110011" => p0_uid124_finalMult_uid50_Sqrt_q <= "1001000000";
            WHEN "110100" => p0_uid124_finalMult_uid50_Sqrt_q <= "1001001100";
            WHEN "110101" => p0_uid124_finalMult_uid50_Sqrt_q <= "1001010111";
            WHEN "110110" => p0_uid124_finalMult_uid50_Sqrt_q <= "1001100010";
            WHEN "110111" => p0_uid124_finalMult_uid50_Sqrt_q <= "1001101110";
            WHEN "111000" => p0_uid124_finalMult_uid50_Sqrt_q <= "1001111001";
            WHEN "111001" => p0_uid124_finalMult_uid50_Sqrt_q <= "1010000100";
            WHEN "111010" => p0_uid124_finalMult_uid50_Sqrt_q <= "1010010000";
            WHEN "111011" => p0_uid124_finalMult_uid50_Sqrt_q <= "1010011011";
            WHEN "111100" => p0_uid124_finalMult_uid50_Sqrt_q <= "1010100110";
            WHEN "111101" => p0_uid124_finalMult_uid50_Sqrt_q <= "1010110010";
            WHEN "111110" => p0_uid124_finalMult_uid50_Sqrt_q <= "1010111101";
            WHEN "111111" => p0_uid124_finalMult_uid50_Sqrt_q <= "1011001000";
            WHEN OTHERS => -- unreachable
                           p0_uid124_finalMult_uid50_Sqrt_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- xv1_uid116_finalMult_uid50_Sqrt(BITSELECT,115)@8
    xv1_uid116_finalMult_uid50_Sqrt_in <= result_uid49_Sqrt_b(11 downto 0);
    xv1_uid116_finalMult_uid50_Sqrt_b <= xv1_uid116_finalMult_uid50_Sqrt_in(11 downto 6);

    -- p1_uid123_finalMult_uid50_Sqrt(LOOKUP,122)@8
    p1_uid123_finalMult_uid50_Sqrt_combproc: PROCESS (xv1_uid116_finalMult_uid50_Sqrt_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv1_uid116_finalMult_uid50_Sqrt_b) IS
            WHEN "000000" => p1_uid123_finalMult_uid50_Sqrt_q <= "0000000000000000";
            WHEN "000001" => p1_uid123_finalMult_uid50_Sqrt_q <= "0000001011010100";
            WHEN "000010" => p1_uid123_finalMult_uid50_Sqrt_q <= "0000010110101000";
            WHEN "000011" => p1_uid123_finalMult_uid50_Sqrt_q <= "0000100001111100";
            WHEN "000100" => p1_uid123_finalMult_uid50_Sqrt_q <= "0000101101010000";
            WHEN "000101" => p1_uid123_finalMult_uid50_Sqrt_q <= "0000111000100100";
            WHEN "000110" => p1_uid123_finalMult_uid50_Sqrt_q <= "0001000011111000";
            WHEN "000111" => p1_uid123_finalMult_uid50_Sqrt_q <= "0001001111001100";
            WHEN "001000" => p1_uid123_finalMult_uid50_Sqrt_q <= "0001011010100000";
            WHEN "001001" => p1_uid123_finalMult_uid50_Sqrt_q <= "0001100101110100";
            WHEN "001010" => p1_uid123_finalMult_uid50_Sqrt_q <= "0001110001001000";
            WHEN "001011" => p1_uid123_finalMult_uid50_Sqrt_q <= "0001111100011100";
            WHEN "001100" => p1_uid123_finalMult_uid50_Sqrt_q <= "0010000111110000";
            WHEN "001101" => p1_uid123_finalMult_uid50_Sqrt_q <= "0010010011000101";
            WHEN "001110" => p1_uid123_finalMult_uid50_Sqrt_q <= "0010011110011001";
            WHEN "001111" => p1_uid123_finalMult_uid50_Sqrt_q <= "0010101001101101";
            WHEN "010000" => p1_uid123_finalMult_uid50_Sqrt_q <= "0010110101000001";
            WHEN "010001" => p1_uid123_finalMult_uid50_Sqrt_q <= "0011000000010101";
            WHEN "010010" => p1_uid123_finalMult_uid50_Sqrt_q <= "0011001011101001";
            WHEN "010011" => p1_uid123_finalMult_uid50_Sqrt_q <= "0011010110111101";
            WHEN "010100" => p1_uid123_finalMult_uid50_Sqrt_q <= "0011100010010001";
            WHEN "010101" => p1_uid123_finalMult_uid50_Sqrt_q <= "0011101101100101";
            WHEN "010110" => p1_uid123_finalMult_uid50_Sqrt_q <= "0011111000111001";
            WHEN "010111" => p1_uid123_finalMult_uid50_Sqrt_q <= "0100000100001101";
            WHEN "011000" => p1_uid123_finalMult_uid50_Sqrt_q <= "0100001111100001";
            WHEN "011001" => p1_uid123_finalMult_uid50_Sqrt_q <= "0100011010110101";
            WHEN "011010" => p1_uid123_finalMult_uid50_Sqrt_q <= "0100100110001010";
            WHEN "011011" => p1_uid123_finalMult_uid50_Sqrt_q <= "0100110001011110";
            WHEN "011100" => p1_uid123_finalMult_uid50_Sqrt_q <= "0100111100110010";
            WHEN "011101" => p1_uid123_finalMult_uid50_Sqrt_q <= "0101001000000110";
            WHEN "011110" => p1_uid123_finalMult_uid50_Sqrt_q <= "0101010011011010";
            WHEN "011111" => p1_uid123_finalMult_uid50_Sqrt_q <= "0101011110101110";
            WHEN "100000" => p1_uid123_finalMult_uid50_Sqrt_q <= "0101101010000010";
            WHEN "100001" => p1_uid123_finalMult_uid50_Sqrt_q <= "0101110101010110";
            WHEN "100010" => p1_uid123_finalMult_uid50_Sqrt_q <= "0110000000101010";
            WHEN "100011" => p1_uid123_finalMult_uid50_Sqrt_q <= "0110001011111110";
            WHEN "100100" => p1_uid123_finalMult_uid50_Sqrt_q <= "0110010111010010";
            WHEN "100101" => p1_uid123_finalMult_uid50_Sqrt_q <= "0110100010100110";
            WHEN "100110" => p1_uid123_finalMult_uid50_Sqrt_q <= "0110101101111010";
            WHEN "100111" => p1_uid123_finalMult_uid50_Sqrt_q <= "0110111001001111";
            WHEN "101000" => p1_uid123_finalMult_uid50_Sqrt_q <= "0111000100100011";
            WHEN "101001" => p1_uid123_finalMult_uid50_Sqrt_q <= "0111001111110111";
            WHEN "101010" => p1_uid123_finalMult_uid50_Sqrt_q <= "0111011011001011";
            WHEN "101011" => p1_uid123_finalMult_uid50_Sqrt_q <= "0111100110011111";
            WHEN "101100" => p1_uid123_finalMult_uid50_Sqrt_q <= "0111110001110011";
            WHEN "101101" => p1_uid123_finalMult_uid50_Sqrt_q <= "0111111101000111";
            WHEN "101110" => p1_uid123_finalMult_uid50_Sqrt_q <= "1000001000011011";
            WHEN "101111" => p1_uid123_finalMult_uid50_Sqrt_q <= "1000010011101111";
            WHEN "110000" => p1_uid123_finalMult_uid50_Sqrt_q <= "1000011111000011";
            WHEN "110001" => p1_uid123_finalMult_uid50_Sqrt_q <= "1000101010010111";
            WHEN "110010" => p1_uid123_finalMult_uid50_Sqrt_q <= "1000110101101011";
            WHEN "110011" => p1_uid123_finalMult_uid50_Sqrt_q <= "1001000000111111";
            WHEN "110100" => p1_uid123_finalMult_uid50_Sqrt_q <= "1001001100010100";
            WHEN "110101" => p1_uid123_finalMult_uid50_Sqrt_q <= "1001010111101000";
            WHEN "110110" => p1_uid123_finalMult_uid50_Sqrt_q <= "1001100010111100";
            WHEN "110111" => p1_uid123_finalMult_uid50_Sqrt_q <= "1001101110010000";
            WHEN "111000" => p1_uid123_finalMult_uid50_Sqrt_q <= "1001111001100100";
            WHEN "111001" => p1_uid123_finalMult_uid50_Sqrt_q <= "1010000100111000";
            WHEN "111010" => p1_uid123_finalMult_uid50_Sqrt_q <= "1010010000001100";
            WHEN "111011" => p1_uid123_finalMult_uid50_Sqrt_q <= "1010011011100000";
            WHEN "111100" => p1_uid123_finalMult_uid50_Sqrt_q <= "1010100110110100";
            WHEN "111101" => p1_uid123_finalMult_uid50_Sqrt_q <= "1010110010001000";
            WHEN "111110" => p1_uid123_finalMult_uid50_Sqrt_q <= "1010111101011100";
            WHEN "111111" => p1_uid123_finalMult_uid50_Sqrt_q <= "1011001000110000";
            WHEN OTHERS => -- unreachable
                           p1_uid123_finalMult_uid50_Sqrt_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- xv2_uid117_finalMult_uid50_Sqrt(BITSELECT,116)@8
    xv2_uid117_finalMult_uid50_Sqrt_in <= result_uid49_Sqrt_b(17 downto 0);
    xv2_uid117_finalMult_uid50_Sqrt_b <= xv2_uid117_finalMult_uid50_Sqrt_in(17 downto 12);

    -- p2_uid122_finalMult_uid50_Sqrt(LOOKUP,121)@8
    p2_uid122_finalMult_uid50_Sqrt_combproc: PROCESS (xv2_uid117_finalMult_uid50_Sqrt_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv2_uid117_finalMult_uid50_Sqrt_b) IS
            WHEN "000000" => p2_uid122_finalMult_uid50_Sqrt_q <= "0000000000000000000000";
            WHEN "000001" => p2_uid122_finalMult_uid50_Sqrt_q <= "0000001011010100000100";
            WHEN "000010" => p2_uid122_finalMult_uid50_Sqrt_q <= "0000010110101000001001";
            WHEN "000011" => p2_uid122_finalMult_uid50_Sqrt_q <= "0000100001111100001110";
            WHEN "000100" => p2_uid122_finalMult_uid50_Sqrt_q <= "0000101101010000010011";
            WHEN "000101" => p2_uid122_finalMult_uid50_Sqrt_q <= "0000111000100100011000";
            WHEN "000110" => p2_uid122_finalMult_uid50_Sqrt_q <= "0001000011111000011101";
            WHEN "000111" => p2_uid122_finalMult_uid50_Sqrt_q <= "0001001111001100100010";
            WHEN "001000" => p2_uid122_finalMult_uid50_Sqrt_q <= "0001011010100000100111";
            WHEN "001001" => p2_uid122_finalMult_uid50_Sqrt_q <= "0001100101110100101100";
            WHEN "001010" => p2_uid122_finalMult_uid50_Sqrt_q <= "0001110001001000110001";
            WHEN "001011" => p2_uid122_finalMult_uid50_Sqrt_q <= "0001111100011100110110";
            WHEN "001100" => p2_uid122_finalMult_uid50_Sqrt_q <= "0010000111110000111011";
            WHEN "001101" => p2_uid122_finalMult_uid50_Sqrt_q <= "0010010011000101000000";
            WHEN "001110" => p2_uid122_finalMult_uid50_Sqrt_q <= "0010011110011001000101";
            WHEN "001111" => p2_uid122_finalMult_uid50_Sqrt_q <= "0010101001101101001010";
            WHEN "010000" => p2_uid122_finalMult_uid50_Sqrt_q <= "0010110101000001001111";
            WHEN "010001" => p2_uid122_finalMult_uid50_Sqrt_q <= "0011000000010101010100";
            WHEN "010010" => p2_uid122_finalMult_uid50_Sqrt_q <= "0011001011101001011001";
            WHEN "010011" => p2_uid122_finalMult_uid50_Sqrt_q <= "0011010110111101011110";
            WHEN "010100" => p2_uid122_finalMult_uid50_Sqrt_q <= "0011100010010001100011";
            WHEN "010101" => p2_uid122_finalMult_uid50_Sqrt_q <= "0011101101100101100111";
            WHEN "010110" => p2_uid122_finalMult_uid50_Sqrt_q <= "0011111000111001101100";
            WHEN "010111" => p2_uid122_finalMult_uid50_Sqrt_q <= "0100000100001101110001";
            WHEN "011000" => p2_uid122_finalMult_uid50_Sqrt_q <= "0100001111100001110110";
            WHEN "011001" => p2_uid122_finalMult_uid50_Sqrt_q <= "0100011010110101111011";
            WHEN "011010" => p2_uid122_finalMult_uid50_Sqrt_q <= "0100100110001010000000";
            WHEN "011011" => p2_uid122_finalMult_uid50_Sqrt_q <= "0100110001011110000101";
            WHEN "011100" => p2_uid122_finalMult_uid50_Sqrt_q <= "0100111100110010001010";
            WHEN "011101" => p2_uid122_finalMult_uid50_Sqrt_q <= "0101001000000110001111";
            WHEN "011110" => p2_uid122_finalMult_uid50_Sqrt_q <= "0101010011011010010100";
            WHEN "011111" => p2_uid122_finalMult_uid50_Sqrt_q <= "0101011110101110011001";
            WHEN "100000" => p2_uid122_finalMult_uid50_Sqrt_q <= "0101101010000010011110";
            WHEN "100001" => p2_uid122_finalMult_uid50_Sqrt_q <= "0101110101010110100011";
            WHEN "100010" => p2_uid122_finalMult_uid50_Sqrt_q <= "0110000000101010101000";
            WHEN "100011" => p2_uid122_finalMult_uid50_Sqrt_q <= "0110001011111110101101";
            WHEN "100100" => p2_uid122_finalMult_uid50_Sqrt_q <= "0110010111010010110010";
            WHEN "100101" => p2_uid122_finalMult_uid50_Sqrt_q <= "0110100010100110110111";
            WHEN "100110" => p2_uid122_finalMult_uid50_Sqrt_q <= "0110101101111010111100";
            WHEN "100111" => p2_uid122_finalMult_uid50_Sqrt_q <= "0110111001001111000001";
            WHEN "101000" => p2_uid122_finalMult_uid50_Sqrt_q <= "0111000100100011000110";
            WHEN "101001" => p2_uid122_finalMult_uid50_Sqrt_q <= "0111001111110111001010";
            WHEN "101010" => p2_uid122_finalMult_uid50_Sqrt_q <= "0111011011001011001111";
            WHEN "101011" => p2_uid122_finalMult_uid50_Sqrt_q <= "0111100110011111010100";
            WHEN "101100" => p2_uid122_finalMult_uid50_Sqrt_q <= "0111110001110011011001";
            WHEN "101101" => p2_uid122_finalMult_uid50_Sqrt_q <= "0111111101000111011110";
            WHEN "101110" => p2_uid122_finalMult_uid50_Sqrt_q <= "1000001000011011100011";
            WHEN "101111" => p2_uid122_finalMult_uid50_Sqrt_q <= "1000010011101111101000";
            WHEN "110000" => p2_uid122_finalMult_uid50_Sqrt_q <= "1000011111000011101101";
            WHEN "110001" => p2_uid122_finalMult_uid50_Sqrt_q <= "1000101010010111110010";
            WHEN "110010" => p2_uid122_finalMult_uid50_Sqrt_q <= "1000110101101011110111";
            WHEN "110011" => p2_uid122_finalMult_uid50_Sqrt_q <= "1001000000111111111100";
            WHEN "110100" => p2_uid122_finalMult_uid50_Sqrt_q <= "1001001100010100000001";
            WHEN "110101" => p2_uid122_finalMult_uid50_Sqrt_q <= "1001010111101000000110";
            WHEN "110110" => p2_uid122_finalMult_uid50_Sqrt_q <= "1001100010111100001011";
            WHEN "110111" => p2_uid122_finalMult_uid50_Sqrt_q <= "1001101110010000010000";
            WHEN "111000" => p2_uid122_finalMult_uid50_Sqrt_q <= "1001111001100100010101";
            WHEN "111001" => p2_uid122_finalMult_uid50_Sqrt_q <= "1010000100111000011010";
            WHEN "111010" => p2_uid122_finalMult_uid50_Sqrt_q <= "1010010000001100011111";
            WHEN "111011" => p2_uid122_finalMult_uid50_Sqrt_q <= "1010011011100000100100";
            WHEN "111100" => p2_uid122_finalMult_uid50_Sqrt_q <= "1010100110110100101001";
            WHEN "111101" => p2_uid122_finalMult_uid50_Sqrt_q <= "1010110010001000101101";
            WHEN "111110" => p2_uid122_finalMult_uid50_Sqrt_q <= "1010111101011100110010";
            WHEN "111111" => p2_uid122_finalMult_uid50_Sqrt_q <= "1011001000110000110111";
            WHEN OTHERS => -- unreachable
                           p2_uid122_finalMult_uid50_Sqrt_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- lev1_a1_uid129_finalMult_uid50_Sqrt(ADD,128)@8
    lev1_a1_uid129_finalMult_uid50_Sqrt_a <= STD_LOGIC_VECTOR("0" & p2_uid122_finalMult_uid50_Sqrt_q);
    lev1_a1_uid129_finalMult_uid50_Sqrt_b <= STD_LOGIC_VECTOR("0000000" & p1_uid123_finalMult_uid50_Sqrt_q);
    lev1_a1_uid129_finalMult_uid50_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a1_uid129_finalMult_uid50_Sqrt_a) + UNSIGNED(lev1_a1_uid129_finalMult_uid50_Sqrt_b));
    lev1_a1_uid129_finalMult_uid50_Sqrt_q <= lev1_a1_uid129_finalMult_uid50_Sqrt_o(22 downto 0);

    -- xv4_uid119_finalMult_uid50_Sqrt(BITSELECT,118)@8
    xv4_uid119_finalMult_uid50_Sqrt_b <= result_uid49_Sqrt_b(25 downto 24);

    -- p4_uid120_finalMult_uid50_Sqrt(LOOKUP,119)@8
    p4_uid120_finalMult_uid50_Sqrt_combproc: PROCESS (xv4_uid119_finalMult_uid50_Sqrt_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv4_uid119_finalMult_uid50_Sqrt_b) IS
            WHEN "00" => p4_uid120_finalMult_uid50_Sqrt_q <= "000000000000000000000000000100";
            WHEN "01" => p4_uid120_finalMult_uid50_Sqrt_q <= "000101101010000010011110011101";
            WHEN "10" => p4_uid120_finalMult_uid50_Sqrt_q <= "001011010100000100111100110111";
            WHEN "11" => p4_uid120_finalMult_uid50_Sqrt_q <= "010000111110000111011011010000";
            WHEN OTHERS => -- unreachable
                           p4_uid120_finalMult_uid50_Sqrt_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt(ADD,126)@8
    lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_a <= STD_LOGIC_VECTOR("0" & p4_uid120_finalMult_uid50_Sqrt_q);
    lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_b <= STD_LOGIC_VECTOR("0000" & lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select_c);
    lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_a) + UNSIGNED(lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_b));
    lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_q <= lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_o(30 downto 0);

    -- xv3_uid118_finalMult_uid50_Sqrt(BITSELECT,117)@8
    xv3_uid118_finalMult_uid50_Sqrt_in <= result_uid49_Sqrt_b(23 downto 0);
    xv3_uid118_finalMult_uid50_Sqrt_b <= xv3_uid118_finalMult_uid50_Sqrt_in(23 downto 18);

    -- p3_uid121_finalMult_uid50_Sqrt(LOOKUP,120)@8
    p3_uid121_finalMult_uid50_Sqrt_combproc: PROCESS (xv3_uid118_finalMult_uid50_Sqrt_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv3_uid118_finalMult_uid50_Sqrt_b) IS
            WHEN "000000" => p3_uid121_finalMult_uid50_Sqrt_q <= "0000000000000000000000000000";
            WHEN "000001" => p3_uid121_finalMult_uid50_Sqrt_q <= "0000001011010100000100111100";
            WHEN "000010" => p3_uid121_finalMult_uid50_Sqrt_q <= "0000010110101000001001111001";
            WHEN "000011" => p3_uid121_finalMult_uid50_Sqrt_q <= "0000100001111100001110110110";
            WHEN "000100" => p3_uid121_finalMult_uid50_Sqrt_q <= "0000101101010000010011110011";
            WHEN "000101" => p3_uid121_finalMult_uid50_Sqrt_q <= "0000111000100100011000110000";
            WHEN "000110" => p3_uid121_finalMult_uid50_Sqrt_q <= "0001000011111000011101101100";
            WHEN "000111" => p3_uid121_finalMult_uid50_Sqrt_q <= "0001001111001100100010101001";
            WHEN "001000" => p3_uid121_finalMult_uid50_Sqrt_q <= "0001011010100000100111100110";
            WHEN "001001" => p3_uid121_finalMult_uid50_Sqrt_q <= "0001100101110100101100100011";
            WHEN "001010" => p3_uid121_finalMult_uid50_Sqrt_q <= "0001110001001000110001100000";
            WHEN "001011" => p3_uid121_finalMult_uid50_Sqrt_q <= "0001111100011100110110011100";
            WHEN "001100" => p3_uid121_finalMult_uid50_Sqrt_q <= "0010000111110000111011011001";
            WHEN "001101" => p3_uid121_finalMult_uid50_Sqrt_q <= "0010010011000101000000010110";
            WHEN "001110" => p3_uid121_finalMult_uid50_Sqrt_q <= "0010011110011001000101010011";
            WHEN "001111" => p3_uid121_finalMult_uid50_Sqrt_q <= "0010101001101101001010010000";
            WHEN "010000" => p3_uid121_finalMult_uid50_Sqrt_q <= "0010110101000001001111001100";
            WHEN "010001" => p3_uid121_finalMult_uid50_Sqrt_q <= "0011000000010101010100001001";
            WHEN "010010" => p3_uid121_finalMult_uid50_Sqrt_q <= "0011001011101001011001000110";
            WHEN "010011" => p3_uid121_finalMult_uid50_Sqrt_q <= "0011010110111101011110000011";
            WHEN "010100" => p3_uid121_finalMult_uid50_Sqrt_q <= "0011100010010001100011000000";
            WHEN "010101" => p3_uid121_finalMult_uid50_Sqrt_q <= "0011101101100101100111111100";
            WHEN "010110" => p3_uid121_finalMult_uid50_Sqrt_q <= "0011111000111001101100111001";
            WHEN "010111" => p3_uid121_finalMult_uid50_Sqrt_q <= "0100000100001101110001110110";
            WHEN "011000" => p3_uid121_finalMult_uid50_Sqrt_q <= "0100001111100001110110110011";
            WHEN "011001" => p3_uid121_finalMult_uid50_Sqrt_q <= "0100011010110101111011110000";
            WHEN "011010" => p3_uid121_finalMult_uid50_Sqrt_q <= "0100100110001010000000101100";
            WHEN "011011" => p3_uid121_finalMult_uid50_Sqrt_q <= "0100110001011110000101101001";
            WHEN "011100" => p3_uid121_finalMult_uid50_Sqrt_q <= "0100111100110010001010100110";
            WHEN "011101" => p3_uid121_finalMult_uid50_Sqrt_q <= "0101001000000110001111100011";
            WHEN "011110" => p3_uid121_finalMult_uid50_Sqrt_q <= "0101010011011010010100100000";
            WHEN "011111" => p3_uid121_finalMult_uid50_Sqrt_q <= "0101011110101110011001011100";
            WHEN "100000" => p3_uid121_finalMult_uid50_Sqrt_q <= "0101101010000010011110011001";
            WHEN "100001" => p3_uid121_finalMult_uid50_Sqrt_q <= "0101110101010110100011010110";
            WHEN "100010" => p3_uid121_finalMult_uid50_Sqrt_q <= "0110000000101010101000010011";
            WHEN "100011" => p3_uid121_finalMult_uid50_Sqrt_q <= "0110001011111110101101010000";
            WHEN "100100" => p3_uid121_finalMult_uid50_Sqrt_q <= "0110010111010010110010001100";
            WHEN "100101" => p3_uid121_finalMult_uid50_Sqrt_q <= "0110100010100110110111001001";
            WHEN "100110" => p3_uid121_finalMult_uid50_Sqrt_q <= "0110101101111010111100000110";
            WHEN "100111" => p3_uid121_finalMult_uid50_Sqrt_q <= "0110111001001111000001000011";
            WHEN "101000" => p3_uid121_finalMult_uid50_Sqrt_q <= "0111000100100011000110000000";
            WHEN "101001" => p3_uid121_finalMult_uid50_Sqrt_q <= "0111001111110111001010111100";
            WHEN "101010" => p3_uid121_finalMult_uid50_Sqrt_q <= "0111011011001011001111111001";
            WHEN "101011" => p3_uid121_finalMult_uid50_Sqrt_q <= "0111100110011111010100110110";
            WHEN "101100" => p3_uid121_finalMult_uid50_Sqrt_q <= "0111110001110011011001110011";
            WHEN "101101" => p3_uid121_finalMult_uid50_Sqrt_q <= "0111111101000111011110110000";
            WHEN "101110" => p3_uid121_finalMult_uid50_Sqrt_q <= "1000001000011011100011101100";
            WHEN "101111" => p3_uid121_finalMult_uid50_Sqrt_q <= "1000010011101111101000101001";
            WHEN "110000" => p3_uid121_finalMult_uid50_Sqrt_q <= "1000011111000011101101100110";
            WHEN "110001" => p3_uid121_finalMult_uid50_Sqrt_q <= "1000101010010111110010100011";
            WHEN "110010" => p3_uid121_finalMult_uid50_Sqrt_q <= "1000110101101011110111100000";
            WHEN "110011" => p3_uid121_finalMult_uid50_Sqrt_q <= "1001000000111111111100011100";
            WHEN "110100" => p3_uid121_finalMult_uid50_Sqrt_q <= "1001001100010100000001011001";
            WHEN "110101" => p3_uid121_finalMult_uid50_Sqrt_q <= "1001010111101000000110010110";
            WHEN "110110" => p3_uid121_finalMult_uid50_Sqrt_q <= "1001100010111100001011010011";
            WHEN "110111" => p3_uid121_finalMult_uid50_Sqrt_q <= "1001101110010000010000010000";
            WHEN "111000" => p3_uid121_finalMult_uid50_Sqrt_q <= "1001111001100100010101001100";
            WHEN "111001" => p3_uid121_finalMult_uid50_Sqrt_q <= "1010000100111000011010001001";
            WHEN "111010" => p3_uid121_finalMult_uid50_Sqrt_q <= "1010010000001100011111000110";
            WHEN "111011" => p3_uid121_finalMult_uid50_Sqrt_q <= "1010011011100000100100000011";
            WHEN "111100" => p3_uid121_finalMult_uid50_Sqrt_q <= "1010100110110100101001000000";
            WHEN "111101" => p3_uid121_finalMult_uid50_Sqrt_q <= "1010110010001000101101111100";
            WHEN "111110" => p3_uid121_finalMult_uid50_Sqrt_q <= "1010111101011100110010111001";
            WHEN "111111" => p3_uid121_finalMult_uid50_Sqrt_q <= "1011001000110000110111110110";
            WHEN OTHERS => -- unreachable
                           p3_uid121_finalMult_uid50_Sqrt_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select(BITSELECT,244)@8
    lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select_b <= p3_uid121_finalMult_uid50_Sqrt_q(0 downto 0);
    lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select_c <= p3_uid121_finalMult_uid50_Sqrt_q(27 downto 1);

    -- lev1_a0_uid128_finalMult_uid50_Sqrt(BITJOIN,127)@8
    lev1_a0_uid128_finalMult_uid50_Sqrt_q <= lev1_a0sumAHighB_uid127_finalMult_uid50_Sqrt_q & lowRangeB_uid125_finalMult_uid50_Sqrt_merged_bit_select_b;

    -- lev2_a0_uid130_finalMult_uid50_Sqrt(ADD,129)@8
    lev2_a0_uid130_finalMult_uid50_Sqrt_a <= STD_LOGIC_VECTOR("0" & lev1_a0_uid128_finalMult_uid50_Sqrt_q);
    lev2_a0_uid130_finalMult_uid50_Sqrt_b <= STD_LOGIC_VECTOR("0000000000" & lev1_a1_uid129_finalMult_uid50_Sqrt_q);
    lev2_a0_uid130_finalMult_uid50_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev2_a0_uid130_finalMult_uid50_Sqrt_a) + UNSIGNED(lev2_a0_uid130_finalMult_uid50_Sqrt_b));
    lev2_a0_uid130_finalMult_uid50_Sqrt_q <= lev2_a0_uid130_finalMult_uid50_Sqrt_o(32 downto 0);

    -- lev3_a0_uid131_finalMult_uid50_Sqrt(ADD,130)@8
    lev3_a0_uid131_finalMult_uid50_Sqrt_a <= STD_LOGIC_VECTOR("0" & lev2_a0_uid130_finalMult_uid50_Sqrt_q);
    lev3_a0_uid131_finalMult_uid50_Sqrt_b <= STD_LOGIC_VECTOR("000000000000000000000000" & p0_uid124_finalMult_uid50_Sqrt_q);
    lev3_a0_uid131_finalMult_uid50_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(lev3_a0_uid131_finalMult_uid50_Sqrt_a) + UNSIGNED(lev3_a0_uid131_finalMult_uid50_Sqrt_b));
    lev3_a0_uid131_finalMult_uid50_Sqrt_q <= lev3_a0_uid131_finalMult_uid50_Sqrt_o(33 downto 0);

    -- sR_uid141_finalMult_uid50_Sqrt(BITSELECT,140)@8
    sR_uid141_finalMult_uid50_Sqrt_in <= lev3_a0_uid131_finalMult_uid50_Sqrt_q(29 downto 0);
    sR_uid141_finalMult_uid50_Sqrt_b <= sR_uid141_finalMult_uid50_Sqrt_in(29 downto 4);

    -- updatedX_uid135_finalMult_uid50_Sqrt(BITJOIN,134)@8
    updatedX_uid135_finalMult_uid50_Sqrt_q <= maxValInOutFormat_uid132_finalMult_uid50_Sqrt_q & zs_uid98_leadingZeros_uid15_Sqrt_q;

    -- ovf_uid134_finalMult_uid50_Sqrt(COMPARE,135)@8
    ovf_uid134_finalMult_uid50_Sqrt_a <= STD_LOGIC_VECTOR("000000" & updatedX_uid135_finalMult_uid50_Sqrt_q);
    ovf_uid134_finalMult_uid50_Sqrt_b <= STD_LOGIC_VECTOR("00" & lev3_a0_uid131_finalMult_uid50_Sqrt_q);
    ovf_uid134_finalMult_uid50_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(ovf_uid134_finalMult_uid50_Sqrt_a) - UNSIGNED(ovf_uid134_finalMult_uid50_Sqrt_b));
    ovf_uid134_finalMult_uid50_Sqrt_c(0) <= ovf_uid134_finalMult_uid50_Sqrt_o(35);

    -- updatedY_uid138_finalMult_uid50_Sqrt(BITJOIN,137)@8
    updatedY_uid138_finalMult_uid50_Sqrt_q <= minValueInFormat_uid133_finalMult_uid50_Sqrt_q & zs_uid98_leadingZeros_uid15_Sqrt_q;

    -- udf_uid137_finalMult_uid50_Sqrt(COMPARE,138)@8
    udf_uid137_finalMult_uid50_Sqrt_a <= STD_LOGIC_VECTOR("00" & lev3_a0_uid131_finalMult_uid50_Sqrt_q);
    udf_uid137_finalMult_uid50_Sqrt_b <= STD_LOGIC_VECTOR("000000" & updatedY_uid138_finalMult_uid50_Sqrt_q);
    udf_uid137_finalMult_uid50_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(udf_uid137_finalMult_uid50_Sqrt_a) - UNSIGNED(udf_uid137_finalMult_uid50_Sqrt_b));
    udf_uid137_finalMult_uid50_Sqrt_c(0) <= udf_uid137_finalMult_uid50_Sqrt_o(35);

    -- ovfudfcond_uid140_finalMult_uid50_Sqrt(BITJOIN,139)@8
    ovfudfcond_uid140_finalMult_uid50_Sqrt_q <= ovf_uid134_finalMult_uid50_Sqrt_c & udf_uid137_finalMult_uid50_Sqrt_c;

    -- sRA0_uid142_finalMult_uid50_Sqrt(MUX,141)@8
    sRA0_uid142_finalMult_uid50_Sqrt_s <= ovfudfcond_uid140_finalMult_uid50_Sqrt_q;
    sRA0_uid142_finalMult_uid50_Sqrt_combproc: PROCESS (sRA0_uid142_finalMult_uid50_Sqrt_s, sR_uid141_finalMult_uid50_Sqrt_b, minValueInFormat_uid133_finalMult_uid50_Sqrt_q, maxValInOutFormat_uid132_finalMult_uid50_Sqrt_q)
    BEGIN
        CASE (sRA0_uid142_finalMult_uid50_Sqrt_s) IS
            WHEN "00" => sRA0_uid142_finalMult_uid50_Sqrt_q <= sR_uid141_finalMult_uid50_Sqrt_b;
            WHEN "01" => sRA0_uid142_finalMult_uid50_Sqrt_q <= minValueInFormat_uid133_finalMult_uid50_Sqrt_q;
            WHEN "10" => sRA0_uid142_finalMult_uid50_Sqrt_q <= maxValInOutFormat_uid132_finalMult_uid50_Sqrt_q;
            WHEN "11" => sRA0_uid142_finalMult_uid50_Sqrt_q <= maxValInOutFormat_uid132_finalMult_uid50_Sqrt_q;
            WHEN OTHERS => sRA0_uid142_finalMult_uid50_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- finalMultLSBRange_uid51_Sqrt(BITSELECT,50)@8
    finalMultLSBRange_uid51_Sqrt_b <= sRA0_uid142_finalMult_uid50_Sqrt_q(25 downto 1);

    -- negShiftOdd_uid54_Sqrt(BITSELECT,53)@8
    negShiftOdd_uid54_Sqrt_b <= finalMultLSBRange_uid51_Sqrt_b(24 downto 24);

    -- negShiftOdd_uid55_Sqrt(LOGICAL,54)@8
    negShiftOdd_uid55_Sqrt_q <= not (negShiftOdd_uid54_Sqrt_b);

    -- parityOddOriginalInv_uid21_Sqrt(LOGICAL,20)@8
    parityOddOriginalInv_uid21_Sqrt_q <= not (parityOddOriginal_uid20_Sqrt_b);

    -- OddBranchAndNegUpdate_uid58_Sqrt(LOGICAL,57)@8
    OddBranchAndNegUpdate_uid58_Sqrt_q <= parityOddOriginalInv_uid21_Sqrt_q and negShiftOdd_uid55_Sqrt_q;

    -- shiftUpdateValue_uid59_Sqrt(LOGICAL,58)@8
    shiftUpdateValue_uid59_Sqrt_q <= OddBranchAndNegUpdate_uid58_Sqrt_q or EvenBranchAndNegUpdate_uid57_Sqrt_q;

    -- inExponent_uid17_Sqrt(SUB,16)@8
    inExponent_uid17_Sqrt_a <= STD_LOGIC_VECTOR("0" & shiftConstant_uid16_Sqrt_q);
    inExponent_uid17_Sqrt_b <= STD_LOGIC_VECTOR("00" & redist0_r_uid113_leadingZeros_uid15_Sqrt_q_5_q);
    inExponent_uid17_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(inExponent_uid17_Sqrt_a) - UNSIGNED(inExponent_uid17_Sqrt_b));
    inExponent_uid17_Sqrt_q <= inExponent_uid17_Sqrt_o(6 downto 0);

    -- outExponentOdd_uid25_Sqrt(ADD,24)@8
    outExponentOdd_uid25_Sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((8 downto 7 => inExponent_uid17_Sqrt_q(6)) & inExponent_uid17_Sqrt_q));
    outExponentOdd_uid25_Sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & VCC_q));
    outExponentOdd_uid25_Sqrt_o <= STD_LOGIC_VECTOR(SIGNED(outExponentOdd_uid25_Sqrt_a) + SIGNED(outExponentOdd_uid25_Sqrt_b));
    outExponentOdd_uid25_Sqrt_q <= outExponentOdd_uid25_Sqrt_o(7 downto 0);

    -- outExponentOdd_uid26_Sqrt(BITSELECT,25)@8
    outExponentOdd_uid26_Sqrt_in <= STD_LOGIC_VECTOR(outExponentOdd_uid25_Sqrt_q(6 downto 0));
    outExponentOdd_uid26_Sqrt_b <= STD_LOGIC_VECTOR(outExponentOdd_uid26_Sqrt_in(6 downto 1));

    -- outExponentEven_uid27_Sqrt(BITSELECT,26)@8
    outExponentEven_uid27_Sqrt_b <= STD_LOGIC_VECTOR(inExponent_uid17_Sqrt_q(6 downto 1));

    -- outputExponent_uid28_Sqrt(MUX,27)@8
    outputExponent_uid28_Sqrt_s <= parityOddOriginalInv_uid21_Sqrt_q;
    outputExponent_uid28_Sqrt_combproc: PROCESS (outputExponent_uid28_Sqrt_s, outExponentEven_uid27_Sqrt_b, outExponentOdd_uid26_Sqrt_b)
    BEGIN
        CASE (outputExponent_uid28_Sqrt_s) IS
            WHEN "0" => outputExponent_uid28_Sqrt_q <= outExponentEven_uid27_Sqrt_b;
            WHEN "1" => outputExponent_uid28_Sqrt_q <= outExponentOdd_uid26_Sqrt_b;
            WHEN OTHERS => outputExponent_uid28_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftConstant_uid16_Sqrt(CONSTANT,15)
    shiftConstant_uid16_Sqrt_q <= "010111";

    -- shiftOutVal_uid30_Sqrt(SUB,29)@8
    shiftOutVal_uid30_Sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((6 downto 6 => shiftConstant_uid16_Sqrt_q(5)) & shiftConstant_uid16_Sqrt_q));
    shiftOutVal_uid30_Sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((6 downto 6 => outputExponent_uid28_Sqrt_q(5)) & outputExponent_uid28_Sqrt_q));
    shiftOutVal_uid30_Sqrt_o <= STD_LOGIC_VECTOR(SIGNED(shiftOutVal_uid30_Sqrt_a) - SIGNED(shiftOutVal_uid30_Sqrt_b));
    shiftOutVal_uid30_Sqrt_q <= shiftOutVal_uid30_Sqrt_o(6 downto 0);

    -- shiftOutValUpdated_uid66_Sqrt(ADD,65)@8
    shiftOutValUpdated_uid66_Sqrt_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((8 downto 7 => shiftOutVal_uid30_Sqrt_q(6)) & shiftOutVal_uid30_Sqrt_q));
    shiftOutValUpdated_uid66_Sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000" & shiftUpdateValue_uid59_Sqrt_q));
    shiftOutValUpdated_uid66_Sqrt_o <= STD_LOGIC_VECTOR(SIGNED(shiftOutValUpdated_uid66_Sqrt_a) + SIGNED(shiftOutValUpdated_uid66_Sqrt_b));
    shiftOutValUpdated_uid66_Sqrt_q <= shiftOutValUpdated_uid66_Sqrt_o(7 downto 0);

    -- sat_uid67_Sqrt(BITSELECT,66)@8
    sat_uid67_Sqrt_b <= STD_LOGIC_VECTOR(shiftOutValUpdated_uid66_Sqrt_q(7 downto 7));

    -- satOrOvfPostRnd_uid76_Sqrt(LOGICAL,75)@8
    satOrOvfPostRnd_uid76_Sqrt_q <= sat_uid67_Sqrt_b or resultFinalPreSat_uid74_Sqrt_merged_bit_select_c;

    -- zeroOutCst_uid235_xRightShiftFinal_uid69_Sqrt(CONSTANT,234)
    zeroOutCst_uid235_xRightShiftFinal_uid69_Sqrt_q <= "0000000000000000000000000";

    -- rightShiftStage2Idx1Rng1_uid230_xRightShiftFinal_uid69_Sqrt(BITSELECT,229)@8
    rightShiftStage2Idx1Rng1_uid230_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q(24 downto 1);

    -- rightShiftStage2Idx1_uid232_xRightShiftFinal_uid69_Sqrt(BITJOIN,231)@8
    rightShiftStage2Idx1_uid232_xRightShiftFinal_uid69_Sqrt_q <= GND_q & rightShiftStage2Idx1Rng1_uid230_xRightShiftFinal_uid69_Sqrt_b;

    -- rightShiftStage1Idx3Rng6_uid225_xRightShiftFinal_uid69_Sqrt(BITSELECT,224)@8
    rightShiftStage1Idx3Rng6_uid225_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q(24 downto 6);

    -- rightShiftStage1Idx3_uid227_xRightShiftFinal_uid69_Sqrt(BITJOIN,226)@8
    rightShiftStage1Idx3_uid227_xRightShiftFinal_uid69_Sqrt_q <= leftShiftStage1Idx3Pad6_uid188_xLeftShift_uid31_Sqrt_q & rightShiftStage1Idx3Rng6_uid225_xRightShiftFinal_uid69_Sqrt_b;

    -- rightShiftStage1Idx2Rng4_uid222_xRightShiftFinal_uid69_Sqrt(BITSELECT,221)@8
    rightShiftStage1Idx2Rng4_uid222_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q(24 downto 4);

    -- rightShiftStage1Idx2_uid224_xRightShiftFinal_uid69_Sqrt(BITJOIN,223)@8
    rightShiftStage1Idx2_uid224_xRightShiftFinal_uid69_Sqrt_q <= zs_uid98_leadingZeros_uid15_Sqrt_q & rightShiftStage1Idx2Rng4_uid222_xRightShiftFinal_uid69_Sqrt_b;

    -- rightShiftStage1Idx1Rng2_uid219_xRightShiftFinal_uid69_Sqrt(BITSELECT,218)@8
    rightShiftStage1Idx1Rng2_uid219_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q(24 downto 2);

    -- rightShiftStage1Idx1_uid221_xRightShiftFinal_uid69_Sqrt(BITJOIN,220)@8
    rightShiftStage1Idx1_uid221_xRightShiftFinal_uid69_Sqrt_q <= zs_uid104_leadingZeros_uid15_Sqrt_q & rightShiftStage1Idx1Rng2_uid219_xRightShiftFinal_uid69_Sqrt_b;

    -- rightShiftStage0Idx3Rng24_uid214_xRightShiftFinal_uid69_Sqrt(BITSELECT,213)@8
    rightShiftStage0Idx3Rng24_uid214_xRightShiftFinal_uid69_Sqrt_b <= shifterInData_uid65_Sqrt_q(24 downto 24);

    -- rightShiftStage0Idx3_uid216_xRightShiftFinal_uid69_Sqrt(BITJOIN,215)@8
    rightShiftStage0Idx3_uid216_xRightShiftFinal_uid69_Sqrt_q <= cst0ForNegInput_uid12_Sqrt_q & rightShiftStage0Idx3Rng24_uid214_xRightShiftFinal_uid69_Sqrt_b;

    -- rightShiftStage0Idx2Rng16_uid211_xRightShiftFinal_uid69_Sqrt(BITSELECT,210)@8
    rightShiftStage0Idx2Rng16_uid211_xRightShiftFinal_uid69_Sqrt_b <= shifterInData_uid65_Sqrt_q(24 downto 16);

    -- rightShiftStage0Idx2_uid213_xRightShiftFinal_uid69_Sqrt(BITJOIN,212)@8
    rightShiftStage0Idx2_uid213_xRightShiftFinal_uid69_Sqrt_q <= zs_uid84_leadingZeros_uid15_Sqrt_q & rightShiftStage0Idx2Rng16_uid211_xRightShiftFinal_uid69_Sqrt_b;

    -- rightShiftStage0Idx1Rng8_uid208_xRightShiftFinal_uid69_Sqrt(BITSELECT,207)@8
    rightShiftStage0Idx1Rng8_uid208_xRightShiftFinal_uid69_Sqrt_b <= shifterInData_uid65_Sqrt_q(24 downto 8);

    -- rightShiftStage0Idx1_uid210_xRightShiftFinal_uid69_Sqrt(BITJOIN,209)@8
    rightShiftStage0Idx1_uid210_xRightShiftFinal_uid69_Sqrt_q <= zs_uid92_leadingZeros_uid15_Sqrt_q & rightShiftStage0Idx1Rng8_uid208_xRightShiftFinal_uid69_Sqrt_b;

    -- finalMultBottomBits_uid61_Sqrt(BITSELECT,60)@8
    finalMultBottomBits_uid61_Sqrt_in <= sRA0_uid142_finalMult_uid50_Sqrt_q(24 downto 0);
    finalMultBottomBits_uid61_Sqrt_b <= finalMultBottomBits_uid61_Sqrt_in(24 downto 0);

    -- resultBottomBits_uid62_Sqrt(BITSELECT,61)@8
    resultBottomBits_uid62_Sqrt_in <= result_uid49_Sqrt_b(24 downto 0);
    resultBottomBits_uid62_Sqrt_b <= resultBottomBits_uid62_Sqrt_in(24 downto 0);

    -- resultUpperRange_uid64_Sqrt(BITSELECT,63)@8
    resultUpperRange_uid64_Sqrt_b <= result_uid49_Sqrt_b(25 downto 1);

    -- negShiftEvenParityOdd_uid60_Sqrt(BITJOIN,59)@8
    negShiftEvenParityOdd_uid60_Sqrt_q <= shiftUpdateValue_uid59_Sqrt_q & parityOddOriginalInv_uid21_Sqrt_q;

    -- shifterInData_uid65_Sqrt(MUX,64)@8
    shifterInData_uid65_Sqrt_s <= negShiftEvenParityOdd_uid60_Sqrt_q;
    shifterInData_uid65_Sqrt_combproc: PROCESS (shifterInData_uid65_Sqrt_s, resultUpperRange_uid64_Sqrt_b, finalMultLSBRange_uid51_Sqrt_b, resultBottomBits_uid62_Sqrt_b, finalMultBottomBits_uid61_Sqrt_b)
    BEGIN
        CASE (shifterInData_uid65_Sqrt_s) IS
            WHEN "00" => shifterInData_uid65_Sqrt_q <= resultUpperRange_uid64_Sqrt_b;
            WHEN "01" => shifterInData_uid65_Sqrt_q <= finalMultLSBRange_uid51_Sqrt_b;
            WHEN "10" => shifterInData_uid65_Sqrt_q <= resultBottomBits_uid62_Sqrt_b;
            WHEN "11" => shifterInData_uid65_Sqrt_q <= finalMultBottomBits_uid61_Sqrt_b;
            WHEN OTHERS => shifterInData_uid65_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt(BITSELECT,216)@8
    rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt_in <= shiftOutValUpdated_uid66_Sqrt_q(4 downto 0);
    rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt_in(4 downto 3);

    -- rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt(MUX,217)@8
    rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_s <= rightShiftStageSel4Dto3_uid217_xRightShiftFinal_uid69_Sqrt_b;
    rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_combproc: PROCESS (rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_s, shifterInData_uid65_Sqrt_q, rightShiftStage0Idx1_uid210_xRightShiftFinal_uid69_Sqrt_q, rightShiftStage0Idx2_uid213_xRightShiftFinal_uid69_Sqrt_q, rightShiftStage0Idx3_uid216_xRightShiftFinal_uid69_Sqrt_q)
    BEGIN
        CASE (rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_s) IS
            WHEN "00" => rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q <= shifterInData_uid65_Sqrt_q;
            WHEN "01" => rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage0Idx1_uid210_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "10" => rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage0Idx2_uid213_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "11" => rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage0Idx3_uid216_xRightShiftFinal_uid69_Sqrt_q;
            WHEN OTHERS => rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt(BITSELECT,227)@8
    rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt_in <= shiftOutValUpdated_uid66_Sqrt_q(2 downto 0);
    rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt_in(2 downto 1);

    -- rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt(MUX,228)@8
    rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_s <= rightShiftStageSel2Dto1_uid228_xRightShiftFinal_uid69_Sqrt_b;
    rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_combproc: PROCESS (rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_s, rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q, rightShiftStage1Idx1_uid221_xRightShiftFinal_uid69_Sqrt_q, rightShiftStage1Idx2_uid224_xRightShiftFinal_uid69_Sqrt_q, rightShiftStage1Idx3_uid227_xRightShiftFinal_uid69_Sqrt_q)
    BEGIN
        CASE (rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_s) IS
            WHEN "00" => rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage0_uid218_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "01" => rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage1Idx1_uid221_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "10" => rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage1Idx2_uid224_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "11" => rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage1Idx3_uid227_xRightShiftFinal_uid69_Sqrt_q;
            WHEN OTHERS => rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt(BITSELECT,232)@8
    rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt_in <= shiftOutValUpdated_uid66_Sqrt_q(0 downto 0);
    rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt_b <= rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt_in(0 downto 0);

    -- rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt(MUX,233)@8
    rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_s <= rightShiftStageSel0Dto0_uid233_xRightShiftFinal_uid69_Sqrt_b;
    rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_combproc: PROCESS (rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_s, rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q, rightShiftStage2Idx1_uid232_xRightShiftFinal_uid69_Sqrt_q)
    BEGIN
        CASE (rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_s) IS
            WHEN "0" => rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage1_uid229_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "1" => rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage2Idx1_uid232_xRightShiftFinal_uid69_Sqrt_q;
            WHEN OTHERS => rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid206_xRightShiftFinal_uid69_Sqrt(CONSTANT,205)
    wIntCst_uid206_xRightShiftFinal_uid69_Sqrt_q <= "11001";

    -- shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt(COMPARE,206)@8
    shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_a <= STD_LOGIC_VECTOR("00" & shiftOutValUpdated_uid66_Sqrt_q);
    shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid206_xRightShiftFinal_uid69_Sqrt_q);
    shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_a) - UNSIGNED(shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_b));
    shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_n(0) <= not (shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_o(9));

    -- r_uid236_xRightShiftFinal_uid69_Sqrt(MUX,235)@8
    r_uid236_xRightShiftFinal_uid69_Sqrt_s <= shiftedOut_uid207_xRightShiftFinal_uid69_Sqrt_n;
    r_uid236_xRightShiftFinal_uid69_Sqrt_combproc: PROCESS (r_uid236_xRightShiftFinal_uid69_Sqrt_s, rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_q, zeroOutCst_uid235_xRightShiftFinal_uid69_Sqrt_q)
    BEGIN
        CASE (r_uid236_xRightShiftFinal_uid69_Sqrt_s) IS
            WHEN "0" => r_uid236_xRightShiftFinal_uid69_Sqrt_q <= rightShiftStage2_uid234_xRightShiftFinal_uid69_Sqrt_q;
            WHEN "1" => r_uid236_xRightShiftFinal_uid69_Sqrt_q <= zeroOutCst_uid235_xRightShiftFinal_uid69_Sqrt_q;
            WHEN OTHERS => r_uid236_xRightShiftFinal_uid69_Sqrt_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- resultFinalPostRnd_uid73_Sqrt(ADD,72)@8
    resultFinalPostRnd_uid73_Sqrt_a <= STD_LOGIC_VECTOR("0" & r_uid236_xRightShiftFinal_uid69_Sqrt_q);
    resultFinalPostRnd_uid73_Sqrt_b <= STD_LOGIC_VECTOR("0000000000000000000000000" & VCC_q);
    resultFinalPostRnd_uid73_Sqrt_o <= STD_LOGIC_VECTOR(UNSIGNED(resultFinalPostRnd_uid73_Sqrt_a) + UNSIGNED(resultFinalPostRnd_uid73_Sqrt_b));
    resultFinalPostRnd_uid73_Sqrt_q <= resultFinalPostRnd_uid73_Sqrt_o(25 downto 0);

    -- resultFinalPreSat_uid74_Sqrt_merged_bit_select(BITSELECT,240)@8
    resultFinalPreSat_uid74_Sqrt_merged_bit_select_b <= resultFinalPostRnd_uid73_Sqrt_q(24 downto 1);
    resultFinalPreSat_uid74_Sqrt_merged_bit_select_c <= resultFinalPostRnd_uid73_Sqrt_q(25 downto 25);

    -- resultFinalPostOvf_uid77_Sqrt(LOGICAL,76)@8
    resultFinalPostOvf_uid77_Sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 1 => satOrOvfPostRnd_uid76_Sqrt_q(0)) & satOrOvfPostRnd_uid76_Sqrt_q));
    resultFinalPostOvf_uid77_Sqrt_q <= resultFinalPreSat_uid74_Sqrt_merged_bit_select_b or resultFinalPostOvf_uid77_Sqrt_b;

    -- resultFinal_uid81_Sqrt(LOGICAL,80)@8
    resultFinal_uid81_Sqrt_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 1 => inputNotAllZeros_uid80_Sqrt_q(0)) & inputNotAllZeros_uid80_Sqrt_q));
    resultFinal_uid81_Sqrt_q <= resultFinalPostOvf_uid77_Sqrt_q and resultFinal_uid81_Sqrt_b;

    -- resultFinalPostSignedOutput_uid82_Sqrt(BITJOIN,81)@8
    resultFinalPostSignedOutput_uid82_Sqrt_q <= GND_q & resultFinal_uid81_Sqrt_q;

    -- Convert_sel_x(BITSELECT,2)@8
    Convert_sel_x_b <= STD_LOGIC_VECTOR(resultFinalPostSignedOutput_uid82_Sqrt_q(11 downto 0));

    -- redist6_Convert_sel_x_b_1(DELAY,251)
    redist6_Convert_sel_x_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => Convert_sel_x_b, xout => redist6_Convert_sel_x_b_1_q, clk => clk, aclr => areset_n );

    -- redist5_ChannelIn_in_4_dc_9_notEnable(LOGICAL,259)
    redist5_ChannelIn_in_4_dc_9_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist5_ChannelIn_in_4_dc_9_nor(LOGICAL,260)
    redist5_ChannelIn_in_4_dc_9_nor_q <= not (redist5_ChannelIn_in_4_dc_9_notEnable_q or redist5_ChannelIn_in_4_dc_9_sticky_ena_q);

    -- redist5_ChannelIn_in_4_dc_9_mem_last(CONSTANT,256)
    redist5_ChannelIn_in_4_dc_9_mem_last_q <= "0101";

    -- redist5_ChannelIn_in_4_dc_9_cmp(LOGICAL,257)
    redist5_ChannelIn_in_4_dc_9_cmp_b <= STD_LOGIC_VECTOR("0" & redist5_ChannelIn_in_4_dc_9_rdcnt_q);
    redist5_ChannelIn_in_4_dc_9_cmp_q <= "1" WHEN redist5_ChannelIn_in_4_dc_9_mem_last_q = redist5_ChannelIn_in_4_dc_9_cmp_b ELSE "0";

    -- redist5_ChannelIn_in_4_dc_9_cmpReg(REG,258)
    redist5_ChannelIn_in_4_dc_9_cmpReg_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_4_dc_9_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist5_ChannelIn_in_4_dc_9_cmpReg_q <= STD_LOGIC_VECTOR(redist5_ChannelIn_in_4_dc_9_cmp_q);
        END IF;
    END PROCESS;

    -- redist5_ChannelIn_in_4_dc_9_sticky_ena(REG,261)
    redist5_ChannelIn_in_4_dc_9_sticky_ena_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_4_dc_9_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist5_ChannelIn_in_4_dc_9_nor_q = "1") THEN
                redist5_ChannelIn_in_4_dc_9_sticky_ena_q <= STD_LOGIC_VECTOR(redist5_ChannelIn_in_4_dc_9_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_ChannelIn_in_4_dc_9_enaAnd(LOGICAL,262)
    redist5_ChannelIn_in_4_dc_9_enaAnd_q <= redist5_ChannelIn_in_4_dc_9_sticky_ena_q and VCC_q;

    -- redist5_ChannelIn_in_4_dc_9_rdcnt(COUNTER,254)
    -- low=0, high=6, step=1, init=0
    redist5_ChannelIn_in_4_dc_9_rdcnt_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_4_dc_9_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist5_ChannelIn_in_4_dc_9_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (redist5_ChannelIn_in_4_dc_9_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                redist5_ChannelIn_in_4_dc_9_rdcnt_eq <= '1';
            ELSE
                redist5_ChannelIn_in_4_dc_9_rdcnt_eq <= '0';
            END IF;
            IF (redist5_ChannelIn_in_4_dc_9_rdcnt_eq = '1') THEN
                redist5_ChannelIn_in_4_dc_9_rdcnt_i <= redist5_ChannelIn_in_4_dc_9_rdcnt_i + 2;
            ELSE
                redist5_ChannelIn_in_4_dc_9_rdcnt_i <= redist5_ChannelIn_in_4_dc_9_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist5_ChannelIn_in_4_dc_9_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist5_ChannelIn_in_4_dc_9_rdcnt_i, 3)));

    -- redist5_ChannelIn_in_4_dc_9_wraddr(REG,255)
    redist5_ChannelIn_in_4_dc_9_wraddr_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            redist5_ChannelIn_in_4_dc_9_wraddr_q <= "110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            redist5_ChannelIn_in_4_dc_9_wraddr_q <= STD_LOGIC_VECTOR(redist5_ChannelIn_in_4_dc_9_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist5_ChannelIn_in_4_dc_9_mem(DUALMEM,253)
    redist5_ChannelIn_in_4_dc_9_mem_ia <= STD_LOGIC_VECTOR(in_4_dc);
    redist5_ChannelIn_in_4_dc_9_mem_aa <= redist5_ChannelIn_in_4_dc_9_wraddr_q;
    redist5_ChannelIn_in_4_dc_9_mem_ab <= redist5_ChannelIn_in_4_dc_9_rdcnt_q;
    redist5_ChannelIn_in_4_dc_9_mem_reset0 <= not (areset_n);
    redist5_ChannelIn_in_4_dc_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 7,
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
        clocken1 => redist5_ChannelIn_in_4_dc_9_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => redist5_ChannelIn_in_4_dc_9_mem_reset0,
        clock1 => clk,
        address_a => redist5_ChannelIn_in_4_dc_9_mem_aa,
        data_a => redist5_ChannelIn_in_4_dc_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist5_ChannelIn_in_4_dc_9_mem_ab,
        q_b => redist5_ChannelIn_in_4_dc_9_mem_iq
    );
    redist5_ChannelIn_in_4_dc_9_mem_q <= redist5_ChannelIn_in_4_dc_9_mem_iq(7 downto 0);

    -- redist5_ChannelIn_in_4_dc_9_outputreg(DELAY,252)
    redist5_ChannelIn_in_4_dc_9_outputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist5_ChannelIn_in_4_dc_9_mem_q, xout => redist5_ChannelIn_in_4_dc_9_outputreg_q, clk => clk, aclr => areset_n );

    -- redist4_ChannelIn_in_3_dv_9(DELAY,249)
    redist4_ChannelIn_in_3_dv_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_3_dv, xout => redist4_ChannelIn_in_3_dv_9_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,5)@9 + 1
    out_1_qv <= redist4_ChannelIn_in_3_dv_9_q;
    out_2_qc <= redist5_ChannelIn_in_4_dc_9_outputreg_q;
    out_3_Mag <= redist6_Convert_sel_x_b_1_q;

END normal;
