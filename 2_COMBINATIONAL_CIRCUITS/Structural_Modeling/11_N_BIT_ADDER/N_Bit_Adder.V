// N_BIT_BINARY_ADDER, WHERE N IS A PARAMETER BY STRUCTURAL MODELING
//"Structural modeling using a generate block to instantiate N Full Adder modules, forming a ripple carry adder."
`include "Full_Adder.v"

module N_Bit_Adder(SUM, C_OUT, A, B, C_IN);

    parameter N = 4;
    input [N-1:0] A, B;
    input C_IN;

    output [N-1:0] SUM;
    output C_OUT;

    wire [N:0] C;
    
    genvar i;

    assign C[0]=C_IN;

    generate
        for(i = 0 ; i < N;i=i+1) begin:FA_Chain
            Full_Adder FA(SUM[i],C[i+1],A[i],B[i],C[i]);
        end 
    endgenerate

    assign C_OUT = C[N];

endmodule