// Binary to Gray Code

module B_To_G(O,I);

    input [2:0] I;
    output [2:0] O;

    assign O[0]= I[1] ^ I[0];
    assign O[1]= I[1] ^ I[2];
    assign O[2]= I[2];

endmodule