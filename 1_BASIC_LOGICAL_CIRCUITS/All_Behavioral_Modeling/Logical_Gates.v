module Logical_Gates(AndG, NandG, OrG, NorG, NotG, XorG, XnorG, A, B);
    
    input A, B;
    output reg AndG, NandG, OrG, NorG, NotG, XorG, XnorG;

    always @(*) begin
        AndG = A? (B?1:0) : (0) ;
        NandG = A? (B?0:1) : (1) ;
        OrG = A? (1) : (B?1:0) ;
        NorG = A? (0) : (B?0:1) ;
        XorG = A? (B?0:1) : (B?1:0) ;
        XnorG = A? (B?1:0) : (B?0:1) ;
        NotG = A? 0 : 1;
    end
    
endmodule