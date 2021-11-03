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

-- VHDL created from MCC150_TransceiverBPSK_PRBSGenerator
-- VHDL created on Sat May 15 13:20:14 2021


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
entity MCC150_TransceiverBPSK_PRBSGenerator is
    port (
        out_1_qv : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_qc : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_PRBS : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_PRBSGenerator;

architecture normal of MCC150_TransceiverBPSK_PRBSGenerator is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Counter_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Counter_i : UNSIGNED (9 downto 0);
    attribute preserve : boolean;
    attribute preserve of Counter_i : signal is true;
    signal DualMem_reset0 : std_logic;
    signal DualMem_ia : STD_LOGIC_VECTOR (0 downto 0);
    signal DualMem_aa : STD_LOGIC_VECTOR (9 downto 0);
    signal DualMem_ab : STD_LOGIC_VECTOR (9 downto 0);
    signal DualMem_ir : STD_LOGIC_VECTOR (0 downto 0);
    signal DualMem_r : STD_LOGIC_VECTOR (0 downto 0);
    signal Sequence_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Sequence_rsrvd_fix_eq : std_logic;
    signal redist0_Sequence_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_DualMem_r_1_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- Sequence_rsrvd_fix(SEQUENCE,11)@0 + 1
    Sequence_rsrvd_fix_clkproc: PROCESS (clk, areset_n)
        variable Sequence_rsrvd_fix_c : SIGNED(5 downto 0);
    BEGIN
        IF (areset_n = '0') THEN
            Sequence_rsrvd_fix_c := "000110";
            Sequence_rsrvd_fix_q <= "0";
            Sequence_rsrvd_fix_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (VCC_q = "1") THEN
                IF (Sequence_rsrvd_fix_c = "000000") THEN
                    Sequence_rsrvd_fix_eq <= '1';
                ELSE
                    Sequence_rsrvd_fix_eq <= '0';
                END IF;
                IF (Sequence_rsrvd_fix_eq = '1') THEN
                    Sequence_rsrvd_fix_c := Sequence_rsrvd_fix_c + 7;
                ELSE
                    Sequence_rsrvd_fix_c := Sequence_rsrvd_fix_c - 1;
                END IF;
                Sequence_rsrvd_fix_q <= STD_LOGIC_VECTOR(Sequence_rsrvd_fix_c(5 downto 5));
            END IF;
        END IF;
    END PROCESS;

    -- Counter(COUNTER,8)@1 + 1
    -- low=0, high=1023, step=1, init=0
    Counter_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            Counter_i <= TO_UNSIGNED(0, 10);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (Sequence_rsrvd_fix_q = "1") THEN
                Counter_i <= Counter_i + 1;
            END IF;
        END IF;
    END PROCESS;
    Counter_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(Counter_i, 10)));

    -- DualMem(DUALMEM,9)@1 + 2
    -- in ww@20000001
    -- out q@20000003
    DualMem_aa <= Counter_q;
    DualMem_reset0 <= not (areset_n);
    DualMem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 1,
        widthad_a => 10,
        numwords_a => 1024,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("MCC150/MCC150_TransceiverBPSK_PRBSGenerator_DualMem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => '1',
        aclr0 => DualMem_reset0,
        clock0 => clk,
        address_a => DualMem_aa,
        q_a => DualMem_ir
    );
    DualMem_r <= DualMem_ir(0 downto 0);

    -- redist1_DualMem_r_1(DELAY,13)
    redist1_DualMem_r_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => DualMem_r, xout => redist1_DualMem_r_1_q, clk => clk, aclr => areset_n );

    -- Const_rsrvd_fix(CONSTANT,3)
    Const_rsrvd_fix_q <= "0000000000000000";

    -- redist0_Sequence_rsrvd_fix_q_3(DELAY,12)
    redist0_Sequence_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => Sequence_rsrvd_fix_q, xout => redist0_Sequence_rsrvd_fix_q_3_q, clk => clk, aclr => areset_n );

    -- ChannelOut(PORTOUT,2)@4 + 1
    out_1_qv <= redist0_Sequence_rsrvd_fix_q_3_q;
    out_2_qc <= Const_rsrvd_fix_q(7 downto 0);
    out_3_PRBS <= redist1_DualMem_r_1_q;

END normal;
