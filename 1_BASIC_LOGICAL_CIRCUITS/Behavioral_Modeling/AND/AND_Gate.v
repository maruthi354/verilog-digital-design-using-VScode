module AND_Gate(F, A, B);

    input A, B;
    output reg F;
    
    always @(*) begin
        if (A==1 && B==1) begin
            F=1;
        end
        else if(A==0 || B==0) begin
            F=0;
        end
        else begin
            F=1'bx;
        end
    end


endmodule