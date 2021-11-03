`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:37:10 11/18/2016 
// Design Name: 
// Module Name:    receive_data_buf 
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
module receive_data_buf(
	input clk, //40M
	input clk_TR2,//160M
	input Rx_frame,//40M
	input rst,
	output [11:0] data_I_R_out,
	output [11:0] data_Q_R_out,
	input [5:0] data_in,
	input clk_40M,
	input rx_clk_in,
	output [47:0] adc_data,
	output l_clk
    );

reg [11:0] data_I_R;reg [11:0] data_Q_R;
reg [11:0] data_I_R_temp;reg [11:0] data_Q_R_temp;
//reg [11:0] data_I_R_temp_d;reg [11:0] data_Q_R_temp_d;
//assign data_I_R=data_I_R_temp;
//assign data_Q_R=data_Q_R_temp;
//
//

//always @(posedge clk)begin
//	data_I_R_temp_d<=data_I_R_temp;data_Q_R_temp_d<=data_Q_R_temp;
//	data_I_R<=data_I_R_temp_d;data_Q_R<=data_Q_R_temp_d;
//end

reg rst_d11; reg rst_d12;reg rst_d13; reg rst_d14;
reg en_buffer=0;
reg [2:0] addra=0;
reg [2:0] addrb=0;
always @(posedge rx_clk_in)begin
	rst_d11<=rst;rst_d12<=rst_d11;rst_d13<=rst_d12;rst_d14<=rst_d13;
	if(rst_d14)begin
		en_buffer<=0;addra<=0;addrb<=4;
	end
	else begin
		en_buffer<=1;addra<=addra+1; addrb<=addrb+1;
	end
end


wire FIFO_receiver_rdempty;
wire FIFO_receiver_wrfull;
wire rx_clk_in_TR2;
wire Rx_frame_TR2;
wire [5:0] data_in_TR2;
reg FIFO_cnt2 = 0; 
/* always @ (posedge clk_TR2)
	FIFO_cnt2 <= FIFO_cnt2 + 1'b1;
 */
//	FIFO_receiver	FIFO_receiver_u (
//				.data ({rx_clk_in,Rx_frame,data_in}),
//				.rdclk (clk_TR2),
//				.rdreq (1'b1),
//				.wrclk (clk_TR2),
//				.wrreq (1'b1),
//				.q ({rx_clk_in_TR2,Rx_frame_TR2,data_in_TR2}),
//				.rdempty (FIFO_receiver_rdempty),
//				.wrfull (FIFO_receiver_wrfull));
//
//

wire [5:0] data_in_high_B1;
wire [5:0] data_in_low_B1;

wire [5:0] data_in_high;
wire [5:0] data_in_low;

wire [5:0] data_in_d1;

	IO_BUF	IO_BUF_inst_data_in (
	.datain ( data_in ),
	.dataout ( data_in_d1 )
	);
		
		
DDIO_IN	DDIO_IN_inst (
	.datain ( data_in_d1 ),
	.inclock (  rx_clk_in ),
	.dataout_h ( data_in_high_B1 ),
	.dataout_l ( data_in_low_B1 )
	);
wire Rx_frame_high_B1;
wire Rx_frame_low_B1;
wire Rx_frame_high;
DDIO_IN	DDIO_IN_frame (
	.datain ( Rx_frame ),
	.inclock (  rx_clk_in ),
	.dataout_h ( Rx_frame_high_B1 ),
	.dataout_l ( Rx_frame_low_B1 )
	);
	
	
	IO_BUF	IO_BUF_inst_HIGH (
	.datain ( data_in_high_B1 ),
	.dataout ( data_in_high )
	);
	
	IO_BUF	IO_BUF_inst_LOW (
	.datain ( data_in_low_B1 ),
	.dataout ( data_in_low )
	);
	
	IO_BUF	IO_BUF_inst_rx_frame (
	.datain ( Rx_frame_high_B1 ),
	.dataout ( Rx_frame_high )
	);	
	reg [5:0] data_in_low_d1;
	reg [11:0] data_I_R_temp_d1;
	reg [11:0] data_Q_R_temp_d1;
	
	reg [11:0] data_I_R_b2;
	reg [11:0] data_I_R_b1;
	
	reg [11:0] data_Q_R_b2;
	reg [11:0] data_Q_R_b1;
	
	
	reg wrreq = 0;
always @ (posedge rx_clk_in)
	begin
	case(Rx_frame_high)
		1'b0: 
			begin
			//data_I_R_temp[11:6] <= data_in_high;
			//data_I_R_temp[5:0]  <= data_I_R_temp[5:0];
			//data_Q_R_temp[11:6] <= data_in_low;
			//data_Q_R_temp[5:0]  <= data_Q_R_temp[5:0]; 
			
			data_I_R_temp[11:6] <= data_I_R_temp[11:6];
			data_I_R_temp[5:0]  <= data_in_high;
			
			data_in_low_d1 <= data_in_low;
			
			//data_Q_R_temp[11:6] <= data_in_low;
			//data_Q_R_temp[5:0]  <= data_Q_R_temp[5:0]; 
			
			
		 	data_Q_R_temp[11:6] <= data_Q_R_temp[11:6];
			data_Q_R_temp[5:0]  <= data_in_low;  
			end
		1'b1:
			begin
			//data_I_R_temp[11:6] <= data_I_R_temp[11:6];
			//data_I_R_temp[5:0]  <= data_in_high;
			//data_Q_R_temp[11:6] <= data_Q_R_temp[11:6];
			//data_Q_R_temp[5:0]  <= data_in_low; 
			
			data_I_R_temp[11:6] <= data_in_high;
			data_I_R_temp[5:0]  <= data_I_R_temp[5:0];
			
			data_in_low_d1 <= data_in_low;

		//	data_Q_R_temp[11:6] <= data_Q_R_temp[11:6];
		//	data_Q_R_temp[5:0]  <= data_in_low; 
			data_Q_R_temp[11:6] <= data_in_low;
			data_Q_R_temp[5:0]  <= data_Q_R_temp[5:0]; 
			end
		
		default:
			begin
			data_I_R_temp[11:6] <= data_I_R_temp[11:6];
			data_I_R_temp[5:0]  <= data_I_R_temp[5:0];
			data_Q_R_temp[11:6] <= data_Q_R_temp[11:6];
			data_Q_R_temp[5:0]  <= data_Q_R_temp[5:0];
			end
	endcase	
		data_I_R_temp_d1 <= data_I_R_temp;
		data_Q_R_temp_d1 <= data_Q_R_temp;
		if(Rx_frame_high)
			begin
			data_I_R_b2 <= data_I_R_temp;
			data_Q_R_b2 <= data_Q_R_temp;	
			wrreq <= 1'b1;			
			end
		else
			begin
			data_I_R_b2 <= data_I_R_b2;
			data_Q_R_b2 <= data_Q_R_b2;
			wrreq <= 1'b0;	
			end

		data_I_R_b1 <= data_I_R_b2;
		data_I_R    <= data_I_R_b1;
		
		data_Q_R_b1 <= data_Q_R_b2;
		data_Q_R    <= data_Q_R_b1;
	
	end




transmit_data_fifo	receive_data_fifo_U2 (
	.data ( {data_I_R,data_Q_R} ),
	.rdclk ( clk_40M ),
	.rdreq ( 1'b1 ),
	.wrclk ( rx_clk_in ),
	.wrreq ( wrreq ),
	.q ( {data_I_R_out,data_Q_R_out} )
	);



/* IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst0  (.Q0(data_I_R_temp[0 ]),.Q1(data_Q_R_temp[0 ]),.C0(clk),.C1(~clk),.D(data_in[0 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst1  (.Q0(data_I_R_temp[1 ]),.Q1(data_Q_R_temp[1 ]),.C0(clk),.C1(~clk),.D(data_in[1 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst2  (.Q0(data_I_R_temp[2 ]),.Q1(data_Q_R_temp[2 ]),.C0(clk),.C1(~clk),.D(data_in[2 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst3  (.Q0(data_I_R_temp[3 ]),.Q1(data_Q_R_temp[3 ]),.C0(clk),.C1(~clk),.D(data_in[3 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst4  (.Q0(data_I_R_temp[4 ]),.Q1(data_Q_R_temp[4 ]),.C0(clk),.C1(~clk),.D(data_in[4 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst5  (.Q0(data_I_R_temp[5 ]),.Q1(data_Q_R_temp[5 ]),.C0(clk),.C1(~clk),.D(data_in[5 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst6  (.Q0(data_I_R_temp[6 ]),.Q1(data_Q_R_temp[6 ]),.C0(clk),.C1(~clk),.D(data_in[6 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst7  (.Q0(data_I_R_temp[7 ]),.Q1(data_Q_R_temp[7 ]),.C0(clk),.C1(~clk),.D(data_in[7 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst8  (.Q0(data_I_R_temp[8 ]),.Q1(data_Q_R_temp[8 ]),.C0(clk),.C1(~clk),.D(data_in[8 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst9  (.Q0(data_I_R_temp[9 ]),.Q1(data_Q_R_temp[9 ]),.C0(clk),.C1(~clk),.D(data_in[9 ]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst10 (.Q0(data_I_R_temp[10]),.Q1(data_Q_R_temp[10]),.C0(clk),.C1(~clk),.D(data_in[10]), .CE(1'b1),.R(1'b0),.S(1'b0) );               
IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0), .INIT_Q1(1'b0),.SRTYPE("ASYNC") ) IDDR_inst11 (.Q0(data_I_R_temp[11]),.Q1(data_Q_R_temp[11]),.C0(clk),.C1(~clk),.D(data_in[11]), .CE(1'b1),.R(1'b0),.S(1'b0) );               

 */

//wire [15:0] data_I_R_16;
//wire [15:0] data_Q_R_16;
//assign data_I_R = data_I_R_16[11:0];
//assign data_Q_R = data_Q_R_16[11:0];
//ram_dual_8_12bits ram_dual_8_12bits_i (
//  .wrclock(clk), // input clka
//  .wren(en_buffer), // input [0 : 0] wea
//  .wraddress(addra), // input [2 : 0] addra
//  .data({4'd0,data_I_R_temp}), // input [11 : 0] dina
//  .rdclock(clk), // input clkb
//  .rdaddress(addrb), // input [2 : 0] addrb
//  .q(data_I_R_16) // output [11 : 0] doutb
//);
//ram_dual_8_12bits ram_dual_8_12bits_q (
//  .wrclock(clk), // input clka
//  .wren(en_buffer), // input [0 : 0] wea
//  .wraddress(addra), // input [2 : 0] addra
//  .data({4'd0,data_Q_R_temp}), // input [11 : 0] dina
//  .rdclock(clk), // input clkb
//  .rdaddress(addrb), // input [2 : 0] addrb
//  .q(data_Q_R_16) // output [11 : 0] doutb
//);
//


/////////chipscope
//wire [31:0] vio_out;
//wire [35:0] CONTROL0;wire [35:0] CONTROL1;
//icon_debug icon_debug_inst (
//    .CONTROL0(CONTROL0), // INOUT BUS [35:0]
//    .CONTROL1(CONTROL1) // INOUT BUS [35:0]
//);
//
//vio_debug vio_debug_inst (
//    .CONTROL(CONTROL1), // INOUT BUS [35:0]
//    .ASYNC_OUT(vio_out) // OUT BUS [31:0]
//);	
//
//wire [63:0] DATA; wire [7:0] TRIG0;
//ila_64_4096 ila_64_4096_inst (
//    .CONTROL(CONTROL0), // INOUT BUS [35:0]
//    .CLK(clk), // IN
//    .DATA(DATA), // IN BUS [255:0]
//    .TRIG0(TRIG0) // IN BUS [15:0]
//);
//assign DATA[11:0]  = data_I_R;
//assign DATA[23:12] = data_Q_R;
//assign DATA[35:24] = data_in_d4;
//assign DATA[36] = Rx_frame_d4;


endmodule
