module Mux_4X1(Y, I0, I1, I2, I3, S0, S1);

    input I0, I1, I2, I3, S0, S1;
    output Y;

    wire S0_n, S1_n;
    wire w0, w1, w2, w3;

    not n(S0_n,S0); 
    not n1(S1_n,S1); 

    and m0(w0,I0,S1_n,S0_n);
    and m1(w1,I1,S1_n,S0);
    and m2(w2,I2,S1,S0_n);
    and m3(w3,I3,S1,S0);

    or mux(Y,w0,w1,w2,w3);

endmodule