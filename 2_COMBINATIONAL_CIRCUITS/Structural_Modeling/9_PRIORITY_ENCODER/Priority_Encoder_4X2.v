module Priority_Encoder_4X2(A1, A0, V, I);

    input [3:0] I;
    output A1,A0,V;
    wire w0,w1;

    not n1(w0,I[2]);
    and a1(w1,I[1],w0);

    or PE0(A1,I[2],I[3]);
    or PE1(A0,I[3],w1);
    or PE2(V,I[0],I[1],I[2],I[3]);
    
endmodule