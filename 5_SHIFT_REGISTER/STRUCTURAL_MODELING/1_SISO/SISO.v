

`include "D_FF.v"

module siso(Serial_out, Serial_in, clk,reset);

    input Serial_in,clk,reset;
    output Serial_out;

    wire w1,w2,w3;

    d_ff d0(w1,Serial_in,clk,reset);
    d_ff d1(w2,w1,clk,reset);
    d_ff d2(w3,w2,clk,reset);
    d_ff d3(Serial_out,w3,clk,reset);
    
    
endmodule