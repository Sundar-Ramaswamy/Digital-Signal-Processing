
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:29 11/18/2016 
// Design Name: 
// Module Name:    transmit_data_buf 
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
module transmit_data_buf(
	input  clk,
	input clk_TR2,
	output reg TX_FB_clk,
	input  [11:0] data_I_T,
	input  [11:0] data_Q_T,	
	output reg Tx_frame,
	input  rst,
	output reg [5:0] data_tx_out,
	input clk_40M
    );


wire [11:0] data_I_T_b1;wire [11:0] data_Q_T_b1;

reg [11:0] data_I_T_d1;reg [11:0] data_I_T_d2;
reg [11:0] data_Q_T_d1;reg [11:0] data_Q_T_d2;

reg [5:0] data_tx_out_H;
reg [5:0] data_tx_out_L;
//reg Tx_frame_b1 = 0;

/* assign Tx_frame = Tx_frame_b1;
//assign TX_FB_clk = clk_TR_80M;

always @(posedge clk_TR2)begin

//TX_FB_clk <= ~TX_FB_clk;
TX_FB_clk <= clk_TR_80M;
end

always @(posedge clk_TR_80M)begin
	data_I_T_d1<=data_I_T;data_I_T_d2<=data_I_T_d1;
	data_Q_T_d1<=data_Q_T;data_Q_T_d2<=data_Q_T_d1;
	Tx_frame_b1 <= Tx_frame_b1 + 1'b1;
	case(Tx_frame_b1)
	1'b1:
		begin
		data_tx_out_H <= data_I_T_d2[11:6];
		data_tx_out_L <= data_Q_T_d2[11:6];
		end
	1'b0:
		begin
		data_tx_out_H <= data_I_T_d2[5:0];
		data_tx_out_L <= data_Q_T_d2[5:0];
		end	
	default:
		begin
		data_tx_out_H <= data_tx_out_H;
		data_tx_out_L <= data_tx_out_L;
		end			
	endcase

end
wire [5:0] data_tx_out_b1;
assign data_tx_out = data_tx_out_b1;
DDIO_OUT	DDIO_OUT_inst (
	.datain_h ( data_tx_out_H ),
	.datain_l ( data_tx_out_L ),
	.outclock ( clk_TR_80M ),
	.dataout ( data_tx_out_b1 )
	);
	 */
	
reg rst_d11 = 0; reg rst_d12 = 0;reg rst_d13 = 0; reg rst_d14 = 0;
reg en_buffer=0;
always @(posedge clk_TR2)begin
	rst_d11<=rst;
	rst_d12<=rst_d11;
	rst_d13<=rst_d12;
	rst_d14<=rst_d13;
end

/* ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst0  (.Q(data_tx_out[0 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[0 ]),.D1(data_Q_T_d2[0 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst1  (.Q(data_tx_out[1 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[1 ]),.D1(data_Q_T_d2[1 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst2  (.Q(data_tx_out[2 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[2 ]),.D1(data_Q_T_d2[2 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst3  (.Q(data_tx_out[3 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[3 ]),.D1(data_Q_T_d2[3 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst4  (.Q(data_tx_out[4 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[4 ]),.D1(data_Q_T_d2[4 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst5  (.Q(data_tx_out[5 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[5 ]),.D1(data_Q_T_d2[5 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst6  (.Q(data_tx_out[6 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[6 ]),.D1(data_Q_T_d2[6 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst7  (.Q(data_tx_out[7 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[7 ]),.D1(data_Q_T_d2[7 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst8  (.Q(data_tx_out[8 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[8 ]),.D1(data_Q_T_d2[8 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst9  (.Q(data_tx_out[9 ]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[9 ]),.D1(data_Q_T_d2[9 ]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst10 (.Q(data_tx_out[10]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[10]),.D1(data_Q_T_d2[10]),.R(1'b0),.S(1'b0));
ODDR2 #( .DDR_ALIGNMENT("C0"), .INIT(1'b0),  .SRTYPE("ASYNC") ) ODDR_inst11 (.Q(data_tx_out[11]),.C0(clk),.C1(~clk),.CE(1'b1),.D0(data_I_T_d2[11]),.D1(data_Q_T_d2[11]),.R(1'b0),.S(1'b0));
     
   */
