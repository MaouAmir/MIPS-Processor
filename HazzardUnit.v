module HazzardUnit(input [3:0] MEM_Dest, EXE_Dest, Src1, Src2, input MEM_WB_En, EXE_WB_En, Two_src, output hazzard); 
    always @(MEM_Dest, EXE_Dest, Rn, Rm, MEM_WB_En, EXE_WB_En, Two_src) begin 
        if ((src1 == EXE_Dest) && (EXE_WB_En)) hazzard = 1;
        else if ((src1 == MEM_Dest) && (MEM_WB_En)) hazzard = 1;
        else if ((src2 == EXE_Dest) && (EXE_WB_En) && (Two_src)) hazzard = 1;
        else if ((src2 == MEM_Dest) && (MEM_WB_En) && (Two_src)) hazzard = 1;
        else hazard = 0;
end 
endmodule