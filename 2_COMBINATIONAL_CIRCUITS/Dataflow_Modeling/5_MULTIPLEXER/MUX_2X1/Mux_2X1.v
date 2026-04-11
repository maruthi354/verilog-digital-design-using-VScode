module Mux_2X1(Y, I0, I1, S);

    input I0, I1, S;
    output Y;

    assign Y = (I0 & ~S) | (I1 & S);

endmodule