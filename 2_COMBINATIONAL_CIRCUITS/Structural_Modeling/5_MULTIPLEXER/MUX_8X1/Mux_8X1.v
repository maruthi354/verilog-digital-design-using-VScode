//Designing Structural modeled 8X1 Multiplexer using 2 Structural modeled 4X1 Multiplexer and 1 2X1 Multiplexer

`include "Mux_4X1.v"
`include "Mux_2X1.v"

module Mux_8X1(Y, I, S);

    input [0:7] I;
    input [2:0] S;
    output Y;

    wire M0, M1;

    Mux_4X1 Mux0(M0,I[0],I[1],I[2],I[3],S[1],S[0]);
    Mux_4X1 Mux1(M1,I[4],I[5],I[6],I[7],S[1],S[0]);
    Mux_2X1 Mux2(Y,M0,M1,S[2]);

endmodule