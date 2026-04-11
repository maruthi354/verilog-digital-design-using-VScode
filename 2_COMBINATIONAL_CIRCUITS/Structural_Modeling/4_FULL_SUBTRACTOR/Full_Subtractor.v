// Structural modeling of Full Subtractor using 2 Half Subtractor
`include "Half_subtractor.v"

module Full_Subtractor(Diff, Borrow, A, B, Z);

    input A, B ,Z;
    output Borrow, Diff;
    wire w0, w1,w2;

    Half_Subtractor f0(w0,w1,A,B);
    Half_Subtractor f1(Diff,w2,w0,Z); 
    or f3(Borrow,w2,w1);

endmodule