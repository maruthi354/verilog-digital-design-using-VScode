

`include "d_ff.v"

module johnson_counter(Q,clk,reset);

    input clk,reset;
    output Q;

    wire A,B,C,D;

    d_ff d0(.q(A),.q_bar(),.d(D),.clk(clk),.reset(reset));
    d_ff d1(.q(B),.q_bar(),.d(A),.clk(clk),.reset(reset));
    d_ff d2(.q(C),.q_bar(),.d(B),.clk(clk),.reset(reset));
    d_ff d3(.q(Q),.q_bar(D),.d(C),.clk(clk),.reset(reset));

endmodule