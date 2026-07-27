module Sr_FF(Q, Q_bar, S, R, clk);

    input S, R, clk;
    output reg Q;
    output Q_bar;

    assign Q_bar = ~Q;
    always @(posedge clk ) begin
        if(clk) begin
            if(S==1 && R==1)
                Q<=1'bx;
            else if(S==1)
                Q<=1;
            else if(R==1)
                Q<=0;
        end
    end


endmodule