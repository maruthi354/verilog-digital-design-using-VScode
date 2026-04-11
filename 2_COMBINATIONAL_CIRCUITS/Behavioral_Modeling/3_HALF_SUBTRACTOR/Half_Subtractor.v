module Half_Subtractor(Diff, Borrow, A, B);

    input A, B;
    output reg Diff, Borrow;

    always @(*) begin
        Diff = A ^ B;
        Borrow = ~A & B;
    end

endmodule