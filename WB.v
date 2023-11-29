module WB(
	input MEM_R_EN, 
	input Wb_en,
	input [3:0] Dest,
	input [31:0] ALU_result, MEM_Result,
	output [31:0] out,
	output [3:0] WB_Dest,
	output Wb_Wb_en
);
	MUX #(32) mx_wb (MEM_R_EN,ALU_result,MEM_Result,out);
	assign WB_Dest = Dest;
	assign Wb_Wb_en = Wb_en;
endmodule


