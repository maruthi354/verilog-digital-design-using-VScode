module cla(sum,carry,A,B,C);
    input [3:0] A, B;
    input C;
    output [3:0] sum;
    output carry;


    wire [3:0] G, P;
    wire C1, C2, C3;

    // Generate and Propagate
    assign G = A & B;
    assign P = A ^ B;

    // Carry equations
    assign C1 = G[0] | (P[0] & C);
    assign C2 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C);
    assign C3 = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C);
    assign carry = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |(P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C);

    // Sum
    assign sum[0] = P[0] ^ C;
    assign sum[1] = P[1] ^ C1;
    assign sum[2] = P[2] ^ C2;
    assign sum[3] = P[3] ^ C3;

endmodule