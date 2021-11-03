// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//    
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module AD9361 (
  sys_clk,
  //clk_TR2,
  clk_40M,
  // data interface
  rx_clk_in,
  rx_frame_in,
  rx_data_in,
  tx_clk_out,
  tx_frame_out,
  tx_data_out,
  // gpio interface
  ad9361_resetb,
  ad9361_en_agc,
  ad9361_sync,
  ad9361_enable,
  ad9361_txnrx,
  // spi
  spi_csn,
  spi_clk,
  spi_mosi,
  spi_miso,
  //transmit and receive data
  data_I_R,
  data_Q_R,
  data_I_T,
  data_Q_T

  );

  // clock and resets

  input             sys_clk;
  //output 			clk_TR2;
  output 			clk_40M;
 
  // data interface

  input             rx_clk_in;
  input             rx_frame_in;
  input   [  5:0]   rx_data_in;
  output            tx_clk_out;
  output            tx_frame_out;
 
  output  [  5:0]   tx_data_out;

  // gpio interface

  output            ad9361_resetb;
  output            ad9361_en_agc;
  output            ad9361_sync;
  output            ad9361_enable;
  output            ad9361_txnrx;


  // spi interface

  output            spi_csn;
  output            spi_clk;
  output            spi_mosi;
  input             spi_miso;

  // input and output data
  output  	[11:0] 	data_I_R;
  output 	[11:0] 	data_Q_R;
  input 	[11:0] 	data_I_T;
  input 	[11:0] 	data_Q_T;
 


//assign tx_clk_out = rx_clk_in;
//assign tx_frame_out = rx_frame_in;

////********************************submodule1: pll and dcm  ********************************
wire clk_25M; 
wire clk_div8;
wire clk_100M;
wire locked_clk_configer;
reg rst_pllconfiger = 0;
	PLL_CONFIGER pll_configer_inst (
		.refclk   (sys_clk),   //  refclk.clk
		.rst      (rst_pllconfiger),      //   reset.reset
		.outclk_0 (clk_25M), // outclk0.clk
		.locked   (locked_clk_configer)    //  locked.export
	);
	reg [5:0] cnt64 = 0;
always @ (posedge sys_clk)
	begin
	cnt64 <= (cnt64 == 6'd62)? cnt64 : cnt64 + 1'b1;
	
	if(cnt64 < 6'd40)
		rst_pllconfiger <= 1'b1;
	else
		rst_pllconfiger <= 1'b0;
	
	
	end
		
	
wire rst_clk; 
wire clk_TR; 
wire locked_clk;
wire clk_TR2_b1;
wire clk_TR2;
wire clk_40M;
	
PLL_TR pll_tr_inst (
		.refclk   (rx_clk_in),   //  refclk.clk 80M
		.rst      (rst_clk),      //   reset.reset
		.outclk_0 (clk_TR2),// outclk0.clk 160M
		.outclk_1 (clk_40M),// outclk0.clk 40M
		.locked   (locked_clk)    //  locked.export
	);
	

//********************************submodule2: manage_top and config 9361  ********************************
wire [3:0] ini_succeed_9361;  wire [7:0] state_9361;
wire rst_config; wire rst_TR;wire [7:0] err_top_state;
manage_top manage_top_inst (
    .clk(clk_25M), 
    .ini_succeed_9361(ini_succeed_9361), 
    .state_9361(state_9361), 
    .rst_clk(rst_clk), 
	 .locked_clk(locked_clk),
    .rst_config(rst_config),
	 .rst_TR(rst_TR),
	 .err_top_state(err_top_state)
    );


wire [8:0] SET_att;
wire [4:0] state;
wire [7:0] cnt1;
wire [7:0]ad9361_regData_out;
wire [29:0]vio_out;
wire [20:0]vio_config;





wire [47:0] adc_data;
assign vio_config[20:0] = vio_out[20:0];
ad9361_main ad9361_main_inst(//T:1340 R:1340
	//top port
	.rst(rst_config),
	.clk(clk_25M),
	.ini_succeed_9361(ini_succeed_9361),
	.state_9361(state_9361),
	//9361 phy port
	.RST_9361(ad9361_resetb),
	.EN_9361(ad9361_enable),
	.EN_AGC_9361(ad9361_en_agc),
	.SPI_ENB_9361(spi_csn),
	.TXNRX_9361(ad9361_txnrx),
	.SPI_DI_9361(spi_mosi),
	.SPI_CLK_9361(spi_clk),
	.SPI_DO_9361(spi_miso),
	.CTR_I_9361(CTR_I_9361),
	.CTR_O_9361(CTR_O_9361),
	//data_R_interface
	.rst_TR(rst_TR),
	.clk_TR(clk_TR),
	.clk_TR2(clk_TR2),
	.data_I_R(data_I_R),
	.data_Q_R(data_Q_R),
	.Rx_frame_9361(rx_frame_in),
   .Rx_data_9361(rx_data_in),
	//data_T_interface
	.Tx_clk_9361(tx_clk_out),//----------------------------------------
	.data_I_T(data_I_T),
	.data_Q_T(data_Q_T),
	.Tx_frame_9361(tx_frame_out),//------------------------------------
   .Tx_data_9361(tx_data_out),
   .ad9361_regData_out(ad9361_regData_out[7:0]),
   .vio_out(vio_config[20:0]),
   .state(state[4:0]),
   .cnt1(cnt1[7:0]),
	//power of Transmitter
	.SET_att(9'h0),
	.clk_40M(clk_40M),
	.rx_clk_in(rx_clk_in),
	.adc_data(adc_data),
	.l_clk(l_clk)
	

);



endmodule
