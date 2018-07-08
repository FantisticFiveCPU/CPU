`timescale 1ns / 1ps

module Id_Ex(
input clk,
input wire [31:0] PC,
input wire [4:0] Rt,Rd,
input wire [15:0] imm16,
input wire [31:0] busA,busB,

input wire ExtOp,
input wire ALUSrc,
input wire [2:0] ALUop,
input wire RegDst,
input wire R_type,
input wire MemWr,
input wire Branch,
input wire MemtoReg,
input wire RegWr,

output reg [31:0] PC_out,
output reg [4:0] Rt_out,Rd_out,
output reg [15:0] imm16_out,
output reg [31:0] busA_out,busB_out,

output reg ExtOp_out,
output reg ALUSrc_out,
output reg [2:0] ALUop_out,
output reg RegDst_out,
output reg R_type_out,
output reg MemWr_out,
output reg Branch_out,
output reg MemtoReg_out,
output reg RegWr_out
    );

    always @(negedge clk) begin
        PC_out=PC;
        Rt_out=Rt;
        Rd_out=Rd;
        imm16_out=imm16;
        busA_out=busA;
        busB_out=busB;
        ExtOp_out=ExtOp;
        ALUSrc_out=ALUSrc;
        ALUop_out=ALUop;
        RegDst_out=RegDst;
        R_type_out=R_type;
        MemWr_out=MemWr;
        Branch_out=Branch;
        MemtoReg_out=MemtoReg;
        RegWr_out=RegWr;
    end
endmodule
