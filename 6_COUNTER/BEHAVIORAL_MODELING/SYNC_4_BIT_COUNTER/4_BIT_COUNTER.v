

module four_bit_counter(Q,clk,reset);

    input clk,reset;
    output reg [3:0] Q;

    always @(posedge clk or posedge reset) begin
        if(reset)
            Q<=4'b0000;
        else
            Q<=Q+1'b1;
    end

endmodule