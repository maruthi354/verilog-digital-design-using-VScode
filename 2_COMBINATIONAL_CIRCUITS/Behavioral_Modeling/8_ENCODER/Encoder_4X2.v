module Encoder_4X2(A1, A0, D3, D2, D1, D0);

    input D0, D1, D2, D3;
    output reg A0, A1;

    always @(*) begin
        if (D0)      {A1,A0} = 2'b00;
        else if (D1) {A1,A0} = 2'b01;
        else if (D2) {A1,A0} = 2'b10;
        else if (D3) {A1,A0} = 2'b11;
        else         {A1,A0} = 2'b00;
    end

endmodule