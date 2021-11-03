`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:33:09 09/29/2016 
// Design Name: 
// Module Name:    ad9361_wr_rd 
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
module ad9361_wr_rd(
   input clk,
	input rst,
	input wr_n,
	input rd_n,
	input [9:0] addr_9361,
	input [7:0] data_in,
	output reg [7:0] data_out,
	output reg flag_finish,
	 // phsic ports
	output reg scs_n,
	output reg sclk,//posedge send data,negedge get data
	output reg mosi,
	input miso
	 );
reg rst_d;
reg miso_d;
always @ (posedge clk)begin
	rst_d<=rst;
	miso_d<=miso;
end 
//main con
reg [1:0] state;
reg [9:0] addr_9361_reg;
reg [7:0] data_in_reg;
reg [1:0] cnt10;
reg [7:0] cnt11;
reg [7:0] data_out_temp;
always @(posedge clk)begin
	if(rst_d)begin//output reg ini
		state<=0;
	end
	else begin
		case(state)
			0:begin//default state
				data_out_temp<=0;
				flag_finish<=0;
				sclk<=1'b0;
				mosi<=1'b1;
				addr_9361_reg<=addr_9361;
				cnt10<=0;cnt11<=0;
				data_in_reg<=data_in;//ini 1st byte when writing
				if(wr_n==0)begin
					state<=1;
					scs_n<=1'b0;
				end
				else if(rd_n==0)begin
					state<=2;
					scs_n<=1'b0;
				end
				else scs_n<=1'b1;
			end
			1:begin//write state
				cnt10<=cnt10+1;
				case(cnt10)
					0:begin
						sclk<=1'b1;
						case(cnt11)
							8'd0 :mosi<=1'b1;//1:wr 0:rd
							8'd1 :mosi<=1'b0;
							8'd2 :mosi<=1'b0;
							8'd3 :mosi<=1'b0;
							8'd4 :mosi<=1'b0;//unused
							8'd5 :mosi<=1'b0;//unused
							8'd6 :mosi<=addr_9361_reg[9];
							8'd7 :mosi<=addr_9361_reg[8];
							8'd8 :mosi<=addr_9361_reg[7];
							8'd9 :mosi<=addr_9361_reg[6];
							8'd10:mosi<=addr_9361_reg[5];
							8'd11:mosi<=addr_9361_reg[4];
							8'd12:mosi<=addr_9361_reg[3];
							8'd13:mosi<=addr_9361_reg[2];
							8'd14:mosi<=addr_9361_reg[1];
							8'd15:mosi<=addr_9361_reg[0];
							8'd16:mosi<=data_in_reg[7];
							8'd17:mosi<=data_in_reg[6];
							8'd18:mosi<=data_in_reg[5];
							8'd19:mosi<=data_in_reg[4];
							8'd20:mosi<=data_in_reg[3];
							8'd21:mosi<=data_in_reg[2];
							8'd22:mosi<=data_in_reg[1];
							8'd23:mosi<=data_in_reg[0];
							default:mosi<=1'b0;						
						endcase
					end
					2:sclk<=1'b0;
					3:begin
						if(cnt11==8'd23)state<=3;
						else cnt11<=cnt11+1;
					end
				endcase
			end
			2:begin//read state
				cnt10<=cnt10+1;
				case(cnt10)
					0:begin
						sclk<=1'b1;
						case(cnt11)
							16'd0 :mosi<=1'b0;//1:wr 0:rd
							16'd1 :mosi<=1'b0;
							16'd2 :mosi<=1'b0;
							16'd3 :mosi<=1'b0;
							16'd4 :mosi<=1'b0;//unused
							16'd5 :mosi<=1'b0;//unused
							16'd6 :mosi<=addr_9361_reg[9];
							16'd7 :mosi<=addr_9361_reg[8];
							16'd8 :mosi<=addr_9361_reg[7];
							16'd9 :mosi<=addr_9361_reg[6];
							16'd10:mosi<=addr_9361_reg[5];
							16'd11:mosi<=addr_9361_reg[4];
							16'd12:mosi<=addr_9361_reg[3];
							16'd13:mosi<=addr_9361_reg[2];
							16'd14:mosi<=addr_9361_reg[1];
							16'd15:mosi<=addr_9361_reg[0];	
							default:mosi<=0;							
						endcase
					end
					2:begin
						sclk<=1'b0;
						if(cnt11>15)begin
							if(cnt11[2:0]==3'd7)begin
								data_out<={data_out_temp[6:0],miso_d};
								data_out_temp<=0;
							end
							else begin
								data_out_temp[0]<=miso_d;
								data_out_temp[7:1]<=data_out_temp[6:0];
							end
						end
					end
					3:begin
						if(cnt11==8'd23 )state<=3;
						else cnt11<=cnt11+1;
					end
				endcase
			end
			3:begin//
				scs_n<=1'b1;
				flag_finish<=1;
				state<=0;
			end
		endcase
	end
end

endmodule
