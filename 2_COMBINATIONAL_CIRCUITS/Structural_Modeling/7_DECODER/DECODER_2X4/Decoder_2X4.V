module Decoder_2X4(I0, I1, I2, I3, A, B);

    input A, B;
    output I0, I1, I2, I3;

    wire A_n, B_n;

    not n1(A_n,A);
    not n1(B_n,B);

    and d1(I0, A_n, B_n);
    and d2(I1, A_n, B);
    and d3(I2, A  ,B_n);
    and d4(I3, A  , B);


endmodule