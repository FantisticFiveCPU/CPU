`timescale 1ns / 1ps

module Test(
input clk,
input wire [31:0] instru,
input wire [4:0] Rw,
input wire [31:0] Di,
input WE,
input reset,
input [31:0] PC,

output [31:0] PC_emout,
output Zero_emout,
output Overflow_emout,
output [31:0] ALUout_emout,
output [4:0] Rw_emout,
output MemWr_emout,
output Branch_emout,
output MemtoReg_emout,
output RegWr_emout,
output [31:0] busB_emout
    );
 
    wire [31:0] busA_rfout;
    wire [31:0] busB_rfout;
    wire [15:0] imm16_rfout;
    wire [4:0] Rt_rfout;
    wire [4:0] Rd_rfout;

    wire [5:0] func_mcout;
    wire ExtOp_mcout;
    wire ALUSrc_mcout;
    wire [2:0] ALUOp_mcout;
    wire R_type_mcout;
    wire RegDst_mcout;
    wire MemWr_mcout;
    wire Branch_mcout;
    wire MemtoReg_mcout;
    wire RegWr_mcout;
       
    wire [31:0] PC_ieout;
    wire [4:0] Rt_ieout,Rd_ieout;
    wire [15:0] imm16_ieout;
    wire [31:0] busA_ieout,busB_ieout;   
    wire ExtOp_ieout;
    wire ALUSrc_ieout;
    wire [2:0] ALUOp_ieout;
    wire RegDst_ieout;
    wire R_type_ieout;
    wire MemWr_ieout;
    wire Branch_ieout;
    wire MemtoReg_ieout;
    wire RegWr_ieout;
    wire [5:0] func_ieout;
    
    wire [4:0] Rw_euout;
    wire [31:0] PC_euout;
    wire Zero_euout;
    wire Overflow_euout;
    wire [31:0] ALUout_euout;
    wire MemWr_euout;
    wire Branch_euout;
    wire MemtoReg_euout;
    wire RegWr_euout;
    wire [31:0] busB_euout;


    RFile RF(clk,instru,Rw,Di,WE,reset,Rt_rfout,Rd_rfout,imm16_rfout,busA_rfout,busB_rfout);

    MainControl MC(instru,ExtOp_mcout,ALUSrc_mcout,ALUOp_mcout,RegDst_mcout,
    R_type_mcout,MemWr_mcout,Branch_mcout,MemtoReg_mcout,RegWr_mcout,func_mcout);

    Id_Ex IE(clk,PC,Rt_rfout,Rd_rfout,imm16_rfout,busA_rfout,busB_rfout,
    ExtOp_mcout,ALUSrc_mcout,ALUOp_mcout,RegDst_mcout,R_type_mcout,
    MemWr_mcout,Branch_mcout,MemtoReg_mcout,RegWr_mcout,func_mcout,
    PC_ieout,Rt_ieout,Rd_ieout,imm16_ieout,busA_ieout,busB_ieout,ExtOp_ieout,
    ALUSrc_ieout,ALUOp_ieout,RegDst_ieout,R_type_ieout,MemWr_ieout,
    Branch_ieout,MemtoReg_ieout,RegWr_ieout,func_ieout);
    
    ExecUnit EU(PC,busA_ieout,busB_ieout,imm16_ieout,func_ieout,ExtOp_ieout,
    ALUSrc_ieout,ALUOp_ieout,R_type_ieout,Rt_ieout,Rd_ieout,RegDst_ieout,
    MemWr_ieout,Branch_ieout,MemtoReg_ieout,RegWr_ieout,Rw_euout,PC_euout,
    Zero_euout,Overflow_euout,ALUout_euout,MemWr_euout,Branch_euout,
    MemtoReg_euout,RegWr_euout,busB_euout);
    
    Ex_Mem EM(clk,PC_euout,Zero_euout,Overflow_euout,ALUout_euout,Rw_euout,
        MemWr_euout,Branch_euout,MemtoReg_euout,RegWr_euout,busB_euout,
        PC_emout,Zero_emout,Overflow_emout,ALUout_emout,Rw_emout,
        MemWr_emout,Branch_emout,MemtoReg_emout,RegWr_emout,busB_emout);
endmodule
