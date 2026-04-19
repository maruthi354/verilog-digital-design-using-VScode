`include "Decoder_3X8.v"

module Decoder_3X8_Tb;

    reg A, B, C;
    wire [0:7] I;

    Decoder_3X8 dut(I,A,B,C);

    initial begin
        
        $dumpfile("Decoder_3X8.vcd");
        $dumpvars(0,Decoder_3X8_Tb);
    end

    initial begin
        
        $display("---------------------------");
        $display(" C | A | B ||  I[0:7]");
        $display("---------------------------");

        $monitor(" %b | %b | %b || %b ",C,A,B,I);
        
        A=0;B=0;C=0;
        #10 A=0;B=0;C=1;
        #10 A=0;B=1;C=0;
        #10 A=0;B=1;C=1;
        #10 A=1;B=0;C=0;
        #10 A=1;B=0;C=1;
        #10 A=1;B=1;C=0;
        #10 A=1;B=1;C=1;
        #10 $finish;
    end

endmodule