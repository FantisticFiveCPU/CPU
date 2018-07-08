`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/07 18:16:55
// Design Name: 
// Module Name: GetIns
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


module GetIns(
    input [31:0]PC,
    input Branch,
    input Zero,
    input clk,
    input [31:0]NewPC,
    output reg [31:0]PC_out
    );
    
reg sig;
initial begin
sig=Branch&Zero;
end
    always @(negedge clk) 
    begin 
    if(sig==1)
    begin
    PC_out<=NewPC;
    end
    else 
    begin
    PC_out<=PC;
    end
    end
    
    
endmodule
