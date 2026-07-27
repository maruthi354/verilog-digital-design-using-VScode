
`include "D_FF.v"

module piso(serial_out,parallel_in,clk,load,reset);

    input clk,load,reset;
    input [3:0] parallel_in;
    output serial_out;

    wire w1,w2,w3;
    wire d0,d1,d2,d3;

    assign d0=load?parallel_in[3]:1'b0;
    assign d1=load?parallel_in[2]:w1;
    assign d2=load?parallel_in[1]:w2;
    assign d3=load?parallel_in[0]:w3;

    d_ff x0(w1,d0,clk,reset);
    d_ff x1(w2,d1,clk,reset);
    d_ff x2(w3,d2,clk,reset);
    d_ff x3(serial_out,d3,clk,reset);

endmodule