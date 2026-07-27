//4 Bit Register(Structural Modeling) using Behavioural Modelled Asynchronous D Flip Flop 

`include "D_FF.v"

module fourbit_reg(D,Q,clk,reset);

    input [3:0] Q;
    input clk,reset;
    output [3:0] D;

    D_FF ff0(D[0],Q[0],clk,reset);
    D_FF ff1(D[1],Q[1],clk,reset);
    D_FF ff2(D[2],Q[2],clk,reset);
    D_FF ff3(D[3],Q[3],clk,reset);

endmodule