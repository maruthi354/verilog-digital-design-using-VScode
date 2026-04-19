module Encoder_4X2(A1, A0, D3, D2, D1, D0);

    input D3, D2, D1, D0;
    output A1, A0;

    or E0(A1,D2,D3);
    or E1(A0,D3,D1);

endmodule