# Create input clocks
create_clock -period 20.000 -name Master_50M [get_ports {sys_clk}]
create_clock -period 12.500 -name Rx_80M [get_ports {rx_clk_in}]
create_clock -period 12.500 -name Tx_80M [get_ports {tx_clk_out}]

# Create generated clocks
create_generated_clock \
   -name Clk_25M \
   -source [get_ports {sys_clk}] \
   [get_pins {AD9361_inst|pll_configer_inst|pll_configer_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] \
   -divide_by 2

create_generated_clock \
   -name Clk_160M \
   -source [get_ports {rx_clk_in}] \
   [get_pins {AD9361_inst|pll_tr_inst|pll_tr_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] \
   -multiply_by 2

create_generated_clock \
   -name Clk_40M \
   -source [get_ports {rx_clk_in}] \
   [get_pins {AD9361_inst|pll_tr_inst|pll_tr_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] \
   -divide_by 2

# Asynchronous reset
set_false_path -from [get_ports {areset_n}] -to Master_50M
set_false_path -from [get_ports {areset_n}] -to Clk_25M
set_false_path -from [get_ports {areset_n}] -to Rx_80M
set_false_path -from [get_ports {areset_n}] -to Clk_40M
set_false_path -from [get_ports {areset_n}] -to Clk_160M

# rst_TR is asserted for at least 255 cycles, so don't check timing
set_false_path \
    -from [get_pins -compatibility_mode {AD9361_inst|manage_top_inst|rst_TR*}] \
    -to [get_pins  -compatibility_mode {AD9361_inst|ad9361_main_inst|transmitter_data_buf_inst|rst*}]

# I/O Constraints
#   Add later if needed