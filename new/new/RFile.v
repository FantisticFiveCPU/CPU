`timescale 1ns / 1ps

module RFile(
    input clk,
    input wire [31:0] instru,
    input wire [4:0] Rw,
    input wire [31:0] Di,
    input WE,
    
    input reset,

    output wire [4:0] Rt,Rd,
    output wire [15:0] imm16,
    output wire [31:0] busA,busB
    );
    wire [4:0] Rs;
    wire [4:0] Ra;
    wire [4:0] Rb;
    reg [31:0] mem3232 [31:0];

    integer i;

    initial begin
        for(i=0;i<32;i=i+1)
            mem3232[i]<=i;
        end

    always @(reset) begin
        if(reset) begin
            for(i=0;i<32;i=i+1)
                    mem3232[i]<=0;
            end
        end

    assign Ra=instru[25:21];
    assign Rb=instru[20:16];
    
    assign Rs=instru[25:21];
    assign Rt=instru[20:16];
    assign Rd=instru[15:11];
    assign imm16=instru[15:0];
    assign busA=mem3232[Ra];
    assign busB=mem3232[Rb];
    
    
    always @(negedge clk) begin
        if(WE)
            mem3232[Rw]<=Di;
//        else mem3232[Rw]<=mem3232[Rw];
    end
endmodule

module MainControl(
    input wire [31:0] instru,
    output wire ExtOp,
    output wire ALUSrc,
    output wire [2:0] ALUop,
    output wire RegDst,
    output wire R_type,
    output wire MemWr,
    output wire Branch,
    output wire MemtoReg,
    output wire RegWr,
    output wire [5:0] func
);
    wire [5:0] op=instru[31:26];  //,func
    
    assign func=instru[5:0];
    assign Branch=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];
    assign RegDst=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];//
    assign ALUSrc=(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])
            |(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])
            |(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])
            |(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0]);
    assign MemtoReg=op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];
    assign RegWr=(!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])
            |(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])
            |(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])
            |(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);//
    assign MemWr=op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0];
    assign ExtOp=(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])
            |(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])
            |(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0]);
    assign R_type=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];//
    assign ALUop[0]=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];//
    assign ALUop[1]=!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0];
    assign ALUop[2]=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];
endmodule

/*
assign Rs=instru[25:21];
assign Rt=instru[20:16];
assign Rd=instru[15:11];
assign imm16=instru[15:0];
assign Target=instru[25:0];


module Decoder(
	input [5:0]op,
	input [5:0]func,
	output Branch,
	output Jump,
	output RegDst,
	output ALUSrc,
	output reg[2:0]ALUctr,
	output MemtoReg,
	output RegWr,
	output MemWr,
	output ExtOp
	);
	wire [2:0]ALUop;
	wire R_type;
	wire [3:0]A;
	
	assign Branch=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];
	assign Jump=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&!op[0];
	assign RegDst=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];
	assign ALUSrc=(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])
				|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])
				|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])
				|(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0]);
	assign MemtoReg=op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];
	assign RegWr=(!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])
				|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])
				|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])
				|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
	assign MemWr=op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0];
	assign ExtOp=(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])
				|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])
				|(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0]);
	assign R_type=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];
	assign ALUop[0]=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];
	assign ALUop[1]=!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0];
	assign ALUop[2]=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];
	assign A[0]=(!func[3]&!func[2]&!func[1]&!func[0])|(!func[2]&func[1]&!func[0]);
	assign A[1]=func[3]&!func[2]&func[1];
	assign A[2]=!func[2]&func[1];
	
	
	always @(ALUop,A,R_type)
	begin
		if(R_type)
			ALUctr<=A;
		else
			ALUctr<=ALUop;
	end
	
endmodule
*/
