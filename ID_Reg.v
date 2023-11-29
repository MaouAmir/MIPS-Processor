module ID_Reg (
	input c_in,flush,clk,rst,  
	input [31:0] PC_in,
	input [31:0] Val_Rn_in, Val_Rm_in,
	input [3:0] op_code_in, Execute_Command_in,
	input Two_src_in, imm_in , WB_enable_in ,mem_read_in,mem_write_in,B_in,S_in,
	input [3:0] src1_in,src2_in,Dest_in,
	input [23:0] Signed_imm_24_in,
	input [11:0] Shift_operand_in,
	output [11:0] Shift_operand_out,
	output [23:0] Signed_imm_24_out,
	output [3:0] src1_out,src2_out,Dest_out,
	output c_in_out, Two_src_out, imm_out,  WB_enable_out ,mem_read_out ,mem_write_out ,B_out ,S_out ,
	output [3:0] op_code_out , Execute_Command_out,
	output [31:0] PC,
	output [31:0] Val_Rn_out, Val_Rm_out
);
registerf pc_id(flush,clk, rst, 1'b1, PC_in,PC);
registerf Val_Rn_id(flush,clk, rst, 1'b1, Val_Rn_in,Val_Rn_out);
registerf Val_Rm_id(flush,clk, rst, 1'b1, Val_Rm_in,Val_Rm_out);
registerf #(4) opcode_id(flush,clk, rst, 1'b1, op_code_in,op_code_out);
registerf #(4) Execute_Command_id(flush,clk, rst, 1'b1, Execute_Command_in,Execute_Command_out);
registerf #(8) onebits(flush,clk, rst, 1'b1 , {c_in,Two_src_in, imm_in , WB_enable_in ,mem_read_in,mem_write_in,B_in,S_in},{c_in_out,Two_src_out, imm_out,  WB_enable_out ,mem_read_out ,mem_write_out ,B_out ,S_out});
registerf #(4) src1_id(flush,clk, rst, 1'b1, src1_in,src1_out);
registerf #(4) src2_id(flush,clk, rst, 1'b1, src2_in,src2_out);
registerf #(4) Dest_id(flush,clk, rst, 1'b1, Dest_in,Dest_out);
registerf #(24) Signed_imm_24_id(flush,clk, rst, 1'b1, Signed_imm_24_in,Signed_imm_24_out);
registerf #(12) Shift_operand_id(flush,clk, rst, 1'b1, Shift_operand_in,Shift_operand_out);

endmodule

