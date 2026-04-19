module G_To_B(B,G);
    input  [2:0] G;
    output reg [2:0] B;

    always @(*)
    begin
        B[2] = G[2];
        B[1] = G[2] ^ G[1];
        B[0] = (G[2] ^ G[1]) ^ G[0];
    end

endmodule