module Priority_Encoder_4X2(A1, A0, V, I);

    input [3:0] I;
    output A1,A0,V;


    assign A1 = I[2] | I[3];
    assign A0 = I[3] | (I[1] & ~I[2]);
    assign V = I[0] | I[1] | I[2] | I[3];
    
endmodule