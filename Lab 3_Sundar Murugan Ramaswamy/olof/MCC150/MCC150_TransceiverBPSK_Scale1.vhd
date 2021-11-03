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

-- VHDL created from MCC150_TransceiverBPSK_Scale1
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
entity MCC150_TransceiverBPSK_Scale1 is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(29 downto 0);  -- sfix30
        gain_i : in std_logic_vector(0 downto 0);  -- sfix1
        qOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        qOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        qOut_0 : out std_logic_vector(11 downto 0);  -- sfix12
        eOut_0 : out std_logic_vector(0 downto 0);  -- sfix1
        clk : in std_logic;
        areset_n : in std_logic
    );
end MCC150_TransceiverBPSK_Scale1;

architecture normal of MCC150_TransceiverBPSK_Scale1 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_lowconst_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_highconst_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_mux_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_mux_v : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_rnd_bias_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_xIn_v_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_xIn_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_shiftsel_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_shiftsel_qint : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_rnd_trunc_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_rnd_trunc_qint : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_rnd_add_a : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_rnd_add_b : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_rnd_add_o : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_rnd_add_q : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_rnd_shift_q : STD_LOGIC_VECTOR (17 downto 0);
    signal u0_rnd_shift_qint : STD_LOGIC_VECTOR (18 downto 0);
    signal u0_low_a : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_low_b : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_low_o : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_low_c : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_high_a : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_high_b : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_high_o : STD_LOGIC_VECTOR (19 downto 0);
    signal u0_high_c : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- u0_rnd_bias(CONSTANT,12)
    u0_rnd_bias_q <= "01";

    -- u0_shiftsel(BITSHIFT,4)@0
    u0_shiftsel_qint <= xIn_0;
    u0_shiftsel_q <= u0_shiftsel_qint(29 downto 0);

    -- u0_rnd_trunc(BITSHIFT,13)@0
    u0_rnd_trunc_qint <= u0_shiftsel_q;
    u0_rnd_trunc_q <= u0_rnd_trunc_qint(29 downto 12);

    -- u0_rnd_add(ADD,14)@0
    u0_rnd_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => u0_rnd_trunc_q(17)) & u0_rnd_trunc_q));
    u0_rnd_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 2 => u0_rnd_bias_q(1)) & u0_rnd_bias_q));
    u0_rnd_add_o <= STD_LOGIC_VECTOR(SIGNED(u0_rnd_add_a) + SIGNED(u0_rnd_add_b));
    u0_rnd_add_q <= u0_rnd_add_o(18 downto 0);

    -- u0_rnd_shift(BITSHIFT,15)@0
    u0_rnd_shift_qint <= u0_rnd_add_q;
    u0_rnd_shift_q <= u0_rnd_shift_qint(18 downto 1);

    -- u0_highconst(CONSTANT,7)
    u0_highconst_q <= "011111111111";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- u0_high(COMPARE,9)@0
    u0_high_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 12 => u0_highconst_q(11)) & u0_highconst_q));
    u0_high_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => u0_rnd_shift_q(17)) & u0_rnd_shift_q));
    u0_high_o <= STD_LOGIC_VECTOR(SIGNED(u0_high_a) - SIGNED(u0_high_b));
    u0_high_c(0) <= u0_high_o(19);

    -- u0_lowconst(CONSTANT,6)
    u0_lowconst_q <= "100000000001";

    -- u0_low(COMPARE,8)@0
    u0_low_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => u0_rnd_shift_q(17)) & u0_rnd_shift_q));
    u0_low_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 12 => u0_lowconst_q(11)) & u0_lowconst_q));
    u0_low_o <= STD_LOGIC_VECTOR(SIGNED(u0_low_a) - SIGNED(u0_low_b));
    u0_low_c(0) <= u0_low_o(19);

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- u0_mux(SELECTOR,10)@0 + 1
    u0_mux_clkproc: PROCESS (clk, areset_n)
    BEGIN
        IF (areset_n = '0') THEN
            u0_mux_q <= (others => '0');
            u0_mux_v <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_mux_q <= STD_LOGIC_VECTOR(u0_rnd_shift_q(11 downto 0));
            u0_mux_v <= "0";
            IF (u0_high_c = "1") THEN
                u0_mux_q <= STD_LOGIC_VECTOR(u0_highconst_q);
                u0_mux_v <= "1";
            END IF;
            IF (u0_low_c = "1") THEN
                u0_mux_q <= STD_LOGIC_VECTOR(u0_lowconst_q);
                u0_mux_v <= "1";
            END IF;
        END IF;
    END PROCESS;

    -- redist1_xIn_c_1(DELAY,18)
    redist1_xIn_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xIn_c, xout => redist1_xIn_c_1_q, clk => clk, aclr => areset_n );

    -- redist0_xIn_v_1(DELAY,17)
    redist0_xIn_v_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xIn_v, xout => redist0_xIn_v_1_q, clk => clk, aclr => areset_n );

    -- qOut(PORTOUT,11)@1 + 1
    qOut_v <= redist0_xIn_v_1_q;
    qOut_c <= redist1_xIn_c_1_q;
    qOut_0 <= u0_mux_q;
    eOut_0 <= u0_mux_v;

END normal;
