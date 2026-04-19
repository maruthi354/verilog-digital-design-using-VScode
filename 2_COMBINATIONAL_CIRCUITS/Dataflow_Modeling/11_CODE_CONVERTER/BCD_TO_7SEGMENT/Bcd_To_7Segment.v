//BCD To 7 Segment code
/*
a =𝑨+𝑪+𝑩′𝑫′+𝑩𝑫
b =𝑩′+𝑪′𝑫′+𝑪𝑫
c =𝑩+𝑪′+𝑫
d =𝑨+𝑩′𝑪+𝑩′𝑫′+𝑪𝑫′+𝑩𝑪′𝑫
e =𝑩′𝑫′+𝑪𝑫′
f =𝑨+𝑩𝑪′+𝑩𝑫′+𝑪′𝑫′
g =𝑨+𝑩𝑪′+𝑩′𝑪+𝑩𝑫′
*/

module Bcd_To_7Segment(A, B, C, D, a, b, c, d, e, f, g);

    input A, B, C, D;
    output a, b, c, d, e, f, g;

    assign a= A | C |  (~B & ~D) | (B & D);
    assign b= ~B |  (~C & ~D) | (C & D);
    assign c= B | ~C | D;
    assign d= A | ( ~B & C )|  (~B & ~D) | (C & ~D) | (B & ~C & D);
    assign e= (~B & ~D) | (C & ~D);
    assign f= A |  (B & ~C) | (B & ~D) | (~C & ~D);
    assign g= A | (B & ~C) | (~B & C) | (B & ~D);
    

endmodule