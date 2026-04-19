module B_To_G (G,B);
    input  [2:0] B;
    output reg [2:0] G;

    always @(*)
    begin
        G[2] = B[2];
        G[1] = B[2] ^ B[1];
        G[0] = B[1] ^ B[0];
    end

endmodule