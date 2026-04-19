`timescale 1ns/1ps
`include "Decoder_2X4.v"

module Decoder_2X4_Tb;

    reg A, B;
    wire I0, I1, I2, I3;

    Decoder_2X4 dut(I0,I1,I2,I3,A,B);

    initial begin

        $dumpfile("Decoder_2X4.vcd");
        $dumpvars(0,Decoder_2X4_Tb);
    end

    initial begin
        
        $display("---------------------------");
        $display(" A | B || I0 | I1 | I2 | I3");
        $display("---------------------------");

        $monitor(" %b | %b || %b  | %b  | %b  | %b ",A,B,I0,I1,I2,I3);
        A=0;B=0;
        #5 A=0;B=1;
        #5 A=1;B=0;
        #5 A=1;B=1;
        #5 $display("---------------------------");
            A=0;B=1'bx;
        #10 A=1;B=1'bx;
        #10 A=1'bx;B=0;
        #10 $display("-------------------");
            $finish;
    end

endmodule