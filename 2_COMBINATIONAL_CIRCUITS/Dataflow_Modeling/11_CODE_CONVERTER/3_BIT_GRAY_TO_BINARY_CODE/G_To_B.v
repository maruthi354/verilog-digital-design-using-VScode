// Binary to Gray Code

module G_To_B(O,I);

    input [2:0] I;
    output [2:0] O;

    assign O[2]= I[2];
    assign O[1]= I[1] ^ I[2];
    assign O[0]= O[1] ^ I[0];

endmodule