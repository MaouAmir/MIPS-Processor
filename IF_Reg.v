module IF_Reg(
	input rst, clk, freeze,flush,
	input [31:0] PC_in, Instruction_in,
	output [31:0] PC, Instruction
);
registerf instr(flush,clk, rst,~freeze,Instruction_in, Instruction);
registerf regif(flush,clk, rst, ~freeze,PC_in, PC);
endmodule

