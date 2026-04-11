module Mux_2X1(Y, I0, I1, S);

    input I0, I1, S;
    output reg Y;

    always @(*) begin
        Y<=S?I1:I0;
    end

endmodule