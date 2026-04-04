module NOT_Gate(F, A);

    input A;
    output reg F;
    
    always @(*) begin
        F = A?0:1;
    end


endmodule