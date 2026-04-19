`include "Encoder_8x3.v"

module Encoder_8X3_Tb;

    reg [7:0] I;
    wire A2, A1, A0;

    Encoder_8X3 dut(A2, A1, A0, I);

    initial begin
        $dumpfile("Encoder_8X3.vcd");
        $dumpvars(0,Encoder_8X3_Tb);
    end

    initial begin
        //$monitor($time, " I=%b, A2=%b, A1=%b, A0=%b", I, A2, A1, A0);
        
        $display("--------------------------");
        $display("    I     || A2| A1| A0");
        $display("--------------------------");

        $monitor(" %b || %b | %b | %b",I, A2, A1,A0);

            I=8'b00000001;
        #10 I=8'b00000010;
        #10 I=8'b00000100;
        #10 I=8'b00001000;
        #10 I=8'b00010000;
        #10 I=8'b00100000;
        #10 I=8'b01000000;
        #10 I=8'b10000000;
        #10 $finish;
    end

endmodule