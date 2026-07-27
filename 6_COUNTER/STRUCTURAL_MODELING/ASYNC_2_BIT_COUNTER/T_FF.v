
module T_FF(Q,Q_bar,clk,areset);

    input  clk, areset;
    output reg Q;
    output Q_bar;

    assign Q_bar=~Q;

    always @(negedge clk or negedge areset) begin
        if(~areset)begin
            Q<=0;
        end
        else 
            Q<=~Q;

    end

endmodule