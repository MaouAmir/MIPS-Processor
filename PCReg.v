module PCReg (
    input freeze,clk,rst,
    input [31:0] in,
    output [31:0] out
);
    register #(32) pcreg (clk, rst, ~freeze,in, out);
endmodule