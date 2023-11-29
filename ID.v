module ID (
	input clk,rst,
	//from if
	input [31:0] Instruction,
	//from wb
	input [31:0] Result_WB,
	input WB_enable_rf,
	input [3:0] Dest_WB,
	//from hazard
	input hazard,
	//from status reg
	input [3:0] SR,

	input [31:0] PC_in,
	output [31:0] PC,
	output WB_enable,mem_read,mem_write,B,S_out,
	output [3:0] Execute_Command,
	output [31:0] Val_Rn, Value_Rm,
	output imm,
	output [11:0] Shift_operand,
	output [23:0] Signed_imm_24,
	output [3:0] Dest,
	// to hazard
	output [3:0] src1,src2,
	output Two_src,
	output [3:0] Op_code
);

wire [3:0] Cond=Instruction[31:28], read_reg1,read_reg2;
wire CondFlag;
wire S_in;
wire mux1_sl = (~CondFlag) | hazard;
wire WB_enable_c,mem_read_c,mem_write_c,B_c,S_out_c;
wire [3:0] Execute_Command_c;
wire [3:0] mux2_out;
wire [1:0] mode;


assign Cond = Instruction[31:28];
assign mode = Instruction[27:26];
assign imm = Instruction[25];
assign Op_code = Instruction[24:21];
assign S_in = Instruction [20];
assign read_reg1 = Instruction[19:16];
assign Dest = Instruction[15:12];
assign Shift_operand = Instruction[11:0];
assign read_reg2 = Instruction[3:0];
assign Signed_imm_24 = Instruction[23:0];
assign PC=PC_in;




assign Two_src = ~imm | mem_write;

register_file rf(read_reg1,mux2_out,Val_Rn,Value_Rm,Dest_WB,Result_WB,WB_enable_rf,clk);
ControlUnit cu(S_in, mode, Op_code, Execute_Command_c, mem_read_c, mem_write_c, WB_enable_c, B_c, S_out_c);
ConditionCheck cch(Cond, SR[2], SR[1] , SR[3], SR[0], CondFlag);

MUX #(9) mx1(mux1_sl,{WB_enable_c,mem_read_c,mem_write_c,Execute_Command_c,B_c,S_out_c},9'b0,{WB_enable_c,mem_read,mem_write,Execute_Command,B,S_out});
MUX #(4) mx2(mem_write, read_reg2, Dest, mux2_out);

endmodule

