

module twobit_counter(Q,clk,reset);

    input clk,reset;
    output reg [1:0] Q;


    //LSB counter. Toggles on negedge of main clock
    always @(negedge clk or posedge reset ) begin
        if(reset)
            Q[0]<=1'b0;
        else
            Q[0]<=~Q[0];
    end

    //MSB counter. Toggles on negedge of Q[0]
    always @(negedge Q[0]  ) begin
        if(reset)
            Q[1]<=1'b0;
        else
        Q[1]<=~Q[1];
    end


endmodule