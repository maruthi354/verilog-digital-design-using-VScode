
module Encoder_8X3( A2, A1, A0, I);

    input [7:0] I;
    output A2, A1, A0;

    or E0(A2,I[4],I[5],I[6],I[7]);
    or E1(A1,I[2],I[3],I[6],I[7]);
    or E2(A0,I[1],I[3],I[5],I[7]);

endmodule