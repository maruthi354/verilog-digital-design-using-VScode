module Decoder_2X4(I,A,B);

    input A, B;
    output [0:3] I;

    assign I[0] = (~A) & (~B);
    assign I[1] = (~A) & B;
    assign I[2] = A & (~B);
    assign I[3] = A & B;


endmodule