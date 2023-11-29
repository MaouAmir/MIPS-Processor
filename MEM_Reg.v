module MEM_Reg(
	input clk,rst
	input WB_en_in , MEM_R_EN_in ,
	input [31:0] ALU_result_in , MEM_Result_in , 
	input [3:0] Dest_in,
	output WB_en_out , MEM_R_EN_out ,
	output [31:0] ALU_result_out , MEM_Result_out , 
	output [3:0] Dest_out
);
	register ALU_result_mem(clk, rst, 1'b1, ALU_result_in,ALU_result_out);
	register MEM_Result_mem(clk, rst, 1'b1, MEM_Result_in,MEM_Result_out);
	register #(4) dest_exe(clk, rst, 1'b1, Dest_in,Dest_out);
	register #(2) onebits_exe (clk, rst, 1'b1,  {WB_en_in , MEM_R_EN_in },{WB_en_out,  MEM_R_EN_out }); 
endmodule


