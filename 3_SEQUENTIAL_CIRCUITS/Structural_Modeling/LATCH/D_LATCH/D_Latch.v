module D_Latch(Q, Q_bar, D, En);

    input En, D;
    output Q, Q_bar;

    wire D_n;
    wire w0,w1;

    not n0(D_n,D);

    nand n0(w0,En,D);   
    nand n1(w1,En,D_n);   
    nand n2(Q,Q_bar,w0);   
    nand n3(Q_bar,Q,w1);   

endmodule