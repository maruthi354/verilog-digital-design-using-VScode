`include "Decoder_2X4.v"

module Decoder_2X4_Tb;

    reg A, B;
    wire [0:3] I;

    Decoder_2X4 dut(I,A,B);

    initial begin
        $dumpfile("Decoder_2X4.vcd");
        $dumpvars(0,Decoder_2X4_Tb);
    end

    initial begin
                
        $display("---------------");
        $display(" A | B ||   I");
        $display("---------------");

        $monitor(" %b | %b || %b  ",A,B,I);
        A=0;B=0;
        #10 A=0;B=1;
        #10 A=1;B=0;
        #10 A=1;B=1;
        #10 $finish;
    end

endmodule