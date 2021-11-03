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

-- VHDL created from MCC150_TransmitterBPSK
-- VHDL created on Sat Apr 17 15:57:16 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity MCC150_TransmitterBPSK_atb is
end;

architecture normal of MCC150_TransmitterBPSK_atb is

component MCC150_TransmitterBPSK is
    port (
        I_out : out std_logic_vector(11 downto 0);  -- sfix12
        Q_out : out std_logic_vector(11 downto 0);  -- sfix12
        clk : in std_logic;
        areset_n : in std_logic
    );
end component;

component MCC150_TransmitterBPSK_stm is
    port (
        I_out_stm : out std_logic_vector(11 downto 0);
        Q_out_stm : out std_logic_vector(11 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end component;

signal I_out_stm : STD_LOGIC_VECTOR (11 downto 0);
signal Q_out_stm : STD_LOGIC_VECTOR (11 downto 0);
signal I_out_dut : STD_LOGIC_VECTOR (11 downto 0);
signal Q_out_dut : STD_LOGIC_VECTOR (11 downto 0);
        signal clk : std_logic;
        signal areset_n : std_logic;

begin

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


dut : MCC150_TransmitterBPSK port map (
    I_out_dut,
    Q_out_dut,
        clk,
        areset_n
);

sim : MCC150_TransmitterBPSK_stm port map (
    I_out_stm,
    Q_out_stm,
        clk,
        areset_n
);

end normal;
