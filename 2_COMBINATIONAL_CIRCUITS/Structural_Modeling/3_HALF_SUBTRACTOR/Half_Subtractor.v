module Half_Subtractor(Borrow, Diff, A, B);

    input A, B;
    output Diff, Borrow;
    wire w0;

    xor h0(Diff, A, B);
    not h1(w0,A);
    and h2(Borrow, w0, B);
    
endmodule