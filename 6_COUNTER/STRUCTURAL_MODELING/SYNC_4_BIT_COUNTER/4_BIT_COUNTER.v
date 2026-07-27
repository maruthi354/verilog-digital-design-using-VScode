
`include "T_FF.v"

module four_bit_counter(Q,clk,reset);

    input clk,reset;
    output [3:0] Q;

    wire w1, w2;

    and a2(w1,Q[0],Q[1]);
    and a3(w2,Q[0],Q[1],Q[2]);

    t_ff t1(Q[0],1'b1,clk,reset);
    t_ff t2(Q[1],Q[0],clk,reset);
    t_ff t3(Q[2],w1,clk,reset);
    t_ff t4(Q[3],w2,clk,reset);


endmodule