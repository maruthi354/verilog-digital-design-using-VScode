module Full_Adder(sum, c_out, A, B, c_in);

    input A, B, c_in;
    output reg sum, c_out;
    always @(*) begin
        {c_out,sum}=A+B+c_in;
    end

endmodule