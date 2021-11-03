`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:35:02 07/16/2018 
// Design Name: 
// Module Name:    manage_top 
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
module manage_top(
	input clk,
	//9361_RF
	input [3:0] ini_succeed_9361,
	input [7:0] state_9361,
	output reg rst_clk,
	input locked_clk,
	output reg rst_config=1,//config hardware
	output reg rst_TR=1,//config Transmitter and Receiver
	output reg [7:0] err_top_state
    );

//***************************basic delay
reg [3:0] ini_succeed_9361_d1;reg [3:0] ini_succeed_9361_d2;reg [3:0] ini_succeed_9361_d3;reg [3:0] ini_succeed_9361_d4;
reg [7:0] state_9361_d1;reg [7:0] state_9361_d2;reg [7:0] state_9361_d3;reg [7:0] state_9361_d4;
reg locked_clk_d1;reg locked_clk_d2;reg locked_clk_d3;reg locked_clk_d4;

always @(posedge clk)begin
	ini_succeed_9361_d1<=ini_succeed_9361;ini_succeed_9361_d2<=ini_succeed_9361_d1;ini_succeed_9361_d3<=ini_succeed_9361_d2;ini_succeed_9361_d4<=ini_succeed_9361_d3;
	state_9361_d1<=state_9361;state_9361_d2<=state_9361_d1;state_9361_d3<=state_9361_d2;state_9361_d4<=state_9361_d3;
	locked_clk_d1<=locked_clk;locked_clk_d2<=locked_clk_d1;locked_clk_d3<=locked_clk_d2;locked_clk_d4<=locked_clk_d3;
end


reg [7:0] cnt0=0;
always @(posedge clk)begin
	err_top_state<=cnt0;
	case(cnt0)
		default:cnt0 <= cnt0 + 8'd1;
		1:begin
			rst_clk<=1'b1;
			rst_config<=1;
			rst_TR<=1'b1;
			cnt0 <= cnt0 + 8'd1;
		end
		15:begin
			rst_config<=0;cnt0 <= cnt0 + 8'd1;
		end
		31:begin
			if(ini_succeed_9361_d4==4'b1111)cnt0 <= cnt0 + 8'd1;
		end
		33:begin
			if(state_9361_d4==8'h1A)cnt0 <= cnt0 + 8'd1;
		end
		40:begin
			cnt0 <= cnt0 + 8'd1;rst_clk<=1'b0;
		end
		200:begin
			if(locked_clk_d4)cnt0 <= cnt0 + 8'd1;
		end
		255:begin
			rst_TR<=1'b0;
		end
	endcase
end


endmodule
