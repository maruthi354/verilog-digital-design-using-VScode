module D_Latch(Q, Q_bar, D, En);

    input En, D;
    output Q, Q_bar;

    assign Q=En?D:Q;
    assign Q_bar=~Q;

endmodule