module Decoder_3X8(I, A, B, C);

input A, B, C;
output reg [0:7] I;

always @(*) begin
    if (A==0 && B==0 && C==0)
        I = 8'b10000000;
    else if (A==0 && B==0 && C==1)
        I = 8'b01000000;
    else if (A==0 && B==1 && C==0)
        I = 8'b00100000;
    else if (A==0 && B==1 && C==1)
        I = 8'b00010000;
    else if (A==1 && B==0 && C==0)
        I = 8'b00001000;
    else if (A==1 && B==0 && C==1)
        I = 8'b00000100;
    else if (A==1 && B==1 && C==0)
        I = 8'b00000010;
    else
        I = 8'b00000001;
end

endmodule