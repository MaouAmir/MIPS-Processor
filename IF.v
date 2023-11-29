module IF(
	input rst, clk, freeze, Branch_taken,
	input [31:0] BranchAddress,
	output [31:0] PC, Instruction
);
	wire [31:0] pcin, pcout;
	MUX #(32) m1(Branch_taken,PC,BranchAddress,pcin);
	PCReg p1(freeze,clk,rst,pcin,pcout);
	adder a1 (32'd4,pcout,PC);
	InsMEM i1(pcout,Instruction);
endmodule

//IF #(32) if;