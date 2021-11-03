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

-- VHDL created from MCC150_TransmitterBPSK_x
-- VHDL created on Wed Apr 14 13:51:15 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.MCC150_TransmitterBPSK_x_safe_path.all;

entity MCC150_TransmitterBPSK_x_stm is
    port (
        I_out_stm : out std_logic_vector(11 downto 0);
        Q_out_stm : out std_logic_vector(11 downto 0);
        clk : out std_logic;
        areset_n : out std_logic
    );
end MCC150_TransmitterBPSK_x_stm;

architecture normal of MCC150_TransmitterBPSK_x_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_n_stm_sig : std_logic := '0';
    signal clk_I_out_stm_sig_stop : std_logic := '0';

    function str_to_stdvec(inp: string) return std_logic_vector is
        variable temp: std_logic_vector(inp'range) := (others => 'X');
    begin
        for i in inp'range loop
            IF ((inp(i) = '1')) THEN
                temp(i) := '1';
            elsif (inp(i) = '0') then
                temp(i) := '0';
            END IF;
            end loop;
            return temp;
        end function str_to_stdvec;
        

    begin

    clk <= clk_stm_sig;
    clk_process: process 
    begin
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 12300 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 12300 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            wait;
        end if;
    end process;

    areset_n <= areset_n_stm_sig;
    areset_n_process: process begin
        areset_n_stm_sig <= '0';
        wait for 18750 ps;
        areset_n_stm_sig <= '1';
        wait;
    end process;

        -- Generating stimulus for I_out
        I_out_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut : text open read_mode is safe_path("MCC150/MCC150_TransmitterBPSK_x_Modulator_ChannelOut.stm");
            variable out_3_I_int_0 : Integer;
            variable out_3_I_temp : std_logic_vector(11 downto 0);

        begin
            -- initialize all outputs to 0
            I_out_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            while true loop
            
                -- (ports connected to I_out)
                IF (endfile(data_file_ChannelOut)) THEN
                    clk_I_out_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_3_I_int_0);
                    out_3_I_temp(11 downto 0) := std_logic_vector(to_unsigned(out_3_I_int_0, 12));
                    I_out_stm <= out_3_I_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;
        -- Driving gnd for Q_out signals

        Q_out_stm <= (others => '0');

    clk_stm_sig_stop <= clk_I_out_stm_sig_stop OR '0';


    END normal;
