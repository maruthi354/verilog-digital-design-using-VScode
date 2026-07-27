

module twobit_counter(Q,clk,reset);

    input clk,reset;
    output reg [1:0] Q;


    //LSB counter. Toggles on negedge of main clock
    always @(negedge clk or posedge reset ) begin
        if(reset)
            Q<=2'b00;
        else
            Q<=Q+1;
    end



endmodule