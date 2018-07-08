`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/07 14:33:53
// Design Name: 
// Module Name: inst_rom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module inst_rom(
    input [31:0] PC_in,
    input clk,
    input reset,
    output reg [31:0]PC_out,
    output reg [31:0] inst
    );
    reg [31:0] PP;
 reg [8:0] Rom [511:0];
wire [8:0]addr=PC_in[8:0];
integer i;
initial 
begin
for(i=0;i<512;i=i+1)
Rom[i]<=i;
end
always @(negedge clk)
if(reset==1)
begin
PC_out<=0;
inst<=Rom[addr];
end
else 
begin
PP<=PC_in+4;
PC_out<=PP;
inst<=Rom[addr];
end
endmodule
