`timescale 1ns / 1ps

module testtest;
reg clk;
reg  [31:0] instru;
reg  [4:0] Rw_in;
reg  [31:0] Di;
reg WE;
reg reset;
reg [31:0] PC;

wire [4:0] Rw_out;
wire [31:0] newPC;
wire Zero;
wire Overflow;
wire [31:0] ALUout;
wire MW;
wire BR;
wire MR;
wire RW;
wire [31:0] BB;

Test te(
.clk(clk),
.instru(instru),
.Rw_in(Rw_in),
.Di(Di),
.WE(WE),
.reset(reset),
.PC(PC),

.Rw_out(Rw_out),
.newPC(newPC),
.Zero(Zero),
.Overflow(Overflow),
.ALUout(ALUout),
.MW(MW),
.BR(BR),
.MR(MR),
.RW(RW),
.BB(BB)
);

initial begin
reset=0;
PC=0;
clk=0; forever #5 clk=~clk;
end

initial begin
#0
instru={6'b000000,5'b00001,5'b00010,5'b00011,5'b00000,6'b100000};
WE=1;
Rw_in=2;
Di=5;
end

endmodule
