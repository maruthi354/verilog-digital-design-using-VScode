module D_Latch(Q, Q_bar, D, En);

    input En, D;
    output reg Q, Q_bar;


    always @(*) begin
        if (En) begin
            Q<=D;
            Q_bar<=~D;
        end
    end

endmodule