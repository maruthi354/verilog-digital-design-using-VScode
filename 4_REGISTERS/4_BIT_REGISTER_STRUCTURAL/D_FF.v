//Behaviour modelling of D Flip Flop 

module D_FF(D,Q,clk,reset);

    input Q,clk,reset;
    output reg D;

    always @(posedge clk or posedge reset) begin
        if(reset)
            D<=1'b0;
        else
            D<=Q;
    end

endmodule