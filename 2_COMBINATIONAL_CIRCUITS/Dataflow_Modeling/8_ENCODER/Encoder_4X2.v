module Encoder_4X2(A1, A0, D3, D2, D1, D0);

    input D0, D1, D2, D3;
    output A0, A1;

    assign A1 = D3 | D2;
    assign A0 = D3 | D1;

endmodule