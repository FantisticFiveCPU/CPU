`timescale 1ns / 1ps

module ExecUnit(PC,busA,busB,imm16,func,ExtOp,ALUsrc,ALUOp,R_type,newPC,Zero,Overflow,ALUout,Rt,Rd,Rw,RegDst,MemWr,Branch,MemtoReg,RegWr,MW,BR,MR,RW,BB);
input [31:0] PC;
input [31:0] busA;
input [31:0] busB;
input [15:0] imm16;
input [5:0] func;
input ExtOp;
input ALUsrc;
input [2:0] ALUOp;
input R_type;
input [4:0] Rt;
input [4:0] Rd;
input RegDst;
input MemWr;
input Branch;
input MemtoReg;
input RegWr;
output [4:0] Rw;
output [31:0] newPC;
output Zero;
output Overflow;
output [31:0] ALUout;
output MW;
output BR;
output MR;
output RW;
output [31:0] BB;

wire [31:0] BB=busB;
wire MW=MemWr;
wire BR=Branch;
wire MR=MemtoReg;
wire RW=RegWr;

wire [31:0] imm32={ { 16{imm16[15]} }, imm16};
assign newPC={ { imm32[29:0]}, 2'b00}+PC;

reg [31:0] B;
always @(busB,imm32,ALUsrc) 
    begin
            if(ALUsrc)     B<=imm32;
            else B<=busB;
    end
    
wire [2:0] ALUctr;
Decoder dec(func,ALUOp,ALUctr,R_type);
ALU alu(busA,B,ALUctr,Zero,Overflow,ALUout);

reg [4:0] Rw;
always @(Rt,Rd,RegDst) 
    begin
            if(RegDst)     Rw<=Rd;
            else Rw<=Rt;
    end

endmodule

module ALU(A,B,ALUctr,Zero,Overflow,Result); //clock,
	parameter N=32;
	input [N-1:0] A,B;
	input [2:0] ALUctr;
	output [N-1:0] Result;
	output Zero, Overflow;

	wire [N-1:0] H,M,V,Add_Result;	
	wire over_flow, Add_Carry, Add_Sign, C, D, Less;
	
	wire SUBctr, OVctr, SIGctr;
	wire [1:0] OPctr;
	assign SUBctr=ALUctr[2];
	assign OVctr=!ALUctr[1] & ALUctr[0];
	assign SIGctr=ALUctr[0];
	assign OPctr[1]=ALUctr[2] & ALUctr[1];
	assign OPctr[0]=!ALUctr[2] & ALUctr[1] & !ALUctr[0];
	
	assign H = B ^ {N{SUBctr}};
	adderk adder(SUBctr, A, H, Add_Carry, Add_Result, Zero);
	assign over_flow = Add_Carry ^ Add_Result[N-1] ^ H[N-1] ^ A[N-1];
	assign Add_Sign=Add_Result[N-1];
	assign C=Add_Carry ^ SUBctr;
	assign D=over_flow ^ Add_Sign;
	mux2to1 mux2_1(C, D, SIGctr, Less);
	defparam mux2_1.k = 1;
	mux2to1 mux2_2(32'b0, 32'b1, Less, V);
	assign Overflow=over_flow & OVctr;
	assign M=A|B;
	mux3to1 mux3(Add_Result, M, V, OPctr, Result);
	
endmodule

module mux2to1 (V, W, Selm, F);
	parameter k = 32;
	input [k-1:0] V, W;
	input Selm;
	output [k-1:0] F;
	reg [k-1:0] F;
	always @(V or W or Selm)
	if (Selm == 0) F = V;
	else F = W;
endmodule

module mux3to1 (V, W, X, Selm, F);
	parameter k = 32;
	input [k-1:0] V, W, X;
	input [1:0] Selm;
	output [k-1:0] F;
	reg [k-1:0] F;
	always @(V or W or X or Selm)
	if (Selm == 2'b00) F = V;
	else if(Selm == 2'b01) F = W;
	else F=X;
endmodule

 // k-bit adder
module adderk (carryin, A, H, Add_Carry, Add_Result, Zero);
  parameter k = 32;
	input [k-1:0] A, H;
	input carryin;
	output [k-1:0] Add_Result;
	output Add_Carry, Zero;
	reg [k-1:0] Add_Result;
	reg Add_Carry, Add_Overflow, Add_Sign, Zero;
  
	always@(A or H or carryin)
	begin
		{Add_Carry, Add_Result} = A + H + carryin;
		if(Add_Result==0) Zero=1;
		else Zero=0;
	end
endmodule

module Decoder(func,ALUOp,ALUctr,R_type);
input [5:0] func;
input [2:0] ALUOp;
input R_type;
output reg [2:0] ALUctr;

wire [2:0]A;

assign A[0]=(!func[3]&!func[2]&!func[1]&!func[0])|(!func[2]&func[1]&!func[0]);
assign A[1]=func[3]&!func[2]&func[1];
assign A[2]=!func[2]&func[1];

always @(ALUOp,A,R_type)
	begin
		if(R_type)
			ALUctr<=A;
		else
			ALUctr<=ALUOp;
	end

endmodule
