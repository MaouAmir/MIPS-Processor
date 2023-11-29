`timescale 1ns/1ns
module ID_TB();
    	reg  clk=0,rst=0, WB_enable_rf=0, hazard=0;
	reg [31:0] BranchAddress=0;
	wire [31:0] PC_IF, Instruction_IF, PC_IFReg,PC_IDReg, PC_ID,PC_EXE,Val_Rn, Value_Rm, Instruction_ID;
	reg [31:0] Result_WB=0;
	reg [3:0] Dest_WB = 0,SR=0;
	wire WB_enable,mem_read,mem_write,B,S_out,imm,Two_src;
	wire [3:0] Execute_Command,Dest,src1,src2;
	wire [11:0] Shift_operand;
	wire [23:0] Signed_imm_24;

	always #13 clk=~clk;
	IF if_inst(rst, clk, 1'b0, 1'b0, BranchAddress, PC_IF, Instruction_IF);
	IF_Reg ifreg(rst, clk, 1'b0, 1'b0, PC_IF, Instruction_IF, PC_IFReg, Instruction_ID);//require more work!
	ID id(clk, rst, Instruction_ID, Result_WB,WB_enable_rf,Dest_WB,hazard,SR,PC_IFReg,PC_ID,WB_enable,
        mem_read,mem_write,B,S_out,Execute_Command,Val_Rn, Value_Rm,imm,Shift_operand, Signed_imm_24,Dest, src1,src2,Two_src);

	initial begin
      #30 rst=1;
      #30 rst=0;
      #2000
      $stop;
    end

endmodule