reg rdreq = 0;
transmit_data_fifo	transmit_data_fifo_U (
	.data ( {data_I_T,data_Q_T} ),
	.rdclk ( clk_TR2 ),
	.rdreq ( rdreq ),
	.wrclk ( clk_40M ),
	.wrreq ( 1'b1 ),
	.q ( {data_I_T_b1,data_Q_T_b1} )
	);

reg [1:0] cnt_frame = 0;
reg Tx_frame_b2 = 0;
reg Tx_frame_b1 = 0;
reg TX_FB_clk_b2 = 0;
reg TX_FB_clk_b1 = 0;
reg [5:0] data_tx_out_b2 = 0;
reg [5:0] data_tx_out_b1 = 0;

always @(posedge clk_TR2)begin

		data_I_T_d2<=data_I_T_b1;
		data_Q_T_d2<=data_Q_T_b1;

		
	if(rst_d14)begin
		cnt_frame<=2'd0;
		//Tx_frame<=0;
		en_buffer<=0;
		rdreq <= 1'b0;
	end
	else begin
		en_buffer<=1;
		cnt_frame<=cnt_frame+1;
		case(cnt_frame)
			2'd0:begin
				Tx_frame_b2<=1;
				TX_FB_clk_b2<=1;
				data_tx_out_b2<=data_I_T_d2[11:6];
				rdreq <= 1'b0;
			end
			2'd1:begin
				Tx_frame_b2<=1;
				TX_FB_clk_b2<=0;
				data_tx_out_b2<=data_Q_T_d2[11:6];
				rdreq <= 1'b0;
			 end
			2'd2:begin
				Tx_frame_b2<=0;
				TX_FB_clk_b2<=1;
				data_tx_out_b2<=data_I_T_d2[5:0];
				rdreq <= 1'b0;
			end
			2'd3:begin
				Tx_frame_b2<=0;
				TX_FB_clk_b2<=0;
				data_tx_out_b2<=data_Q_T_d2[5:0];
				rdreq <= 1'b1;
			 end
			default:data_tx_out_b2 <= data_tx_out_b2;
		endcase
	end
	
	Tx_frame_b1 <= Tx_frame_b2;
	Tx_frame    <= Tx_frame_b1;

	TX_FB_clk_b1 <= TX_FB_clk_b2;
	TX_FB_clk    <= TX_FB_clk_b1;
	
	data_tx_out_b1 <= data_tx_out_b2;
	data_tx_out    <= data_tx_out_b1;
	
end

/* assign Tx_frame = TX_FB_clk_b2;
assign TX_FB_clk = clk_TR_80M;
assign data_tx_out = data_tx_out_b2; */

/* always @(posedge clk_TR2)begin
	if(rst_d14)begin
		cnt_frame<=1;Tx_frame<=0;en_buffer<=0;
	end
	else begin
		en_buffer<=1;
		cnt_frame<=cnt_frame+1;
		case(cnt_frame)
			0:begin
				Tx_frame<=0;
				TX_FB_clk<=0;
				data_tx_out<=data_Q_T_d2;
			end
			1:begin
				Tx_frame<=1;
				TX_FB_clk<=1;
				data_tx_out<=data_I_T_d2;
			 end
		endcase
	end
end */

/* reg clk_TR_80M_d1;
reg clk_TR_80M_d2;
reg Tx_frame_d1;
reg Tx_frame_d2; */

//always @ (posedge clk_TR2)
//	begin
//	clk_TR_80M_d2 <= clk_TR_80M_d1;
//	clk_TR_80M_d1 <= clk_TR_80M;	
//	
//	Tx_frame_d2 <= Tx_frame_d1;
//	Tx_frame_d1 <= clk;
//	end



//assign TX_FB_clk = clk_TR_80M_d1;
//assign Tx_frame  = Tx_frame_d2; 




endmodule
