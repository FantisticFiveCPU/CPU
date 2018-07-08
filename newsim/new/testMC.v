`timescale 1ns / 1ps

module testMC;
reg [31:0] instru;
wire ExtOp;
wire ALUSrc;
wire [2:0] ALUop;
wire RegDst;
wire R_type;
wire MemWr;
wire Branch;
wire MemtoReg;
wire RegWr;
wire [5:0] func;

MainControl MC(
.instru(instru),
.ExtOp(ExtOp),
.ALUSrc(ALUSrc),
.ALUop(ALUop),
.RegDst(RegDst),
.R_type(R_type),
.MemWr(MemWr),
.Branch(Branch),
.MemtoReg(MemtoReg),
.RegWr(RegWr),
.func(func)
);

initial begin
#0
instru={6'b000000,5'b00001,5'b00010,5'b00011,5'b00000,6'b100000};
#5
instru={6'b001101,5'b00001,5'b00010,5'b00011,5'b00000,6'b101011};
#5
instru={6'b001001,5'b00001,5'b00010,5'b00011,5'b00000,6'b101011};
#5
instru={6'b100011,5'b00001,5'b00010,5'b00011,5'b00000,6'b101011};
#5
instru={6'b101011,5'b00001,5'b00010,5'b00011,5'b00000,6'b101011};
#5
instru={6'b000100,5'b00001,5'b00010,5'b00011,5'b00000,6'b101011};
#5
instru={6'b000010,5'b00001,5'b00010,5'b00011,5'b00000,6'b101011};
end

endmodule
