`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:47 07/16/2018 
// Design Name: 
// Module Name:    ad9361_main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ad9361_main(
	input clk,
	input rst,
	output reg [3:0]  ini_succeed_9361,
	output reg [7:0] state_9361,
   //Comm
	output reg RST_9361,//0:RST
	output reg EN_9361,//PULSE
	output EN_AGC_9361,
	output reg TXNRX_9361,
	output SPI_ENB_9361,
	output SPI_DI_9361,
	output SPI_CLK_9361,
	input  SPI_DO_9361,
	output [3:0] CTR_I_9361,
	input  [7:0] CTR_O_9361,
	//Receiver 
	input rst_TR,
	input clk_TR,
	input clk_TR2,
	output [11:0] data_I_R,
	output [11:0] data_Q_R,
	input Rx_frame_9361,
	input [5:0] Rx_data_9361,
	//Transmitter
	input [11:0] data_I_T,
	input [11:0] data_Q_T,
	output Tx_clk_9361,
	output Tx_frame_9361,
	output [5:0] Tx_data_9361,
	//power of Transmitter
	input  [8:0]  SET_att,
	output reg [4:0] state = 0,
    output reg [7:0] cnt1 = 0,
	// vio config
	input [20:0] vio_out,
	output [7:0] ad9361_regData_out,
	input clk_40M,
	input rx_clk_in,
	output [47:0] adc_data,
	output l_clk
	);
	 	 
	 
assign CTR_I_9361=0;
assign EN_AGC_9361=1;
//assign TXNRX_9361=0;
	 
localparam
	INI					  =	5'd0 ,
	SET_INI	    		  =	5'd1 ,
	SET_BBPLL			  =	5'd2 ,
	FIR_CONFIG			  =	5'd3 ,
	DIG_PORT_CONFIG		  =	5'd4 ,
	AuxDAC_ADC_CONFIG	  =	5'd5 ,
	CTR_PORT_CONFIG		  =	5'd6 ,
	RF_PLL_NFD_CONFIG     =	5'd7 ,//RF PLL non-frequency-dependent
	RF_PLL_FD_CONFIG      =	5'd8 ,// FDD RX,TX Synth Frequency: 
	RXTX_FTW_CONFIG       =	5'd9 ,//Write Rx and Tx Frequency Words
	MIXER_GM_CONFIG       =	5'd10,//Program Mixer GM Sub-table
	RX_GAIN_CONFIG        =	5'd11,// Program Rx Gain Tables with GainTable800MHz.csv
	AGC_CONFIG      	  =	5'd12,// Setup Rx AGC Slow Attack/Hybrid Registers
	RXTX_BASE_FLT_CONFIG  =	5'd13,// RX adn TX Baseband Filter Tuning
	RX_TIA_CONFIG  		  =	5'd14,//Setup values scale based on RxBBF calibration
	TX_2ND_FLT_CONFIG  	  =	5'd15,// TX Secondary Filter Calibration Setup:  Real Bandwidth
	ADC_SETUP  	  		  =	5'd16,// Tune ADC Performance based on RX analog filter tune
	BB_RF_DC_CAL  	  	  =	5'd17,// Setup and Run BB DC and RF DC Offset Calibrations
	TX_QUA_CAL  	  	  =	5'd18,// Tx Quadrature Calibration Settings
	TX_ATT_CONFIG  	  	  =	5'd19,// Set Tx Attenuation
	RSSI_CONFIG  	  	  =	5'd20,// Setup RSSI and Power Measurement Duration Registers
	TX_POWER_SET        =   5'd21,//reset power of T

	ERR_STATE   =	5'd28,
	DELAY_ms	=	5'd29,
	DELAY_us	=	5'd30,
	TEST_DEBUG  =	5'd31;

	 
reg rst_d1; reg rst_d2;
reg [8:0] SET_att_d1;reg [8:0] SET_att_d2;reg [8:0] SET_att_d3;
always @(posedge clk)begin
	rst_d1<=rst; rst_d2<=rst_d1;
	SET_att_d1<=SET_att;SET_att_d2<=SET_att_d1;SET_att_d3<=SET_att_d2;
end
 
//
reg [4:0] state_breakpoint;
reg [15:0] num_1us;reg [15:0] acc_1us;reg [7:0] cnt_1us;
reg [15:0] num_1ms;reg [15:0] acc_1ms = 0;reg [15:0] cnt_1ms;

 
 
//**************************************ad9361_wr_rd para declare
reg wr_n;reg rd_n;reg [9:0] addr_9361;
reg [7:0]data_in;
wire [7:0] data_out;
wire flag_finish;

assign ad9361_regData_out = data_out;

ad9361_wr_rd ad9361_wr_rd_inst (
    .clk(clk), 
    .rst(rst_d2), 
    .wr_n(wr_n), 
    .rd_n(rd_n), 
    .addr_9361(addr_9361), 
    .data_in(data_in), 
    .data_out(data_out), 
    .flag_finish(flag_finish), 
    .scs_n(SPI_ENB_9361), 
    .sclk(SPI_CLK_9361), 
    .mosi(SPI_DI_9361), 
    .miso(SPI_DO_9361)
    );
//FIR	
reg [6:0] addr_TX_FIR;wire [15:0] douta_TX_FIR;
rom_128word_TX_fir rom_128word_TX_fir_inst(.clock(clk),.address(addr_TX_FIR),.q(douta_TX_FIR));
reg [6:0] addr_RX_FIR;wire [15:0] douta_RX_FIR;
rom_128word_RX_fir rom_128word_RX_fir_inst(.clock(clk),.address(addr_RX_FIR),.q(douta_RX_FIR));
//MIXER_SUBTABLE
reg [3:0] addr_Mixer_GM;wire [7:0] douta_Mixer_Gain;wire [7:0] douta_Mixer_Bias;wire [7:0] douta_Mixer_GM;
rom_16byte_Mixer_Gain rom_16byte_Mixer_Gain_inst(.clock(clk),.address(addr_Mixer_GM),.q(douta_Mixer_Gain));	
rom_16byte_Mixer_Bias rom_16byte_Mixer_Bias_inst(.clock(clk),.address(addr_Mixer_GM),.q(douta_Mixer_Bias));	
rom_16byte_Mixer_GM   rom_16byte_Mixer_GM_inst  (.clock(clk),.address(addr_Mixer_GM),.q(douta_Mixer_GM));	
//AGC RX_GAIN
reg [6:0] addr_RX_AGC;wire [7:0] douta1_AGC;wire [7:0] douta2_AGC;wire [7:0] douta3_AGC;
//L: 200M-1300M     M: 1300M-4000M       H:4000M-6000M  
rom_128byte_RX_GAIN_DATA1_H rom_128byte_RX_GAIN_DATA1_inst(.clock(clk),.address(addr_RX_AGC),.q(douta1_AGC));	
rom_128byte_RX_GAIN_DATA2_H rom_128byte_RX_GAIN_DATA2_inst(.clock(clk),.address(addr_RX_AGC),.q(douta2_AGC));	
rom_128byte_RX_GAIN_DATA3_H rom_128byte_RX_GAIN_DATA3_inst(.clock(clk),.address(addr_RX_AGC),.q(douta3_AGC));	
//AD SETUP
reg [5:0] addr_AD_SETUP;wire [7:0] douta_ADC_SETUP;
rom_64byte_AD_SETUP rom_64byte_AD_SETUP_inst(.clock(clk),.address(addr_AD_SETUP),.q(douta_ADC_SETUP));
	

//********************for debug
//wire [20:0] vio_out;
// reg vio_0_d1; reg vio_0_d2; reg vio_0_d3;
reg vio_1_d1; reg vio_1_d2; reg vio_1_d3;
reg vio_2_d1; reg vio_2_d2; reg vio_2_d3;
reg [9:0] addr_9361_vio;
reg [7:0] data_in_vio;
always @(posedge clk)begin
	// vio_0_d1<=vio_1;vio_0_d2<=vio_0_d1;vio_0_d3<=vio_0_d2;
	vio_1_d1<=vio_out[1];vio_1_d2<=vio_1_d1;vio_1_d3<=vio_1_d2;
	vio_2_d1<=vio_out[2];vio_2_d2<=vio_2_d1;vio_2_d3<=vio_2_d2;
	addr_9361_vio<=vio_out[12:3];
	data_in_vio<=vio_out[20:13];
//	TXNRX_9361<=vio_out[21];
end	


	
reg [8:0] att_T_now;
always @(posedge clk)begin
	if(rst_d2)begin
		state<=0;cnt1<=0;RST_9361<=1'b0;
		ini_succeed_9361<=0;
		TXNRX_9361<=1; 
		EN_9361<=1;
		wr_n<=1'b1;rd_n<=1'b1;
		att_T_now<=9'h28;
	end
	else begin
		case(state)	
			INI:begin//0
				case(cnt1)
					default:cnt1<=cnt1+1;
					0:begin
						num_1us<=0;acc_1us<=0;cnt_1us<=0;
						num_1ms<=0;acc_1ms<=0;cnt_1ms<=0;
						wr_n<=1'b1;rd_n<=1'b1;
						cnt1<=cnt1+1;
					end
					1:begin
						num_1us<=16'd99; state<=DELAY_us; state_breakpoint<=INI;//delay 100us
						RST_9361<=1'b0;cnt1<=cnt1+1;
					end
					2:begin
						num_1us<=16'd99; state<=DELAY_us; state_breakpoint<=INI;//delay 100us
						RST_9361<=1'b1;cnt1<=cnt1+1;
					end
					7:begin
						num_1ms<=16'd19; state<=DELAY_ms; state_breakpoint<=SET_INI;//delay 20ms
						cnt1<=0;
					end
				endcase
				addr_TX_FIR<=0;addr_RX_FIR<=0;addr_Mixer_GM<=4'hF;addr_RX_AGC<=0;addr_AD_SETUP<=0;
			end
			SET_INI:begin//1
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h3DF; data_in<=8'h01;cnt1<=cnt1+1; end//write 3ED:Required for proper operation
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h2A6; data_in<=8'h0E;cnt1<=cnt1+1; end//write 2A6:Required for proper operation
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h2A8; data_in<=8'h0E;cnt1<=cnt1+1; end//write 2A8:Required for proper operation
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					
					6 :begin wr_n<=1'b0;addr_9361<=10'h292; data_in<=8'h08;cnt1<=cnt1+1; end//Set DCXO Coarse Tune[5:0].  Coarse and Fine nominal values used with eval system.  Other nominal values may be needed in a customer system
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h293; data_in<=8'h80;cnt1<=cnt1+1; end//Set DCXO Fine Tune [12:5]
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h294; data_in<=8'h00;cnt1<=cnt1+1; end//Set DCXO Fine Tune [4:0]
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
	
					12  :begin wr_n<=1'b0;addr_9361<=10'h2AB; data_in<=8'h07;cnt1<=cnt1+1; end//write 2AB:Set RF PLL reflclk scale to REFCLK * 2
					13  :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14  :begin wr_n<=1'b0;addr_9361<=10'h2AC; data_in<=8'hFF;cnt1<=cnt1+1; end//write 2AC:Set RF PLL reflclk scale to REFCLK * 2
					15  :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h009; data_in<=8'h07;cnt1<=cnt1+1; end//write 009:Enable Clocks
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin cnt1<=0;num_1ms<=16'd19; state<=DELAY_ms; state_breakpoint<=SET_BBPLL;end//delay 20ms
				endcase
			end
			SET_BBPLL:begin//2:Set BBPLL Frequency: 960.000000 frec*2088960=06_60_00
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h045; data_in<=8'h00;cnt1<=cnt1+1; end// Set BBPLL reflclk scale to REFCLK * 2
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h046; data_in<=8'h05;cnt1<=cnt1+1; end// Set BBPLL Loop Filter Charge Pump current
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h048; data_in<=8'hE8;cnt1<=cnt1+1; end// Set BBPLL Loop Filter C1, R1
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					6 :begin wr_n<=1'b0;addr_9361<=10'h049; data_in<=8'h5B;cnt1<=cnt1+1; end// Set BBPLL Loop Filter R2, C2, C1
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h04A; data_in<=8'h35;cnt1<=cnt1+1; end// Set BBPLL Loop Filter C3,R2
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h04B; data_in<=8'hE0;cnt1<=cnt1+1; end// Allow calibration to occur and set cal count to 1024 for max accuracy
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h04E; data_in<=8'h10;cnt1<=cnt1+1; end// Set calibration clock to REFCLK/4 for more accuracy
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h043; data_in<=8'h00;cnt1<=cnt1+1; end// BBPLL Freq Word (Fractional[7:0])
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h042; data_in<=8'h00;cnt1<=cnt1+1; end// BBPLL Freq Word (Fractional[15:8])
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h041; data_in<=8'h00;cnt1<=cnt1+1; end// BBPLL Freq Word (Fractional[20:16])
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					20:begin wr_n<=1'b0;addr_9361<=10'h044; data_in<=8'h20;cnt1<=cnt1+1; end// BBPLL Freq Word (Integer[7:0])
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					22:begin wr_n<=1'b0;addr_9361<=10'h03F; data_in<=8'h05;cnt1<=cnt1+1; end// Start BBPLL Calibration
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h03F; data_in<=8'h01;cnt1<=cnt1+1; end// Clear BBPLL start calibration bit
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					26:begin wr_n<=1'b0;addr_9361<=10'h04C; data_in<=8'h86;cnt1<=cnt1+1; end// Increase BBPLL KV and phase margin
					27:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					28:begin wr_n<=1'b0;addr_9361<=10'h04D; data_in<=8'h01;cnt1<=cnt1+1; end// Increase BBPLL KV and phase margin
					29:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					30:begin wr_n<=1'b0;addr_9361<=10'h04D; data_in<=8'h05;cnt1<=cnt1+1; end// Increase BBPLL KV and phase margin
					31:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					32:begin cnt1<=cnt1+1;num_1ms<=16'd9; state<=DELAY_ms; state_breakpoint<=SET_BBPLL;end//delay 10ms
					33:begin rd_n<=1'b0;addr_9361<=10'h05E;cnt1<=cnt1+1;  end// Check BBPLL locked status  (0x05E[7]==1 is locked)
					34:begin rd_n<=1'b1;
						if(flag_finish)begin
							if(data_out[7]==1)begin cnt1<=cnt1+1;ini_succeed_9361[0]<=1'b1; end
							else begin	cnt1<=32;	ini_succeed_9361[0]<=1'b0; end
						end
					end
					35:begin wr_n<=1'b0;addr_9361<=10'h002; data_in<=8'h4C;cnt1<=cnt1+1; end// Setup Tx Digital Filters/ Channels:Tx
					36:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					37:begin wr_n<=1'b0;addr_9361<=10'h003; data_in<=8'h5C;cnt1<=cnt1+1; end// Setup Rx Digital Filters/ Channels��Rx
					38:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					39:begin wr_n<=1'b0;addr_9361<=10'h004; data_in<=8'h03;cnt1<=cnt1+1; end// Select Rx input pin(A,B,C)/ Tx out pin (A,B)
					40:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					41:begin wr_n<=1'b0;addr_9361<=10'h00A; data_in<=8'h3A;cnt1<=cnt1+1; end// Set BBPLL post divide rate
					//42:begin wr_n<=1'b1;if(flag_finish)begin state<=FIR_CONFIG; cnt1<=0; end end
					42:begin wr_n<=1'b1;if(flag_finish)begin state<=DIG_PORT_CONFIG; cnt1<=0; end end
				endcase
			end
			FIR_CONFIG:begin//3
				case(cnt1)
					//TX FIR
					0 :begin wr_n<=1'b0;addr_9361<=10'h065; data_in<=8'h7A;cnt1<=cnt1+1; end// Enable clock to Tx FIR Filter and set Filter gain Setting:64
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h060; data_in<={1'b0,addr_TX_FIR};cnt1<=cnt1+1; end// Write FIR coefficient address
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h061; data_in<=douta_TX_FIR[7:0];cnt1<=cnt1+1; end// Write FIR coefficient data[7:0]
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					6 :begin wr_n<=1'b0;addr_9361<=10'h062; data_in<=douta_TX_FIR[15:8];cnt1<=cnt1+1; end// Write FIR coefficient data[15:8]
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h065; data_in<=8'h7E;cnt1<=cnt1+1; end// Set Write EN to push data into FIR filter register map
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					10:begin cnt1<=cnt1+1;num_1us<=16'd1; state<=DELAY_us; state_breakpoint<=FIR_CONFIG;end//delay 2us
					11:begin if(addr_TX_FIR==7'd63)cnt1<=cnt1+1;else begin addr_TX_FIR<=addr_TX_FIR+1; cnt1<=2; end end
					12:begin wr_n<=1'b0;addr_9361<=10'h065; data_in<=8'h78;cnt1<=cnt1+1; end// Disable clock to Tx Filter:0dB
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//RX FIR
					14:begin wr_n<=1'b0;addr_9361<=10'h0F5; data_in<=8'h7A;cnt1<=cnt1+1; end// Enable clock to Rx FIR Filter 
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h0F6; data_in<=8'h02;cnt1<=cnt1+1; end// Write Filter Gain setting:-6dB
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					18:begin wr_n<=1'b0;addr_9361<=10'h0F0; data_in<={1'b0,addr_RX_FIR};cnt1<=cnt1+1; end// Write FIR coefficient address
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					20:begin wr_n<=1'b0;addr_9361<=10'h0F1; data_in<=douta_RX_FIR[7:0];cnt1<=cnt1+1; end// Write FIR coefficient data[7:0]
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					22:begin wr_n<=1'b0;addr_9361<=10'h0F2; data_in<=douta_RX_FIR[15:8];cnt1<=cnt1+1; end// Write FIR coefficient data[15:8]
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h0F5; data_in<=8'h7E;cnt1<=cnt1+1; end// Set Write EN to push data into FIR filter register map
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					26:begin cnt1<=cnt1+1;num_1us<=16'd1; state<=DELAY_us; state_breakpoint<=FIR_CONFIG;end//delay 2us
					27:begin if(addr_RX_FIR==7'd63)cnt1<=cnt1+1;else begin addr_RX_FIR<=addr_RX_FIR+1; cnt1<=18; end end
					28:begin wr_n<=1'b0;addr_9361<=10'h0F5; data_in<=8'h78;cnt1<=cnt1+1; end// Disable clock to Rx Filter
					29:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=DIG_PORT_CONFIG; end end	
				endcase
			end
			DIG_PORT_CONFIG:begin//4
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h010; data_in<=8'hC8;cnt1<=cnt1+1; end// I/O Config.  Tx Swap IQ; Rx Swap IQ; Tx CH Swap, Rx CH Swap; Rx Frame Mode; 2R2T bit; Invert data bus; Invert DATA_CLK
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h011; data_in<=8'h00;cnt1<=cnt1+1; end// I/O Config.  Alt Word Order; -Rx1; -Rx2; -Tx1; -Tx2; Invert Rx Frame; Delay Rx Data
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h012; data_in<=8'h10;cnt1<=cnt1+1; end// I/O Config.  Rx=2*Tx; Swap Ports; SDR; LVDS; Half Duplex; Single Port; Full Port; Swap Bits
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					6 :begin wr_n<=1'b0;addr_9361<=10'h006; data_in<=8'h0F;cnt1<=cnt1+1; end// PPORT Rx Delay (adjusts Tco Dataclk->Data)
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h007; data_in<=8'h00;cnt1<=cnt1+1; end// PPORT TX Delay (adjusts setup/hold FBCLK->Data)
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1; end
					
					10 :begin wr_n<=1'b0;addr_9361<=10'h03C; data_in<=8'h21;cnt1<=cnt1+1; end// PPORT TX Delay (adjusts setup/hold FBCLK->Data)
					11 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1; end
					
					12 :begin wr_n<=1'b0;addr_9361<=10'h03D; data_in<=8'h00;cnt1<=cnt1+1; end// PPORT TX Delay (adjusts setup/hold FBCLK->Data)
					13 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1; end
					
					14 :begin wr_n<=1'b0;addr_9361<=10'h03E; data_in<=8'h00;cnt1<=cnt1+1; end// PPORT TX Delay (adjusts setup/hold FBCLK->Data)
					15 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1; end
					
					
					16:begin cnt1<=cnt1+1;num_1ms<=16'd9; state<=DELAY_ms; state_breakpoint<=DIG_PORT_CONFIG;end//delay 10ms
					17:begin cnt1<=0; state<=AuxDAC_ADC_CONFIG; end					
				endcase
			end
			AuxDAC_ADC_CONFIG:begin//5
				case(cnt1)
					//DAC
					0 :begin wr_n<=1'b0;addr_9361<=10'h018; data_in<=8'h00;cnt1<=cnt1+1; end
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h019; data_in<=8'h00;cnt1<=cnt1+1; end
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h01A; data_in<=8'h00;cnt1<=cnt1+1; end
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h01B; data_in<=8'h00;cnt1<=cnt1+1; end
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h023; data_in<=8'hFF;cnt1<=cnt1+1; end
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					10:begin wr_n<=1'b0;addr_9361<=10'h026; data_in<=8'h00;cnt1<=cnt1+1; end
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h030; data_in<=8'h00;cnt1<=cnt1+1; end
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h031; data_in<=8'h00;cnt1<=cnt1+1; end
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					16:begin wr_n<=1'b0;addr_9361<=10'h032; data_in<=8'h00;cnt1<=cnt1+1; end
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h033; data_in<=8'h00;cnt1<=cnt1+1; end
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//ADC
					20:begin wr_n<=1'b0;addr_9361<=10'h00B; data_in<=8'h00;cnt1<=cnt1+1; end
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					22:begin wr_n<=1'b0;addr_9361<=10'h00C; data_in<=8'h00;cnt1<=cnt1+1; end
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h00D; data_in<=8'h03;cnt1<=cnt1+1; end
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					26:begin wr_n<=1'b0;addr_9361<=10'h00F; data_in<=8'h04;cnt1<=cnt1+1; end
					27:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					28:begin wr_n<=1'b0;addr_9361<=10'h01C; data_in<=8'h10;cnt1<=cnt1+1; end
					29:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					30:begin wr_n<=1'b0;addr_9361<=10'h01D; data_in<=8'h01;cnt1<=cnt1+1; end
					31:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=CTR_PORT_CONFIG; end end
				endcase
			end
			CTR_PORT_CONFIG:begin//6 CONTROL AND GPO
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h035; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h036; data_in<=8'hFF;cnt1<=cnt1+1; end// Ctrl Out [7:0] output enable
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin wr_n<=1'b0;addr_9361<=10'h03A; data_in<=8'h27;cnt1<=cnt1+1; end// Ctrl Out index
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h020; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h027; data_in<=8'h03;cnt1<=cnt1+1; end// Ctrl Out index
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h028; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h029; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h02A; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h02B; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h02C; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					20:begin wr_n<=1'b0;addr_9361<=10'h02D; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					22:begin wr_n<=1'b0;addr_9361<=10'h02E; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h02F; data_in<=8'h00;cnt1<=cnt1+1; end// Ctrl Out index
					25:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=RF_PLL_NFD_CONFIG; end end	
				endcase
			end
			RF_PLL_NFD_CONFIG:begin//7:Setup RF PLL non-frequency-dependent registers
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h261; data_in<=8'h00;cnt1<=cnt1+1; end// Set Rx LO Power mode
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h2A1; data_in<=8'h00;cnt1<=cnt1+1; end// Set Tx LO Power mode
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin wr_n<=1'b0;addr_9361<=10'h248; data_in<=8'h0B;cnt1<=cnt1+1; end// Enable Rx VCO LDO
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h288; data_in<=8'h0B;cnt1<=cnt1+1; end// Enable Tx VCO LDO
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h246; data_in<=8'h02;cnt1<=cnt1+1; end// Set VCO Power down TCF bits
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h286; data_in<=8'h02;cnt1<=cnt1+1; end// Set VCO Power down TCF bits
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h249; data_in<=8'h8E;cnt1<=cnt1+1; end// Set VCO cal length
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h289; data_in<=8'h8E;cnt1<=cnt1+1; end// Set VCO cal length
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h23B; data_in<=8'h80;cnt1<=cnt1+1; end// Enable Rx VCO cal
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h27B; data_in<=8'h80;cnt1<=cnt1+1; end// Enable Tx VCO cal
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					20:begin wr_n<=1'b0;addr_9361<=10'h243; data_in<=8'h0D;cnt1<=cnt1+1; end// Set Rx prescaler bias
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					22:begin wr_n<=1'b0;addr_9361<=10'h283; data_in<=8'h0D;cnt1<=cnt1+1; end// Set Tx prescaler bias
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h23D; data_in<=8'h00;cnt1<=cnt1+1; end// Clear Half VCO cal clock setting
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					26:begin wr_n<=1'b0;addr_9361<=10'h27D; data_in<=8'h00;cnt1<=cnt1+1; end// Clear Half VCO cal clock setting
					27:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					28:begin wr_n<=1'b0;addr_9361<=10'h015; data_in<=8'h0C;cnt1<=cnt1+1; end// Set Dual Synth mode bit
					29:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					30:begin wr_n<=1'b0;addr_9361<=10'h014; data_in<=8'h15;cnt1<=cnt1+1; end// Level set Set Force ALERT State bit
					31:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					32:begin wr_n<=1'b0;addr_9361<=10'h013; data_in<=8'h01;cnt1<=cnt1+1; end// Set ENSM FDD mode
					33:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					34:begin cnt1<=cnt1+1;num_1ms<=16'd0; state<=DELAY_ms; state_breakpoint<=RF_PLL_NFD_CONFIG;end//delay 1ms
					35:begin wr_n<=1'b0;addr_9361<=10'h23D; data_in<=8'h04;cnt1<=cnt1+1; end// Start RX CP cal
					36:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					37:begin cnt1<=cnt1+1;num_1ms<=16'd0; state<=DELAY_ms; state_breakpoint<=RF_PLL_NFD_CONFIG;end//delay 1ms
					38:begin rd_n<=1'b0;addr_9361<=10'h244; cnt1<=cnt1+1; end// Wait for CP cal to complete, Max RXCP Cal time: 737.280 (us)(Done when 0x244[7]==1)
					39:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[7]==1)cnt1<=cnt1+1;else begin cnt1<=37;  end end end	
					40:begin wr_n<=1'b0;addr_9361<=10'h27D; data_in<=8'h04;cnt1<=cnt1+1; end// Start TX CP cal
					41:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					42:begin cnt1<=cnt1+1;num_1ms<=16'd0; state<=DELAY_ms; state_breakpoint<=RF_PLL_NFD_CONFIG;end//delay 1ms
					43:begin rd_n<=1'b0;addr_9361<=10'h284; cnt1<=cnt1+1; end// Wait for CP cal to complete, Max TXCP Cal time: 737.280 (us)(Done when 0x284[7]==1)
					44:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[7]==1)cnt1<=cnt1+1;else begin cnt1<=42;  end end end
					45:begin wr_n<=1'b0;addr_9361<=10'h23D; data_in<=8'h00;cnt1<=cnt1+1; end// Disable RX CP Calibration since the CP Cal start bit is not self-clearing.  Only important if the script is run again without restting the DUT
					46:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					47:begin wr_n<=1'b0;addr_9361<=10'h27D; data_in<=8'h00;cnt1<=cnt1+1; end// Disable TX CP Calibration since the CP Cal start bit is not self-clearing.  Only important if the script is run again without restting the DUT
					48:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=RF_PLL_FD_CONFIG; end end	
					//60:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=TEST_DEBUG; end end	
				endcase
			end
			RF_PLL_FD_CONFIG:begin//8: FDD RX,TX Synth Frequency: 
				case(cnt1)
					// Setup Rx Frequency-Dependent Syntheisizer Registers
					0 :begin wr_n<=1'b0;addr_9361<=10'h23A; data_in<=8'h4A;cnt1<=cnt1+1; end// Set VCO Output level[3:0]
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h239; data_in<=8'hC0;cnt1<=cnt1+1; end// Set Init ALC Value[3:0] and VCO Varactor[3:0]
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin wr_n<=1'b0;addr_9361<=10'h242; data_in<=8'h04;cnt1<=cnt1+1; end// Set VCO Bias Tcf[1:0] and VCO Bias Ref[2:0]
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h238; data_in<=8'h78;cnt1<=cnt1+1; end// Set VCO Cal Offset[3:0]
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h245; data_in<=8'h00;cnt1<=cnt1+1; end// Set VCO Cal Ref Tcf[2:0]
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h251; data_in<=8'h08;cnt1<=cnt1+1; end// Set VCO Varactor Reference[3:0]
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h250; data_in<=8'h70;cnt1<=cnt1+1; end// Set VCO Varactor Ref Tcf[2:0] and VCO Varactor Offset[3:0]
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h23B; data_in<=8'h88;cnt1<=cnt1+1; end// Set Synth Loop Filter charge pump current (Icp)
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h23E; data_in<=8'hD4;cnt1<=cnt1+1; end// Set Synth Loop Filter C2 and C1
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h23F; data_in<=8'hDF;cnt1<=cnt1+1; end// Set Synth Loop Filter  R1 and C3
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					20:begin wr_n<=1'b0;addr_9361<=10'h240; data_in<=8'h09;cnt1<=cnt1+1; end// Set Synth Loop Filter R3
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					// Setup Tx Frequency-Dependent Syntheisizer Registers
					22:begin wr_n<=1'b0;addr_9361<=10'h27A; data_in<=8'h4A;cnt1<=cnt1+1; end// Reset Tx VCO cal logic
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h279; data_in<=8'hC0;cnt1<=cnt1+1; end// Set Init ALC Value[3:0] and VCO Varactor[3:0]
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					26:begin wr_n<=1'b0;addr_9361<=10'h282; data_in<=8'h04;cnt1<=cnt1+1; end// Set VCO Bias Tcf[1:0] and VCO Bias Ref[2:0]
					27:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					28:begin wr_n<=1'b0;addr_9361<=10'h278; data_in<=8'h78;cnt1<=cnt1+1; end// Set VCO Cal Offset[3:0]
					29:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					30:begin wr_n<=1'b0;addr_9361<=10'h285; data_in<=8'h00;cnt1<=cnt1+1; end// Set VCO Cal Ref Tcf[2:0]
					31:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					32:begin wr_n<=1'b0;addr_9361<=10'h291; data_in<=8'h08;cnt1<=cnt1+1; end// Set VCO Varactor Reference[3:0]
					33:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					34:begin wr_n<=1'b0;addr_9361<=10'h290; data_in<=8'h70;cnt1<=cnt1+1; end// Set VCO Varactor Ref Tcf[2:0] and VCO Varactor Offset[3:0]
					35:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					36:begin wr_n<=1'b0;addr_9361<=10'h27B; data_in<=8'h88;cnt1<=cnt1+1; end// Set Synth Loop Filter charge pump current (Icp)
					37:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					38:begin wr_n<=1'b0;addr_9361<=10'h27E; data_in<=8'hD4;cnt1<=cnt1+1; end// Set Synth Loop Filter C2 and C1
					39:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					40:begin wr_n<=1'b0;addr_9361<=10'h27F; data_in<=8'hDF;cnt1<=cnt1+1; end/// Set Synth Loop Filter  R1 and C3
					41:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					42:begin wr_n<=1'b0;addr_9361<=10'h280; data_in<=8'h09;cnt1<=cnt1+1; end// Set Synth Loop Filter R3
					43:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=RXTX_FTW_CONFIG; end end	
					//43:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=TEST_DEBUG; end end	
				endcase
			end
			RXTX_FTW_CONFIG:begin//9:  Write Rx and Tx Frequency Words
				case(cnt1)		
					0 :begin wr_n<=1'b0;addr_9361<=10'h233; data_in<=8'h00;cnt1<=cnt1+1; end// Write Rx Synth Fractional Freq Word[7:0]
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h234; data_in<=8'h00;cnt1<=cnt1+1; end// Write Rx Synth Fractional Freq Word[15:8]
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin wr_n<=1'b0;addr_9361<=10'h235; data_in<=8'h00;cnt1<=cnt1+1; end// Write Rx Synth Fractional Freq Word[22:16]
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h232; data_in<=8'h00;cnt1<=cnt1+1; end// Write Rx Synth Integer Freq Word[10:8]
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h231; data_in<=8'h78;cnt1<=cnt1+1; end// Write Rx Synth Integer Freq Word[7:0]
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h005; data_in<=8'h11;cnt1<=cnt1+1; end// Set LO divider setting
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h273; data_in<=8'h00;cnt1<=cnt1+1; end// Write Tx Synth Fractional Freq Word[7:0]
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h274; data_in<=8'h00;cnt1<=cnt1+1; end// Write Tx Synth Fractional Freq Word[15:8]
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h275; data_in<=8'h00;cnt1<=cnt1+1; end// Write Tx Synth Fractional Freq Word[22:16]
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h272; data_in<=8'h00;cnt1<=cnt1+1; end// Write Tx Synth Integer Freq Word[10:8]
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					20:begin wr_n<=1'b0;addr_9361<=10'h271; data_in<=8'h78;cnt1<=cnt1+1; end// Write Tx Synth Integer Freq Word[7:0] (starts VCO cal)
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					22:begin wr_n<=1'b0;addr_9361<=10'h005; data_in<=8'h11;cnt1<=cnt1+1; end// Set LO divider setting
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin cnt1<=cnt1+1;num_1ms<=16'd1; state<=DELAY_ms; state_breakpoint<=RXTX_FTW_CONFIG;end//delay 2ms
					25:begin rd_n<=1'b0;addr_9361<=10'h247; cnt1<=cnt1+1; end// Check RX RF PLL lock status (0x247[1]==1 is locked)
					26:begin rd_n<=1'b1;
						if(flag_finish)begin
							if(data_out[1]==1)begin ini_succeed_9361[1]<=1'b1;cnt1<=cnt1+1; end
							else begin	cnt1<=8'd24;	ini_succeed_9361[1]<=1'b0;end
						end
					end	
					27:begin rd_n<=1'b0;addr_9361<=10'h287; cnt1<=cnt1+1; end// Check TX RF PLL lock status (0x287[1]==1 is locked)
					28:begin rd_n<=1'b1;
						if(flag_finish)begin
							if(data_out[1]==1)begin cnt1<=0;  state<=MIXER_GM_CONFIG; ini_succeed_9361[2]<=1'b1; end
							//if(data_out[1]==1)begin state<=TEST_DEBUG; ini_succeed_9361[2]<=1'b1; end
							else begin	cnt1<=8'd24;	ini_succeed_9361[2]<=1'b0; 	end
							
						end
					end
				endcase
			end
			MIXER_GM_CONFIG:begin//10:Program Mixer GM Sub-table
				case(cnt1)
					//TX FIR
					0 :begin wr_n<=1'b0;addr_9361<=10'h13F; data_in<=8'h02;cnt1<=cnt1+1; end// Start Clock
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h138; data_in<={4'd0,addr_Mixer_GM};cnt1<=cnt1+1; end// Addr Table Index
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h139; data_in<=douta_Mixer_Gain;cnt1<=cnt1+1; end// Gain
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					6 :begin wr_n<=1'b0;addr_9361<=10'h13A; data_in<=douta_Mixer_Bias;cnt1<=cnt1+1; end// Bias
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h13B; data_in<=douta_Mixer_GM;cnt1<=cnt1+1; end// GM
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					10:begin wr_n<=1'b0;addr_9361<=10'h13F; data_in<=8'h06;cnt1<=cnt1+1; end// Write Words
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin cnt1<=cnt1+1;num_1us<=16'd1; state<=DELAY_us; state_breakpoint<=MIXER_GM_CONFIG;end//delay 2us
					13:begin if(addr_Mixer_GM==4'h0)cnt1<=cnt1+1;else begin addr_Mixer_GM<=addr_Mixer_GM-1; cnt1<=2; end end
					14:begin wr_n<=1'b0;addr_9361<=10'h13F; data_in<=8'h02;cnt1<=cnt1+1; end	// Clear Write Bit
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin cnt1<=cnt1+1;num_1us<=16'd1; state<=DELAY_us; state_breakpoint<=MIXER_GM_CONFIG;end//delay 2us
					17:begin wr_n<=1'b0;addr_9361<=10'h13F; data_in<=8'h00;cnt1<=cnt1+1; end	// Stop Clock
					18:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=RX_GAIN_CONFIG; end end	
				endcase
			end
			RX_GAIN_CONFIG:begin//11:Program Rx Gain Tables with GainTable800MHz.csv?
				case(cnt1)
					//TX FIR
					0 :begin wr_n<=1'b0;addr_9361<=10'h137; data_in<=8'h1A;cnt1<=cnt1+1; end// Start Gain Table Clock
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h130; data_in<={1'd0,addr_RX_AGC};cnt1<=cnt1+1; end// Gain Table Index
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h131; data_in<=douta1_AGC;cnt1<=cnt1+1; end// Ext LNA, Int LNA, & Mixer Gain Word
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					6 :begin wr_n<=1'b0;addr_9361<=10'h132; data_in<=douta2_AGC;cnt1<=cnt1+1; end// TIA & LPF Word
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h133; data_in<=douta3_AGC;cnt1<=cnt1+1; end// DC Cal bit & Dig Gain Word
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					10:begin wr_n<=1'b0;addr_9361<=10'h137; data_in<=8'h1E;cnt1<=cnt1+1; end// Write Words
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin cnt1<=cnt1+1;num_1us<=16'd1; state<=DELAY_us; state_breakpoint<=RX_GAIN_CONFIG;end//delay 2us
					13:begin if(addr_RX_AGC==7'h4C)cnt1<=cnt1+1;else begin addr_RX_AGC<=addr_RX_AGC+1; cnt1<=2; end end
					14:begin wr_n<=1'b0;addr_9361<=10'h137; data_in<=8'h1A;cnt1<=cnt1+1; end	// Clear Write Bit
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin cnt1<=cnt1+1;num_1us<=16'd1; state<=DELAY_us; state_breakpoint<=RX_GAIN_CONFIG;end//delay 2us
					17:begin wr_n<=1'b0;addr_9361<=10'h137; data_in<=8'h00;cnt1<=cnt1+1; end	// Stop Gain Table Clock
					18:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=AGC_CONFIG; end end	
				endcase
			end
			AGC_CONFIG:begin//12:Setup Rx AGC Slow Attack/Hybrid Registers
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h0FA; data_in<=8'hEA;cnt1<=cnt1+1; end// Gain Control Mode Select
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h0FB; data_in<=8'h08;cnt1<=cnt1+1; end// Full Table/Digital Gain Select
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin wr_n<=1'b0;addr_9361<=10'h0FC; data_in<=8'h03;cnt1<=cnt1+1; end// ADC Overrange Sample Size
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h0FD; data_in<=8'h4C;cnt1<=cnt1+1; end// Max Full/LMT Gain Table Index
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h0FE; data_in<=8'h48;cnt1<=cnt1+1; end// Peak Overload Wait Time
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h100; data_in<=8'h6F;cnt1<=cnt1+1; end// Max Digital Gain
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end

					12:begin wr_n<=1'b0;addr_9361<=10'h101; data_in<=8'h0A;cnt1<=cnt1+1; end// Max Digital Gain
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					14:begin wr_n<=1'b0;addr_9361<=10'h103; data_in<=8'h08;cnt1<=cnt1+1; end// Max Digital Gain
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end


					16:begin wr_n<=1'b0;addr_9361<=10'h104; data_in<=8'h2F;cnt1<=cnt1+1; end// AGC Inner High Threshold
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h105; data_in<=8'h3A;cnt1<=cnt1+1; end// Large LMT Step Size
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					
					20:begin wr_n<=1'b0;addr_9361<=10'h106; data_in<=8'h22;cnt1<=cnt1+1; end// Max Digital Gain
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end

					
					22:begin wr_n<=1'b0;addr_9361<=10'h107; data_in<=8'h2B;cnt1<=cnt1+1; end// ADC Large Overload Threshold
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h108; data_in<=8'h31;cnt1<=cnt1+1; end// ADC Overload Step Sizes
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//20:begin wr_n<=1'b0;addr_9361<=10'h109; data_in<=8'h4C;cnt1<=cnt1+1; end// Large LMT Overload Threshold
					//21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					
					26:begin wr_n<=1'b0;addr_9361<=10'h111; data_in<=8'h0A;cnt1<=cnt1+1; end// Max Digital Gain
					27:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					
					
					28:begin wr_n<=1'b0;addr_9361<=10'h11A; data_in<=8'h27;cnt1<=cnt1+1; end// Initial LMT Gain Limit
					29:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//24:begin wr_n<=1'b0;addr_9361<=10'h10B; data_in<=8'h00;cnt1<=cnt1+1; end// Prevent Inc & AGC Inner Low Thresh
					//25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					
					30:begin wr_n<=1'b0;addr_9361<=10'h120; data_in<=8'h0C;cnt1<=cnt1+1; end// Max Digital Gain
					31:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					32:begin wr_n<=1'b0;addr_9361<=10'h121; data_in<=8'hAA;cnt1<=cnt1+1; end// Max Digital Gain
					33:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					34:begin wr_n<=1'b0;addr_9361<=10'h122; data_in<=8'hAA;cnt1<=cnt1+1; end// Max Digital Gain
					35:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					36:begin wr_n<=1'b0;addr_9361<=10'h123; data_in<=8'h11;cnt1<=cnt1+1; end// Max Digital Gain
					37:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					38:begin wr_n<=1'b0;addr_9361<=10'h124; data_in<=8'hF5;cnt1<=cnt1+1; end// Max Digital Gain
					39:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					40:begin wr_n<=1'b0;addr_9361<=10'h125; data_in<=8'h3B;cnt1<=cnt1+1; end// Max Digital Gain
					41:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					42:begin wr_n<=1'b0;addr_9361<=10'h128; data_in<=8'h03;cnt1<=cnt1+1; end// Max Digital Gain
					43:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					44:begin wr_n<=1'b0;addr_9361<=10'h129; data_in<=8'h56;cnt1<=cnt1+1; end// Max Digital Gain
					45:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					46:begin wr_n<=1'b0;addr_9361<=10'h12A; data_in<=8'h22;cnt1<=cnt1+1; end// Max Digital Gain
					47:begin wr_n<=1'b1;if(flag_finish) begin cnt1<=0;state<=RXTX_BASE_FLT_CONFIG;end	end			
				
	
					//26:begin wr_n<=1'b0;addr_9361<=10'h10C; data_in<=8'h4C;cnt1<=cnt1+1; end// LMT Overload Exceeded Counters
					//27:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//28:begin wr_n<=1'b0;addr_9361<=10'h10D; data_in<=8'h18;cnt1<=cnt1+1; end// ADC Overload Exceeded Counters
					//29:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//30:begin wr_n<=1'b0;addr_9361<=10'h10E; data_in<=8'h00;cnt1<=cnt1+1; end// AGC Inner High & Low Step Sizes
					//31:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//32:begin wr_n<=1'b0;addr_9361<=10'h114; data_in<=8'h30;cnt1<=cnt1+1; end// Gain Update Counter<7:0>
					//33:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//34:begin wr_n<=1'b0;addr_9361<=10'h11A; data_in<=8'h27;cnt1<=cnt1+1; end// Gain Update Counter<15:8>
					//35:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//36:begin wr_n<=1'b0;addr_9361<=10'h081; data_in<=8'h00;cnt1<=cnt1+1; end// Digital Sat Exceeded Counter
					//37:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=RXTX_BASE_FLT_CONFIG; end end	
				endcase
			end
			RXTX_BASE_FLT_CONFIG:begin//13:RX adn TX Baseband Filter Tuning
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h1FB; data_in<=8'h14;cnt1<=cnt1+1; end// RX Freq Corner (MHz)
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h1FC; data_in<=8'h00;cnt1<=cnt1+1; end// RX Freq Corner (Khz)
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin wr_n<=1'b0;addr_9361<=10'h1F8; data_in<=8'h06;cnt1<=cnt1+1; end// Rx BBF Tune Divider[7:0]
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h1F9; data_in<=8'h1E;cnt1<=cnt1+1; end// RX BBF Tune Divider[8]
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h1D5; data_in<=8'h3F;cnt1<=cnt1+1; end// Set Rx Mix LO CM
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h1C0; data_in<=8'h03;cnt1<=cnt1+1; end// Set GM common mode
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h1E2; data_in<=8'h02;cnt1<=cnt1+1; end// Enable Rx1 Filter Tuner 
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h1E3; data_in<=8'h02;cnt1<=cnt1+1; end// Enable Rx2 Filter Tuner 
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h016; data_in<=8'h80;cnt1<=cnt1+1; end// Start RX Filter Tune
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin cnt1<=cnt1+1;num_1ms<=16'd1; state<=DELAY_ms; state_breakpoint<=RXTX_BASE_FLT_CONFIG;end//delay 2ms
					19:begin rd_n<=1'b0;addr_9361<=10'h016; cnt1<=cnt1+1; end// read CAL_RX_FLT done
					20:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[7]==0)cnt1<=cnt1+1;else begin cnt1<=0;state<=ERR_STATE; end end end	
					21:begin wr_n<=1'b0;addr_9361<=10'h1E2; data_in<=8'h03;cnt1<=cnt1+1; end// Disable Rx1 Filter Tuner 
					22:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					23:begin wr_n<=1'b0;addr_9361<=10'h1E3; data_in<=8'h03;cnt1<=cnt1+1; end// Disable Rx2 Filter Tuner 
					24:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					//
					25:begin wr_n<=1'b0;addr_9361<=10'h0D6; data_in<=8'h05;cnt1<=cnt1+1; end// TX BBF Tune Divider[7:0]
					26:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					27:begin wr_n<=1'b0;addr_9361<=10'h0D7; data_in<=8'h1E;cnt1<=cnt1+1; end// TX BBF Tune Divider[8]
					28:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					29:begin wr_n<=1'b0;addr_9361<=10'h0CA; data_in<=8'h22;cnt1<=cnt1+1; end// Enable Tx Filter Tuner
					30:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					31:begin wr_n<=1'b0;addr_9361<=10'h016; data_in<=8'h40;cnt1<=cnt1+1; end// Start Tx Filter Tune
					32:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					33:begin cnt1<=cnt1+1;num_1ms<=16'd2; state<=DELAY_ms; state_breakpoint<=RXTX_BASE_FLT_CONFIG;end//delay 2000ms
					34:begin rd_n<=1'b0;addr_9361<=10'h016; cnt1<=cnt1+1; end// read CAL_RX_FLT done
					35:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[6]==0) cnt1<=cnt1+1; else begin cnt1<=33; end end end	
					36:begin wr_n<=1'b0;addr_9361<=10'h0CA; data_in<=8'h26;cnt1<=cnt1+1; end// Disable Tx Filter Tuner (Both Channels)
					37:begin wr_n<=1'b1;if(flag_finish)begin state<=RX_TIA_CONFIG; cnt1<=0;end end	
					//37:begin wr_n<=1'b1;if(flag_finish)begin state<=TEST_DEBUG; cnt1<=0;end end	
				endcase
			end
			RX_TIA_CONFIG:begin//14:Setup values scale based on RxBBF calibration
				case(cnt1)
					0 :begin rd_n<=1'b0;addr_9361<=10'h1EB; cnt1<=cnt1+1; end// Read RXBBF C3(MSB)
					1 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin rd_n<=1'b0;addr_9361<=10'h1EC; cnt1<=cnt1+1; end// Read RXBBF C3(LSB)
					3 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin rd_n<=1'b0;addr_9361<=10'h1E6; cnt1<=cnt1+1; end// Read RXBBF R2346
					5 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h1DB; data_in<=8'h20;cnt1<=cnt1+1; end// Set TIA selcc[2:0]
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h1DD; data_in<=8'h00;cnt1<=cnt1+1; end// Set RX TIA1 C MSB[6:0]
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h1DF; data_in<=8'h00;cnt1<=cnt1+1; end// Set RX TIA2 C MSB[6:0]
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h1DC; data_in<=8'h47;cnt1<=cnt1+1; end// Set RX TIA1 C LSB[5:0]
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					14:begin wr_n<=1'b0;addr_9361<=10'h1DE; data_in<=8'h47;cnt1<=cnt1+1; end// Set RX TIA2 C LSB[5:0]
					15:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0;  state<=TX_2ND_FLT_CONFIG; end end						
				endcase
			end
			TX_2ND_FLT_CONFIG:begin//15:// TX Secondary Filter Calibration Setup:  Real Bandwidth
				case(cnt1)
					0:begin wr_n<=1'b0;addr_9361<=10'h0D2; data_in<=8'h04;cnt1<=cnt1+1; end// TX Secondary Filter PDF Cap cal[5:0]
					1:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2:begin wr_n<=1'b0;addr_9361<=10'h0D1; data_in<=8'h0C;cnt1<=cnt1+1; end// TX Secondary Filter PDF Res cal[3:0]
					3:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4:begin wr_n<=1'b0;addr_9361<=10'h0D0; data_in<=8'h57;cnt1<=cnt1+1; end// Pdampbias 
					5:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0;  state<=ADC_SETUP; end end						
				endcase
			end
			ADC_SETUP:begin//16:Tune ADC Performance based on RX analog filter tune
				case(cnt1)
					default:cnt1<=cnt1+1;
					0 :begin rd_n<=1'b0;addr_9361<=10'h1EB; cnt1<=cnt1+1; end// Read RXBBF C3(MSB)
					1 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin rd_n<=1'b0;addr_9361<=10'h1EC; cnt1<=cnt1+1; end// Read RXBBF C3(LSB)
					3 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4 :begin rd_n<=1'b0;addr_9361<=10'h1E6; cnt1<=cnt1+1; end// Read RXBBF R2346
					5 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h200+{4'd0,addr_AD_SETUP}; data_in<=douta_ADC_SETUP;cnt1<=cnt1+1; end// Set TIA selcc[2:0]
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin addr_AD_SETUP<=addr_AD_SETUP+1; cnt1<=cnt1+1; end
					16:begin if(addr_AD_SETUP==6'h28)cnt1<=cnt1+1;else cnt1<=6; end
					17:begin cnt1<=0;  state<=BB_RF_DC_CAL; end									
					//17:begin cnt1<=0;  state<=TEST_DEBUG; end					
				endcase
			end
			BB_RF_DC_CAL:begin//17:Setup and Run BB DC and RF DC Offset Calibrations
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h193; data_in<=8'h3F;cnt1<=cnt1+1; end
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h190; data_in<=8'h0F;cnt1<=cnt1+1; end// Set BBDC tracking shift M value, only applies when BB DC tracking enabled
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h194; data_in<=8'h01;cnt1<=cnt1+1; end// BBDC Cal setting
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h016; data_in<=8'h01;cnt1<=cnt1+1; end// Start BBDC offset cal
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end						
					8 :begin cnt1<=cnt1+1;num_1ms<=16'd99; state<=DELAY_ms; state_breakpoint<=BB_RF_DC_CAL;end//delay 100ms
					9 :begin rd_n<=1'b0;addr_9361<=10'h016; cnt1<=cnt1+1; end//Read BBDC Cal
					10:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[0]==0)cnt1<=cnt1+1;else begin cnt1<=0;state<=ERR_STATE;  end end end		
					//10:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[0]==0)begin cnt1<=0;state<=TEST_DEBUG;end else begin cnt1<=0;state<=ERR_STATE;  end end end		
					11:begin wr_n<=1'b0;addr_9361<=10'h185; data_in<=8'h20;cnt1<=cnt1+1; end// Set RF DC offset Wait Count
					12:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					13:begin wr_n<=1'b0;addr_9361<=10'h186; data_in<=8'h32;cnt1<=cnt1+1; end// Set RF DC Offset Count[7:0]
					14:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					15:begin wr_n<=1'b0;addr_9361<=10'h187; data_in<=8'h24;cnt1<=cnt1+1; end// Settings for RF DC cal
					16:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					17:begin wr_n<=1'b0;addr_9361<=10'h18B; data_in<=8'h83;cnt1<=cnt1+1; end// Settings for RF DC cal
					18:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					19:begin wr_n<=1'b0;addr_9361<=10'h188; data_in<=8'h05;cnt1<=cnt1+1; end// Settings for RF DC cal
					20:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					21:begin wr_n<=1'b0;addr_9361<=10'h189; data_in<=8'h30;cnt1<=cnt1+1; end// Settings for RF DC cal
					22:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					23:begin wr_n<=1'b0;addr_9361<=10'h016; data_in<=8'h02;cnt1<=cnt1+1; end// Start RFDC offset cal
					24:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					25:begin cnt1<=cnt1+1;num_1ms<=16'd19; state<=DELAY_ms; state<=BB_RF_DC_CAL;end//delay 20ms
					26:begin rd_n<=1'b0;addr_9361<=10'h016; cnt1<=cnt1+1; end//Read RFDC Cal
					27:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[1]==0)begin cnt1<=0; state<=TX_QUA_CAL;end else cnt1<=25;  end end		
					//27:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[1]==0)begin cnt1<=0; state<=TX_ATT_CONFIG;end else cnt1<=25;  end end		
					//27:begin rd_n<=1'b1;if(flag_finish)begin if(data_out[1]==0)begin cnt1<=0; state<=TEST_DEBUG;end else cnt1<=25;  end end			
				endcase
			end
			TX_QUA_CAL:begin//18:Tx Quadrature Calibration Settings
				case(cnt1)
					default:cnt1<=cnt1+1;
					0 :begin rd_n<=1'b0;addr_9361<=10'h0A3;cnt1<=cnt1+1; end// Masked Read:  Read lower 6 bits, overwrite [7:6] below
					1 :begin rd_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h0A0; data_in<=8'h75;cnt1<=cnt1+1; end// Set TxQuadcal NCO frequency
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h0A3; data_in<=8'hC0;cnt1<=cnt1+1; end// Set TxQuadcal NCO frequency (Only update bits [7:6])
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h0A1; data_in<=8'h7B;cnt1<=cnt1+1; end// Tx Quad Cal Configuration, Phase and Gain Cal Enable
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h0A9; data_in<=8'hFF;cnt1<=cnt1+1; end// Set Tx Quad Cal Count
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h0A2; data_in<=8'h7F;cnt1<=cnt1+1; end// Set Tx Quad Cal Kexp
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h0A5; data_in<=8'h01;cnt1<=cnt1+1; end// Set Tx Quad Cal Magnitude Threshhold
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h0A6; data_in<=8'h01;cnt1<=cnt1+1; end// Set Tx Quad Cal Magnitude Threshhold
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h0AA; data_in<=8'h25;cnt1<=cnt1+1; end// Set Tx Quad Cal Gain Table index
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h0A4; data_in<=8'hF0;cnt1<=cnt1+1; end// Set Tx Quad Cal Settle Count
					19:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					20:begin wr_n<=1'b0;addr_9361<=10'h0AE; data_in<=8'h00;cnt1<=cnt1+1; end// Set Tx Quad Cal LPF Gain index incase Split table mode used
					21:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					22:begin wr_n<=1'b0;addr_9361<=10'h169; data_in<=8'hC0;cnt1<=cnt1+1; end// Disable Rx Quadrature Calibration before Running Tx Quadrature Calibration
					23:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					24:begin wr_n<=1'b0;addr_9361<=10'h016; data_in<=8'h10;cnt1<=cnt1+1; end// Start Tx Quad cal
					25:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					26:begin cnt1<=cnt1+1;num_1ms<=16'd9; state<=DELAY_ms; state_breakpoint<=TX_QUA_CAL;end//delay 10ms
					27:begin rd_n<=1'b0;addr_9361<=10'h016; cnt1<=cnt1+1; end//Read RFDC Cal
					28:begin rd_n<=1'b1;if(flag_finish)begin  if(data_out[4]==0)cnt1<=cnt1+1;else begin cnt1<=26; end end end		
					29:begin wr_n<=1'b0;addr_9361<=10'h16A; data_in<=8'h75;cnt1<=cnt1+1; end// Set Kexp Phase
					30:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					31:begin wr_n<=1'b0;addr_9361<=10'h16B; data_in<=8'h95;cnt1<=cnt1+1; end// Set Kexp Amplitude & Prevent Positive Gain Bit
					32:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					33:begin wr_n<=1'b0;addr_9361<=10'h169; data_in<=8'hCF;cnt1<=cnt1+1; end// Enable Rx Quadrature Calibration Tracking
					34:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					35:begin wr_n<=1'b0;addr_9361<=10'h18B; data_in<=8'hAD;cnt1<=cnt1+1; end// Enable BB and RF DC Tracking Calibrations
					36:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					37:begin wr_n<=1'b0;addr_9361<=10'h012; data_in<=8'h10;cnt1<=cnt1+1; end// Cals done, Set PPORT Config
					38:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					39:begin wr_n<=1'b0;addr_9361<=10'h013; data_in<=8'h01;cnt1<=cnt1+1; end// Set ENSM FDD/TDD bit
					40:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					41:begin wr_n<=1'b0;addr_9361<=10'h015; data_in<=8'h0C;cnt1<=cnt1+1; end// Set Dual Synth Mode, FDD External Control bits properly
					//42:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=TEST_DEBUG; end end	
					42:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=TX_ATT_CONFIG; end end	
				endcase
			end
			TX_ATT_CONFIG:begin//19 Set Tx Attenuation: Tx1: 10.00 dB,  Tx2: 10.00 dB 
				case(cnt1)
					0:begin wr_n<=1'b0;addr_9361<=10'h073; data_in<=att_T_now[7:0];cnt1<=cnt1+1; end
					1:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2:begin wr_n<=1'b0;addr_9361<=10'h074; data_in<={7'd0,att_T_now[8]};cnt1<=cnt1+1; end
					3:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4:begin wr_n<=1'b0;addr_9361<=10'h075; data_in<={7'd0,att_T_now[8]};cnt1<=cnt1+1; end
					5:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6:begin wr_n<=1'b0;addr_9361<=10'h076; data_in<=8'h00;cnt1<=cnt1+1; end
					7:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					8:begin wr_n<=1'b0;addr_9361<=10'h077; data_in<=8'd0;cnt1<=cnt1+1; end
					9:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=RSSI_CONFIG; end end
				endcase
			end
			RSSI_CONFIG:begin//20:Setup RSSI and Power Measurement Duration Registers
				case(cnt1)
					0 :begin wr_n<=1'b0;addr_9361<=10'h150; data_in<=8'h0B;cnt1<=cnt1+1; end// RSSI Measurement Duration 0, 1
					1 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2 :begin wr_n<=1'b0;addr_9361<=10'h151; data_in<=8'h00;cnt1<=cnt1+1; end// RSSI Measurement Duration 2, 3
					3 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					4 :begin wr_n<=1'b0;addr_9361<=10'h152; data_in<=8'hFF;cnt1<=cnt1+1; end// RSSI Weighted Multiplier 0
					5 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6 :begin wr_n<=1'b0;addr_9361<=10'h153; data_in<=8'h00;cnt1<=cnt1+1; end// RSSI Weighted Multiplier 1
					7 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					8 :begin wr_n<=1'b0;addr_9361<=10'h154; data_in<=8'h00;cnt1<=cnt1+1; end// RSSI Weighted Multiplier 2
					9 :begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h155; data_in<=8'h00;cnt1<=cnt1+1; end// RSSI Weighted Multiplier 3
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h156; data_in<=8'h00;cnt1<=cnt1+1; end// RSSI Delay
					13:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					14:begin wr_n<=1'b0;addr_9361<=10'h157; data_in<=8'h00;cnt1<=cnt1+1; end// RSSI Wait
					15:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					16:begin wr_n<=1'b0;addr_9361<=10'h158; data_in<=8'h0D;cnt1<=cnt1+1; end// RSSI Mode Select
					17:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					18:begin wr_n<=1'b0;addr_9361<=10'h15C; data_in<=8'h69;cnt1<=cnt1+1; end// Power Measurement Duration
					19:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=TEST_DEBUG; end end	
				endcase
			end

			DELAY_us:begin
				if(cnt_1us==8'd39)begin
					cnt_1us<=0;
					if(acc_1us==num_1us)begin
						state<=state_breakpoint;acc_1us<=0;
					end
					else acc_1us<=acc_1us+1;
				end
				else cnt_1us<=cnt_1us+1;
			end
			DELAY_ms:begin
				if(cnt_1ms==16'd39_999)begin
					cnt_1ms<=0;
					if(acc_1ms==num_1ms)begin
						state<=state_breakpoint;acc_1ms<=0;
					end
					else acc_1ms<=acc_1ms+1;
				end
				else cnt_1ms<=cnt_1ms+1;
			end
			TX_POWER_SET:begin//21
				case(cnt1)
					0:begin wr_n<=1'b0;addr_9361<=10'h077; data_in<=8'd0;cnt1<=cnt1+1; end
					1:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					2:begin wr_n<=1'b0;addr_9361<=10'h07C; data_in<={1'b0,1'b0,6'd0};cnt1<=cnt1+1; end
					3:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					4:begin wr_n<=1'b0;addr_9361<=10'h073; data_in<=att_T_now[7:0];cnt1<=cnt1+1; end
					5:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6:begin wr_n<=1'b0;addr_9361<=10'h074; data_in<={7'd0,att_T_now[8]};cnt1<=cnt1+1; end
					7:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end
					8:begin wr_n<=1'b0;addr_9361<=10'h075; data_in<=att_T_now[7:0];cnt1<=cnt1+1; end
					9:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					10:begin wr_n<=1'b0;addr_9361<=10'h076; data_in<={7'd0,att_T_now[8]};cnt1<=cnt1+1; end
					11:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					12:begin wr_n<=1'b0;addr_9361<=10'h07C; data_in<={1'b0,1'b1,6'd0};cnt1<=cnt1+1; end
					13:begin wr_n<=1'b1;if(flag_finish)begin cnt1<=0; state<=TEST_DEBUG; end end
				endcase
			end
			TEST_DEBUG:begin
				case(cnt1)
					default:cnt1<=cnt1+1;
					3:begin wr_n<=1'b0;addr_9361<=10'h014; data_in<=8'h23;cnt1<=cnt1+1; end// Level set Set Force ALERT State bit
					4:begin wr_n<=1'b1;if(flag_finish)cnt1<=cnt1+1;end	
					6:begin cnt1<=cnt1+1;num_1ms<=16'd19; state<=DELAY_ms; state_breakpoint<=TEST_DEBUG;end//delay 20ms
					7:begin rd_n<=1'b0;addr_9361<=10'h017; cnt1<=cnt1+1;state_9361<=0; end// RSSI Wait
					8:begin rd_n<=1'b1;if(flag_finish) begin state_9361<=data_out;cnt1<=cnt1+1;end end	
					255:begin
						addr_9361<=addr_9361_vio;
						data_in<=data_in_vio;
						if(vio_1_d2 != vio_1_d3)begin
							rd_n<=0;
						end
						else rd_n<=1'b1;
						
						if(vio_2_d2 != vio_2_d3)begin
							wr_n<=0;
						end
						else wr_n<=1'b1;

						ini_succeed_9361[3]<=1'b1;
						if(SET_att_d3 != att_T_now)begin
							state<=TX_POWER_SET;cnt1<=0;
							att_T_now<=SET_att_d3;
						end						
						
						
					end
				endcase
			
			end
		endcase
	end
end	


receive_data_buf receive_data_buf_inst ( 
    .rst(rst_TR),
	 .clk(clk_TR),
	 .clk_TR2(clk_TR2),
	 .data_I_R_out(data_I_R),
	 .data_Q_R_out(data_Q_R),
	 .Rx_frame(Rx_frame_9361),
    .data_in(Rx_data_9361),
	 .clk_40M(clk_40M),
	 .rx_clk_in(rx_clk_in),
	 .adc_data(adc_data),
	 .l_clk(l_clk)
    );




reg [11:0] data_I_T_d1; reg [11:0] data_I_T_d2;
reg [11:0] data_Q_T_d1; reg [11:0] data_Q_T_d2;
always @(posedge clk_TR2)begin
	data_I_T_d1<=data_I_T;data_I_T_d2<=data_I_T_d1;
	data_Q_T_d1<=data_Q_T;data_Q_T_d2<=data_Q_T_d1;
end


transmit_data_buf transmitter_data_buf_inst (
    .rst(rst_TR),
	 .clk(clk_TR),
	 .clk_TR2(clk_TR2),
	 .data_I_T(data_I_T_d2),
	 .data_Q_T(data_Q_T_d2),
    .Tx_frame(Tx_frame_9361), 
	 .TX_FB_clk(Tx_clk_9361),
    .data_tx_out(Tx_data_9361),
	 .clk_40M(clk_40M)
    );


// *************************chipscope debug	
// wire [35:0] CONTROL0;wire [35:0] CONTROL1;
// icon_top icon_top_inst (
   // .CONTROL0(CONTROL0), // INOUT BUS [35:0]
   // .CONTROL1(CONTROL1) // INOUT BUS [35:0]
// );

// vio_top vio_top_inst (
   // .CONTROL(CONTROL1), // INOUT BUS [35:0]
   // .ASYNC_OUT(vio_out) // OUT BUS [31:0]
// );	

// wire [255:0] DATA; wire [31:0] TRIG0;
// ila_256_2048 ila_256_2048_inst (
   // .CONTROL(CONTROL0), // INOUT BUS [35:0]
   // .CLK(clk_2x_tx), // IN
   // .DATA(DATA), // IN BUS [255:0]
   // .TRIG0(TRIG0) // IN BUS [15:0]
// );
// assign TRIG0[4:0]=state;
// assign TRIG0[5]=SPI_ENB_9361;
// assign TRIG0[6]=wr_n;
// assign TRIG0[7]=rd_n;
// assign TRIG0[8]=EN_9361;
// assign TRIG0[31:24]=cnt1;


// assign DATA[4:0]=state;
// assign DATA[5 ]=SPI_ENB_9361;
// assign DATA[6 ]=SPI_DI_9361;
// assign DATA[7 ]=SPI_CLK_9361;
// assign DATA[8 ]=SPI_DO_9361;
// assign DATA[9 ]=RST_9361;
// assign DATA[10]=EN_9361;
// assign DATA[11]=EN_AGC_9361;
// assign DATA[12]=TXNRX_9361;
// assign DATA[16:13]=CTR_I_9361;
// assign DATA[24:17]=CTR_O_9361;
// assign DATA[25]=wr_n;
// assign DATA[26]=rd_n;
// assign DATA[36:27]=addr_9361;
// assign DATA[44:37]=data_in;
// assign DATA[52:45]=data_out;
// assign DATA[53]=flag_finish;
// assign DATA[61:54]=cnt1;

// assign DATA[66:63]=ini_succeed_9361;
// assign DATA[78:67]=data_I_R;
// assign DATA[90:79]=data_Q_R;
// assign DATA[102:91]=data_I_T;
// assign DATA[114:103]=data_Q_T;
// assign DATA[115]=Tx_clk_9361;
// assign DATA[116]=Tx_frame_9361;
// assign DATA[128:117]=Tx_data_9361;
// assign DATA[129]=rst_TR;
// assign DATA[130]=clk_TR;

endmodule
 


