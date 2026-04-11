module Mux_4X1(Y,I0,I1,I2,I3,S0,S1);

    input I0,I1,I2,I3,S0,S1;
    output Y;

    assign Y= (I0 & ~S1 & ~S0) | (I1 & ~S1 & S0) | (I2 & S1 & ~S0) | (I3 & S1 & S0);

endmodule