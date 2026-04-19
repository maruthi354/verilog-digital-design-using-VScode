module Decoder_3X8(I, A, B, C);

    input A, B, C;
    output [0:7] I;

    assign I[0] = ~A & ~B & ~C;
    assign I[1] = ~A & ~B &  C;
    assign I[2] = ~A &  B & ~C;
    assign I[3] = ~A &  B &  C;
    assign I[4] =  A & ~B & ~C;
    assign I[5] =  A & ~B &  C;
    assign I[6] =  A &  B & ~C;
    assign I[7] =  A &  B &  C;

endmodule