
module cla(sum,carry,A,B,C);

    input [3:0] A,B;
    input C;
    output [3:0] sum;
    output carry;

    wire p0,p1,p2,p3;
    wire g0,g1,g2,g3;
    wire c1,c2,c3;

    xor x0(p0,A[0],B[0]);
    xor x1(p1,A[1],B[1]);
    xor x2(p2,A[2],B[2]);
    xor x3(p3,A[3],B[3]);

    and a0(g0,A[0],B[0]);
    and a1(g1,A[1],B[1]);
    and a2(g2,A[2],B[2]);
    and a3(g3,A[3],B[3]);

    //carry 1
    wire w0;
    and cc1(w0,p0,C);
    or c_1(c1,g0,w0);

    //carry 2
    wire w1,w2;
    and cc2(w1,p1,p0,C);
    and cc3(w2,p1,g0);
    or c_2(c2,g1,w1,w2);

    //carry 3
    wire w3, w4, w5;
    and cc4(w3,p2,p1,p0,C);
    and cc5(w4,p2,p1,g0);
    and cc6(w5,p2,g1);
    or c_3(c3,g2,w3,w4,w5);

    //carry 4
    wire w6, w7, w8, w9;
    and cc7(w6,p3,p2,p1,p0,C);
    and cc8(w7,p3,p2,p1,g0);
    and cc9(w8,p3,p2,g1);
    and cc10(w9,p3,g2);
    or c_4(carry,g3,w6,w7,w8,w9);

    //sum 0
    xor s0(sum[0],p0,C);
    xor s1(sum[1],p1,c1);
    xor s2(sum[2],p2,c2);
    xor s3(sum[3],p3,c3);

endmodule