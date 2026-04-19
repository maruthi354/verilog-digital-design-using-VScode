module Decoder_2X4(I,A,B,En);

    input A, B, En;
    output reg [0:3] I;

    always @(*) begin
        if(En==1) I=4'b0000;
        else begin
            case ({A,B})
                0:I=4'b1000; 
                1:I=4'b0100; 
                2:I=4'b0010; 
                3:I=4'b0001;
            endcase
        end
    end

endmodule