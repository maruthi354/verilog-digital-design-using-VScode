module Sr_Latch(Q, Q_bar, S, R, En);

    input S, R, En;
    output Q, Q_bar;

    wire S_n,R_n;

    nand n0(S_n,En,S);
    nand n1(R_n,En,R);
    nand n2(Q,Q_bar,S_n);
    nand n3(Q_bar,Q,R_n);


endmodule