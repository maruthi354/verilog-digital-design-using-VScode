module Full_Adder (sum, c_out, A, B, c_in);

    input A, B, c_in;
    output sum, c_out;
    wire w0, w1, w2;

    xor f0(w0, A, B);
    and f1(w1, A, B);
    and f2(w2,w0,c_in);
    xor f3(sum, w0,c_in);
    or  f4(c_out, w1, w2);
    
endmodule