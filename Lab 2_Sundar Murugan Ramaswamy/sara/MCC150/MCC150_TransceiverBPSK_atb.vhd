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

-- VHDL created from MCC150_TransceiverBPSK
-- VHDL created on Fri May 07 21:18:36 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity MCC150_TransceiverBPSK_atb is
end;

architecture normal of MCC150_TransceiverBPSK_atb is

component MCC150_TransceiverBPSK is
    port (
        I_in_x : in std_logic_vector(11 downto 0);  -- sfix12
        Q_in : in std_logic_vector(11 downto 0);  -- sfix12
        SampleIndex : in std_logic_vector(2 downto 0);  -- ufix3
        I_out : out std_logic_vector(11 downto 0);  -- sfix12
        Q_out : out std_logic_vector(11 downto 0);  -- sfix12
        Symb_I_x : out std_logic_vector(11 downto 0);  -- sfix12
        Symb_Q : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end component;

component MCC150_TransceiverBPSK_stm is
    port (
        I_in_x_stm : out std_logic_vector(11 downto 0);
        Q_in_stm : out std_logic_vector(11 downto 0);
        SampleIndex_stm : out std_logic_vector(2 downto 0);
        I_out_stm : out std_logic_vector(11 downto 0);
        Q_out_stm : out std_logic_vector(11 downto 0);
        Symb_I_x_stm : out std_logic_vector(11 downto 0);
        Symb_Q_stm : out std_logic_vector(11 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end component;

signal I_in_x_stm : STD_LOGIC_VECTOR (11 downto 0);
signal Q_in_stm : STD_LOGIC_VECTOR (11 downto 0);
signal SampleIndex_stm : STD_LOGIC_VECTOR (2 downto 0);
signal I_out_stm : STD_LOGIC_VECTOR (11 downto 0);
signal Q_out_stm : STD_LOGIC_VECTOR (11 downto 0);
signal Symb_I_x_stm : STD_LOGIC_VECTOR (11 downto 0);
signal Symb_Q_stm : STD_LOGIC_VECTOR (11 downto 0);
signal I_in_x_dut : STD_LOGIC_VECTOR (11 downto 0);
signal Q_in_dut : STD_LOGIC_VECTOR (11 downto 0);
signal SampleIndex_dut : STD_LOGIC_VECTOR (2 downto 0);
signal I_out_dut : STD_LOGIC_VECTOR (11 downto 0);
signal Q_out_dut : STD_LOGIC_VECTOR (11 downto 0);
signal Symb_I_x_dut : STD_LOGIC_VECTOR (11 downto 0);
signal Symb_Q_dut : STD_LOGIC_VECTOR (11 downto 0);
        signal clk : std_logic;
        signal areset_n : std_logic;

begin

-- General Purpose data in real output
checkI_in_x : process (clk, areset_n, I_in_x_dut, I_in_x_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkQ_in : process (clk, areset_n, Q_in_dut, Q_in_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkSampleIndex : process (clk, areset_n, SampleIndex_dut, SampleIndex_stm)
begin
END PROCESS;


-- General Purpose data out check
checkI_out : process (clk, areset_n)
variable mismatch_I_out : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF (areset_n = '0') THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_I_out := FALSE;
        IF ( (I_out_dut /= I_out_stm)) THEN
            mismatch_I_out := TRUE;
            report "Mismatch on device output pin I_out" severity Warning;
        END IF;
        IF (mismatch_I_out) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkSymb_I_x : process (clk, areset_n)
variable mismatch_Symb_I_x : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF (areset_n = '0') THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Symb_I_x := FALSE;
        IF ( (Symb_I_x_dut /= Symb_I_x_stm)) THEN
            mismatch_Symb_I_x := TRUE;
            report "Mismatch on device output pin Symb_I_x" severity Warning;
        END IF;
        IF (mismatch_Symb_I_x) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkSymb_Q : process (clk, areset_n)
variable mismatch_Symb_Q : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF (areset_n = '0') THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Symb_Q := FALSE;
        IF ( (Symb_Q_dut /= Symb_Q_stm)) THEN
            mismatch_Symb_Q := TRUE;
            report "Mismatch on device output pin Symb_Q" severity Warning;
        END IF;
        IF (mismatch_Symb_Q) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


dut : MCC150_TransceiverBPSK port map (
    I_in_x_stm,
    Q_in_stm,
    SampleIndex_stm,
    I_out_dut,
    Q_out_dut,
    Symb_I_x_dut,
    Symb_Q_dut,
        clk,
        areset_n
);

sim : MCC150_TransceiverBPSK_stm port map (
    I_in_x_stm,
    Q_in_stm,
    SampleIndex_stm,
    I_out_stm,
    Q_out_stm,
    Symb_I_x_stm,
    Symb_Q_stm,
        clk,
        areset_n
);

end normal;
