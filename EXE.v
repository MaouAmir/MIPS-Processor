module EXE(input mem_write, mem_read,I,C_in,
	   input [3:0] ALU_cmd,
	   input signed [31:0] Val_RM,
	   input [31:0] Val1,
	   input [23:0] signed_imm_24,
	   input [11:0] shift_operand,
	   input [31:0] PC,
           output N_out,Z_out,C_out,V_out,
	   output [31:0] Branch_address,
	   output [31:0] ALU_out
);

wire rw_en;
wire [31:0] Val2;
wire [11:0] imm;

assign rw_en = mem_write | mem_read;
assign imm = signed_imm_24[23:12];

Val2_Generate v2g(rw_en,I,Val_RM,imm,shift_operand,Val2);
ALU alu(ALU_cmd,Val1,Val2,C_in,ALU_out,N_out,Z_out,C_out,V_out);
adder #(32) add(PC,{signed_imm_24[23], signed_imm_24[23],
                    signed_imm_24[23], signed_imm_24[23],
                    signed_imm_24[23], signed_imm_24[23],
                    signed_imm_24, 2'b00},Branch_address);

endmodule