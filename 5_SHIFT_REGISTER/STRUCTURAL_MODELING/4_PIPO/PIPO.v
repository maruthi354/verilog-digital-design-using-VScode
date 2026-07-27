
`include "D_FF.v"

module pipo(parallel_out,parallel_in,clk,reset);

    input [3:0] parallel_in;
    input clk,reset;
    output [3:0] parallel_out;

    d_ff d0(parallel_out[3],parallel_in[3],clk,reset);
    d_ff d1(parallel_out[2],parallel_in[2],clk,reset);
    d_ff d2(parallel_out[1],parallel_in[1],clk,reset);
    d_ff d3(parallel_out[0],parallel_in[0],clk,reset);

endmodule