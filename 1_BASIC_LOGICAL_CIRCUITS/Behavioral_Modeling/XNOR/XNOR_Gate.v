module XNOR_Gate(F, A, B);

    input A, B;
    output reg F;
    
    always @(*) begin
        F = A? B?1:0 :B?0:1;
    end


endmodule