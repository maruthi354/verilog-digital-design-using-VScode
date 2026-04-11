module Full_Subtractor(Diff, Borrow, A, B, C);

    input A, B, C;
    output Diff, Borrow;

    assign Diff = A ^ B ^ C;
    assign Borrow = (~A & B) | ((~(A ^ B)) & C);

endmodule