module register_file(read_reg1,read_reg2,read_data1,read_data2,write_reg,write_data,regwrite,clk);

input [3:0] read_reg1,read_reg2,write_reg;
input [31:0]write_data;
input regwrite,clk;
output [31:0]read_data1,read_data2;

reg [15:0]R[31:0];
//read
assign read_data1=R[read_reg1];
assign read_data2=R[read_reg2];
//write 

always@ (negedge clk)begin 
    R[0]<=32'b0;
    if(regwrite)begin 
        if(write_reg!= 4'b0)
            R[write_reg]<=write_data;
    end
end

endmodule

