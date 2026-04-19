`include "Decoder_2X4.v"

module Decoder_3X8(I, A, B, C);

    input A, B, C;
    output [0:7] I;
    wire C_n;

    not n(C_n,C);

    Decoder_2X4 D1(I[0:3],A,B,C);
    Decoder_2X4 D2(I[4:7],A,B,C_n);

endmodule