//Asychnorous

module T_FF(Q, Q_bar, T, clk, reset);

    input T, clk,reset;
    output reg Q;
    output Q_bar;


    always @(posedge clk or posedge reset ) begin
        if (reset==1)begin
            Q<=0;
        end
        else begin
            if(T)
                Q<=~Q;
            else
                Q<=Q;
        end
    end

    assign Q_bar = ~Q; 

endmodule