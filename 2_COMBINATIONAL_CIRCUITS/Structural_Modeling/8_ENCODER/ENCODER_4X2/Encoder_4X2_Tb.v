`include "Encoder_4x2.v"

module Encoder_4X2_Tb;

    reg D3, D2, D1, D0;
    wire A1, A0;

    Encoder_4X2 dut(A1, A0, D3, D2 , D1, D0);

    initial begin
        $dumpfile("Encoder_4X2.vcd");
        $dumpvars(0,Encoder_4X2_Tb);
    end

    initial begin
        
        $display("--------------------------");
        $display(" D3| D2| D1| D0|| A1| A0");
        $display("--------------------------");

        $monitor(" %b | %b | %b | %b || %b | %b",D3, D2 , D1, D0, A1, A0);

        {D3,D2,D1,D0} = 4'b0001;
        #10 {D3,D2,D1,D0} = 4'b0010;
        #10 {D3,D2,D1,D0} = 4'b0100;
        #10 {D3,D2,D1,D0} = 4'b1000;
        #10 $finish;
    end

endmodule