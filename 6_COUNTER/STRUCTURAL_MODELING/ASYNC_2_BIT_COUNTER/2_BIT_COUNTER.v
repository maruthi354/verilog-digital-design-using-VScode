

`include "T_FF.v"

module twobit_counter(Q,clk,areset);

    input clk,areset;
    output [1:0] Q;


    //LSB counter. Toggles on negedge of main clock
    T_FF t1(.Q(Q[0]),.Q_bar(),.clk(clk),.areset(areset));

    //MSB counter. Toggles on negedge of Q[0]
    T_FF t2(.Q(Q[1]),.Q_bar(),.clk(Q[0]),.areset(areset));

endmodule