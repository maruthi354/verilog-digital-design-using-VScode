module Full_Adder(sum, c_out, A, B, c_in);

    input A, B, c_in;
    output sum, c_out;

    assign sum = A ^ B ^ c_in;
    assign c_out = ((A ^ B)&c_in) | (A & B);

endmodule