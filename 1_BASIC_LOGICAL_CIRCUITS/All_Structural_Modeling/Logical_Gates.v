
module Logical_Gates(AndG, NandG, OrG, NorG, NotG, XorG, XnorG, A, B);
    
    input A, B;
    output AndG, NandG, OrG, NorG, NotG, XorG, XnorG;

    and A0(AndG, A, B);

    nand nA0(NandG, A, B);

    or O0(OrG, A, B);

    nor nO0(NorG, A, B);

    not nt0(NotG, A);

    xor x0(XorG, A, B);

    xnor nx0(XnorG, A, B);

endmodule