module Logical_Gates(AndG, NandG, OrG, NorG, NotG, XorG, XnorG, A, B);
    
    input A, B;
    output AndG, NandG, OrG, NorG, NotG, XorG, XnorG;


    assign AndG  = A & B;
    assign NandG = ~(A & B);
    assign OrG   = A | B;
    assign NorG  = ~(A | B);
    assign NotG  = ~A;
    assign XorG  = A ^ B;
    assign XnorG = ~(A ^ B);

endmodule