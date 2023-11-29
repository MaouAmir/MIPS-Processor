module StatusReg(clk, rst, ld,r_in,r_out);

  input clk, rst, ld;
  input [3:0] r_in;
  output reg [3:0] r_out;
  always@(negedge clk, negedge rst)begin
    if(~rst)
r_out <= 0;
    else if(ld == 1'b1)
r_out <= r_in;
    end

 endmodule