
`include "T_FF.v"

module twobit_counter(Q,clk,reset);

    input clk,reset;
    output [1:0] Q;


    //LSB Counter
    T_FF t1(.Q(Q[0]),.Q_bar(),.T(1'b1),.reset(reset),.clk(clk));

    //MSB Counter
    T_FF t2(.Q(Q[1]),.Q_bar(),.T(Q[0]),.reset(reset),.clk(clk));


endmodule