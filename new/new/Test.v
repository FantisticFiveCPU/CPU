`timescale 1ns / 1ps

module Test(
input clk,
input wire [31:0] instru,
input wire [4:0] Rw_in,
input wire [31:0] Di,
input WE,
input reset,
input [31:0] PC,

output [4:0] Rw_out,
output [31:0] newPC,
output Zero,
output Overflow,
output [31:0] ALUout,
output MW,
output BR,
output MR,
output RW,
output [31:0] BB
    );
 
    wire [31:0] busA;
    wire [31:0] busB;
    wire [15:0] imm16;
    wire [5:0] func;
    wire ExtOp;
    wire ALUsrc;
    wire [2:0] ALUOp;
    wire R_type;
    wire [4:0] Rt;
    wire [4:0] Rd;
    wire RegDst;
    wire MemWr;
    wire Branch;
    wire MemtoReg;
    wire RegWr;
    wire ALUSrc;
    wire [2:0] ALUop;
       
    wire [31:0] PC_out;
    wire [4:0] Rt_out,Rd_out;
    wire [15:0] imm16_out;
    wire [31:0] busA_out,busB_out;   
    wire ExtOp_out;
    wire ALUSrc_out;
    wire [2:0] ALUop_out;
    wire RegDst_out;
    wire R_type_out;
    wire MemWr_out;
    wire Branch_out;
    wire MemtoReg_out;
    wire RegWr_out;

    RFile rfile(clk,instru,Rw_in,Di,WE,reset,Rt,Rd,imm16,busA,busB);

    MainControl Mac(instru,ExtOp,ALUSrc,ALUop,RegDst,R_type,MemWr,Branch,MemtoReg,RegWr,func);

    Id_Ex IE(clk,PC,Rt,Rd,imm16,busA,busB,ExtOp,ALUSrc,ALUop,
    RegDst,R_type,MemWr,Branch,MemtoReg,RegWr,
    PC_out,Rt_out,Rd_out,imm16_out,busA_out,busB_out,ExtOp_out,
    ALUSrc_out,ALUop_out,RegDst_out,R_type_out,MemWr_out,Branch_out,
    MemtoReg_out,RegWr_out);
    
    ExecUnit EU(PC,busA,busB,imm16,func,ExtOp,ALUsrc,ALUOp,R_type,newPC,Zero,Overflow,
    ALUout,Rt,Rd,Rw_out,RegDst,MemWr,Branch,MemtoReg,RegWr,MW,BR,MR,RW,BB);
endmodule
