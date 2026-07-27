module Sr_Latch(Q, Q_bar, S, R, En);

input S, R, En;
output reg Q;
output Q_bar;

assign Q_bar = ~Q;

always @(S or R or En)
begin
    if (En) begin
        if (S==1 && R==1)
            Q <= 1'bx;
        else if (S)
            Q <= 1;
        else if (R)
            Q <= 0;
    end
end

endmodule