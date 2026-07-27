
module T_FF(Q,Q_bar,T,clk,reset);

    input T, clk, reset;
    output reg Q;
    output Q_bar;

    assign Q_bar=~Q;

    always @(negedge clk or posedge reset) begin
        if(reset)begin
            Q<=0;
        end
        else if(T)
            Q<=~Q;
        else
            Q<=Q;

    end

endmodule