module Half_Adder(sum, carry, A, B);

    input A, B;
    output reg sum, carry;

    always @(*) begin
        {carry,sum}=A+B;
    end

endmodule