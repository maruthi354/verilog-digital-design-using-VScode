module Half_Adder (sum, carry, A, B);

    input A, B;
    output sum, carry;

    xor h0(sum, A, B);
    and h1(carry, A, B);
    
endmodule