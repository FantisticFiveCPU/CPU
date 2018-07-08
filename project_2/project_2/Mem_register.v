`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/07 18:53:40
// Design Name: 
// Module Name: Mem_register
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


module Mem_register(
    input Overflow,
    input [31:0]DataOut,
    input [31:0]Addr,
    input [4:0]Rw_in,
    input RegWr,
    input MemtoReg,
    input clk,
    output reg [31:0]DataIn,
    output reg WE,
    output reg [4:0]Rw
       );
    always@(negedge clk)
    begin
     WE<=(~Overflow)&RegWr;
    Rw<=Rw_in;
    if(MemtoReg)
    DataIn<=DataOut;
    else 
    DataIn<=Addr;
    end 
endmodule
