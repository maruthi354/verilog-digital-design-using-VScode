module Demux_1X2(Y1,Y0,I,S);

    input I,S;
    output reg Y1,Y0;

    always @(*) begin
        if (sel == 1'b0) begin
            Y0 = I;
            Y1 = 1'b0; 
        end else begin
            Y0 = 1'b0; 
            Y1 = I;
        end
    end

endmodule