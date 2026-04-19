`include "Decoder_2X4.v"

module Decoder_2X4_Tb;

    reg A, B, En;
    wire [0:3] I;

    Decoder_2X4 dut(I,A,B,En);

    initial begin
        
        $dumpfile("Decoder_2X4.vcd");
        $dumpvars(0,Decoder_2X4_Tb);
    end

    initial begin

        
        $display("-------------------");
        $display(" EN| A | B ||   I");
        $display("-------------------");

        $monitor(" %b | %b | %b || %b  ",En,A,B,I);

        En=1;
        A=0;B=0;
        #10 A=0;B=1;
        #10 En=0;
        A=0;B=0;
        #10 A=0;B=1;
        #10 A=1;B=0;
        #10 A=1;B=1;
        #10 $display("-------------------");
            A=0;B=1'bx;
        #10 A=1;B=1'bx;
        #10 A=1'bx;B=0;
        #10 $display("-------------------");
            $finish;
    end

endmodule