module register ( clk, rst, ld,r_in,r_out);
	parameter n = 32;
	input clk, rst, ld;
    	input [n-1:0] r_in;
   	 output reg [n-1:0] r_out;
	always@(posedge clk, negedge rst)begin
		if(~rst)
			r_out <= 0;
		else if(ld == 1'b1)
				r_out <= r_in;
	end
 endmodule
