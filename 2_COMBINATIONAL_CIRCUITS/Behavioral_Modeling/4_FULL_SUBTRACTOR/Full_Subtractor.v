module Full_Subtractor(Diff, Borrow, A, B, C);

    input A, B, C;
    output reg Diff, Borrow;

    always @(*) begin
        Diff = A ^ B ^ C;
        Borrow = (~A & B) | ((~(A ^ B)) & C);
    end

endmodule