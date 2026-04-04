module XOR_Gate(F, A, B);

    input A, B;
    output reg F;
    
    always @(*) begin
        F = A? B?0:1 :B?1:0;
    end


endmodule