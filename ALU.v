module ALU (input [3:0] ALU_cmd,input [31:0] Val1,Val2,input C_in, output reg [31:0] ALU_out, output reg N_out, output reg Z_out, output reg C_out, output reg V_out);

parameter [3:0] MOV=4'b0001,MVN=4'b1001,ADD=4'b0010,ADC=4'b0011,SUB=4'b0100,AND=4'b0110,SBC=4'b0101,
                ORR=4'b0111,EOR=4'b1000,CMP=4'b0100,TST=4'b0110,LDR=4'b0010,STR=4'b0010;

always @(ALU_cmd,Val1,Val2) begin
    case (ALU_cmd)
    MOV:  ALU_out = Val2;
    MVN:  ALU_out = ~Val2;
    ADD:  ALU_out = Val1+Val2;
    ADC:  {C_out, ALU_out} = Val1+Val2+C_in;
    SUB:  ALU_out = Val1-Val2;
    SBC:  {C_out, ALU_out} = Val1-Val2-(!C_in);
    AND:  ALU_out = Val1&Val2;
    ORR:  ALU_out = Val1|Val2;
    EOR:  ALU_out = Val1^Val2;
    CMP:  ALU_out = Val1-Val2;
    TST:  ALU_out = Val1&Val2;
    LDR:  ALU_out = Val1+Val2;
    STR:  ALU_out = Val1+Val2;
        default: begin ALU_out=32'b0; C_out=1'b0; end
    endcase

assign V_out = ALU_out[31]^C_out;
assign N_out = ALU_out[31];

if (ALU_out == 32'b0 & C_out == 0)
    assign Z_out = 1;
else
    assign Z_out =0;
    
end
endmodule