module Priority_Encoder_4X2(A1, A0, V, I);

    input [3:0] I;
    output reg A1,A0,V;

    always @(*) begin
        if (I==0) begin
            V=0;
            A1=1'bx;
            A0=1'bx;
        end
        else begin
            V=1;
            case (I)
                4'b0001: 
                    begin
                        A0=0;
                        A1=0; 
                    end 
                4'b0010:
                    begin    
                    A0=0;
                    A1=1; 
                    end 
                4'b0100:
                    begin
                        A0=1; 
                        A1=0; 
                    end
                4'b1000:
                    begin
                        A0=1; 
                        A1=1; 
                    end
            endcase
        end
    end
    
    
endmodule