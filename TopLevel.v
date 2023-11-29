module TopLevel(input rst,clk);
    wire   WB_enable_rf, hazard;
	wire [31:0] BranchAddress;
	wire [31:0] PC_IF, Instruction_IF, PC_IFReg,PC_IDReg, PC_ID,PC_EXE,Val_Rn, Value_Rm, Instruction_ID;
	wire [31:0] Result_WB;
	wire [3:0] Dest_WB ,SR;
	wire WB_enable,mem_read,mem_write,B,S_out,imm,Two_src;
	wire [3:0] Execute_Command,Dest,src1,src2;
	wire [11:0] Shift_operand;
	wire [23:0] Signed_imm_24;
	wire [3:0] op_code_in, op_code_out;

	wire [11:0] Shift_operand_idreg;
	wire [23:0] Signed_imm_24_idreg;
	wire [3:0] src1_idreg,src2_idreg,Dest_idreg;
	wire Two_src_idreg, imm_idreg,  WB_enable_idreg ,mem_read_idreg ,mem_write_idreg ,B_idreg ,S_idreg ;
	wire [3:0] op_code_idreg , Execute_Command_idreg;
	wire [31:0] Val_Rn_idreg, Val_Rm_idreg;

	IF if_inst(rst, clk, hazard, B_idreg, BranchAddress, PC_IF, Instruction_IF);
	IF_Reg ifreg(rst, clk, hazard, B_idreg, PC_IF, Instruction_IF, PC_IFReg, Instruction_ID);//require more work!
	ID id(clk, rst, Instruction_ID, Result_WB,WB_enable_rf,Dest_WB,hazard,SR,PC_IFReg,PC_ID,WB_enable,
        mem_read,mem_write,B,S_out,Execute_Command,Val_Rn, Value_Rm,imm,Shift_operand, Signed_imm_24,Dest, src1,src2,Two_src,op_code_in);	
    ID_Reg idreg(SR[2],B_idreg,clk, rst, PC_ID, Val_Rn, Value_Rm, op_code_in, Execute_Command, Two_src, imm , WB_enable , mem_read, mem_write, B, S_out, src1, src2, Dest, Signed_imm_24, Shift_operand, Shift_operand_idreg, Signed_imm_24_idreg, src1_idreg, src2_idreg, Dest_idreg, c_in,Two_src_idreg, imm_idreg,  WB_enable_idreg ,mem_read_idreg ,mem_write_idreg ,B_idreg ,S_idreg , op_code_idreg , Execute_Command_idreg, PC_IDReg, Val_Rn_idreg, Val_Rm_idreg);
    HazzardUnit haz(Dest_mem, Dest_exe, src1, src2, WB_en_mem, WB_en_exe, Two_src, hazard);
    EXE exe(mem_write_idreg,mem_read_idreg,imm_idreg,C_in,Execute_Command_idreg,Val_Rm_idreg,Val_Rn_idreg,Signed_imm_24_idreg,
		Shift_operand_idreg,PC_IDReg,N_out,Z_out,C_out,V_out,BranchAddress,ALU_result_exe);
	
	StatusReg sr(clk, rst, S_idreg,{V_out,C_out,Z_out,N_out},SR);
    // wb_en_exe, memrinexe,memwinexe
    EXE_Reg exereg(clk , rst , WB_en_exe , MEM_R_EN_exe , MEM_W_EN_exe, ALU_result_exe , Val_Rm_idreg, Dest_exe, WB_en_exereg, MEM_R_EN_exereg , MEM_W_EN_exereg, ALU_result_exereg , ST_val_exereg, Dest_exereg);
    MEM mem(clk,rst, WB_en_exereg , MEM_R_EN_exereg , MEM_W_EN_exereg , ALU_result_exereg , ST_val_exereg, Dest_exereg, WB_en_mem , MEM_R_EN_mem , ALU_result_mem , MEM_Result_mem, Dest_mem);
    MEM_Reg memreg(clk,rst, WB_en_mem , MEM_R_EN_mem , ALU_result_mem , MEM_Result_mem ,  Dest_mem, WB_en_memreg , MEM_R_EN_memreg , ALU_result_memreg , MEM_Result_memreg , Dest_memreg);
    WB writeback(MEM_R_EN_memreg, WB_en_memreg, Dest_memreg, ALU_result_memreg, MEM_Result_memreg, Result_WB, Dest_WB, WB_enable_rf);
endmodule