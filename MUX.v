module MUX(sw, input0, input1, out);
    parameter n;
    input sw;
    input [n-1:0] input0, input1;
    output [n-1:0] out;
    assign out = (~sw)? input0:input1;

endmodule  

// MUX #(32) m1(1,2,s,o)
