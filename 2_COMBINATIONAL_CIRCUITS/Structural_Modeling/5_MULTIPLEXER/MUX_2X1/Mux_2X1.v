module Mux_2X1(Y,I0,I1,S);

    input I0, I1, S;
    output Y;
    wire w0,w1,w2;

    not n(w0,S);

    and M0(w1,I0,w0);
    and M1(w2,I1,S);
    or Mu(Y,w1,w2);

endmodule