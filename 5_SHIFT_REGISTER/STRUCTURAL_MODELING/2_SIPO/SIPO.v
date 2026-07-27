
`include "D_FF.v"

module sipo(parallel_out, serial_in, clk,reset);

    input serial_in, clk,reset;
    output wire [3:0] parallel_out;

    d_ff d0(parallel_out[3],serial_in,clk,reset);
    d_ff d1(parallel_out[2],parallel_out[3],clk,reset);
    d_ff d2(parallel_out[1],parallel_out[2],clk,reset);
    d_ff d3(parallel_out[0],parallel_out[1],clk,reset);

endmodule