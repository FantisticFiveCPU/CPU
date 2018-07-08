`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/07 15:36:59
// Design Name: 
// Module Name: inst_ram
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


module inst_ram(
    input clk,
    input [3:0]WrEn,
    input [31:0]Adr,
    input [31:0]DataIn,
    output reg [31:0]DataOut
    );
    wire [8:0]ad=Adr[8:0];
    reg [31:0]Ram[511:0];
    integer i;
initial 
    begin
    for(i=0;i<512;i=i+1)
    Ram[i]<=0;
    end

    always@ (negedge clk)
    begin 
    if(WrEn[0])
        begin 
            Ram[ad][7:0]<=DataIn[7:0];
        end
     end          
   always@(negedge clk)
   begin
      if(WrEn[1])
      begin 
           Ram[ad][15:8]<=DataIn[15:8];
       end
    end
   always@(negedge clk)
   begin
    if(WrEn[2])
      begin 
        Ram[ad][23:16]<=DataIn[23:16];
      end
   end
   always@(negedge clk)
     begin
         if(WrEn[3])
       begin 
           Ram[ad][31:24]<=DataIn[31:24];
       end 
     end
   always@(negedge clk)
      begin
        DataOut<=Ram[ad];
     end
  
endmodule
