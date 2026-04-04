module XNOR_Gate(F, A, B);

    input A, B;
    output F;

    xnor x0(F, A, B);

endmodule