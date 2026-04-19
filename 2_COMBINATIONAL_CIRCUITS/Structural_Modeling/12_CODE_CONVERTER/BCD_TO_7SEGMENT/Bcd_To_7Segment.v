//BCD To 7 Segment code
/*
a =𝑨+𝑪+𝑩^′ 𝑫^′+𝑩𝑫
b =𝑩′+𝑪^′ 𝑫^′+𝑪𝑫
c =𝑩+𝑪′+𝑫
d =𝑨+𝑩^′ 𝑪+𝑩^′ 𝑫′+𝑪𝑫′+𝑩𝑪^′ 𝑫
e =𝑩^′ 𝑫′+𝑪𝑫′
f =𝑨+𝑩𝑪′+〖𝑩𝑫^′+𝑪〗^′ 𝑫^′
g =𝑨+𝑩𝑪′+𝑩^′ 𝑪+𝑩𝑫′
*/

module Bcd_To_7Segment(A, B, C, D, a, b, c, d, e, f, g);

    input A, B, C, D;
    output a, b, c, d, e, f, g;

    wire B_n, C_n, D_n;
    wire w0, w1, w2, w3, w4, w5, w6, w7, w8;

    not n1(B_n,B);
    not n1(C_n,C);
    not n1(D_n,D);

    and A0(w0,B_n,D_n);
    and A1(w1,B,D);
    and A2(w2,B,D_n);
    and A3(w3,C,D);
    and A4(w4,C_n,D_n);
    and A5(w5,C,D_n);
    and A6(w6,B,C_n,D);
    and A7(w7,B_n,C);
    and A8(w8,B,C_n);

    or s0(a,A,C,w0,w1);
    or s1(b,B_n,w3,w4);
    or s2(c,B,C_n,D);
    or s3(d,A,w7,w0,w5,w6);
    or s4(e,w0,w5);
    or s5(f,A,w8,w2,w4);
    or s6(g,A,w8,w7,w2);

endmodule