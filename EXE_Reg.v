module EXE_Reg(
	input clk,rst , WB_en_in , MEM_R_EN_in , MEM_W_EN_in,
	input [31:0] ALU_result_in , ST_val_in, 
	input [3:0] Dest_in,
	output WB_en_out,  MEM_R_EN_out , MEM_W_EN_out,
	output [31:0] ALU_result_out , ST_val_out, 
	output [3:0] Dest_out
);
	register ALU_result_exe(clk, rst, 1'b1, ALU_result_in,ALU_result_out);
	register ST_val_exe(clk, rst, 1'b1, ST_val_in,ST_val_out);
	register #(4) dest_exe(clk, rst, 1'b1, Dest_in,Dest_out);
	register #(3) onebits_exe (clk, rst, 1'b1,  {WB_en_in , MEM_R_EN_in , MEM_W_EN_in},{WB_en_out,  MEM_R_EN_out , MEM_W_EN_out});
endmodule


