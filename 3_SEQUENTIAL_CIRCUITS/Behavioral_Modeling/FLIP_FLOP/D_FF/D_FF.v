module D_FF(Q, Q_bar, D, clk,reset);

    input clk, D,reset;
    output reg Q;
    output Q_bar;

    assign Q_bar=~Q;

    always @(posedge clk) begin
        if(reset)
            Q<=1'b0;
        else begin
            Q<=D;
        end
    end

endmodule