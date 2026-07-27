module Sr_Latch(Q, Q_bar, S, R, En);

input S, R, En;
output Q, Q_bar;

assign Q = ~( (R & En) | Q_bar );
assign Q_bar = ~( (S & En) | Q );

endmodule