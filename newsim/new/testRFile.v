`timescale 1ns / 1ps

module testRFile;
reg clk;
reg [31:0] instru;
reg [4:0] Rw;
reg [31:0] Di;
reg WE;
reg reset;

wire [4:0] Rt,Rd;
wire [15:0] imm16;
wire [4:0] busA,busB;

RFile tF(
.clk(clk),
.instru(instru),
.Rw(Rw),
.Di(Di),
.WE(WE),
.reset(reset),
.Rt(Rt),
.Rd(Rd),
.imm16(imm16),
.busA(busA),
.busB(busB)
);

initial begin
reset=0;
clk=0; forever #5 clk=~clk;
end

initial begin
#0
instru={6'b000000,5'b00001,5'b00010,5'b00011,5'b00000,6'b100000};
WE=1;
Rw=2;
Di=5;
#15
instru={6'b000000,5'b00001,5'b00010,5'b00011,5'b00000,6'b100000};
WE=0;
Rw=1;
Di=0;
end
endmodule
