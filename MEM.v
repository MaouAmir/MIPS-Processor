module MEM(

	input clk,rst ,wb_in , MEM_R_EN , MEM_W_EN , 
	input [31:0] alu_res , Value_Rm,
	input [3:0] Dest
	output wb_in_out , MEM_R_EN_out , 
	input [31:0] alu_res_out , mem_res,
	input [3:0] Dest_out
);
	assign Dest_out = Dest;
	assign alu_res_out = alu_res;
	assign MEM_R_EN_out = MEM_R_EN;
	assign wb_in_out = wb_in;
	reg [31:0] memory [0:63];

	assign mem_res=MEM_R_EN? R[((alu_res) -1024)>>2]:0;
	
	//write 
	integer i;
	always@ (posedge clk)begin 
    	if(rst)
			for(i=0; i<64; i=i+1)
				memory [i] = 32'b0;
    	if(MEM_W_EN)begin 
            	memory[((alu_res) -1024)>>2]<=Value_Rm;
    	end
	end

endmodule


