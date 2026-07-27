`timescale 1ns/1ps
`include "melay1011.v"

module melay1011_tb;

    reg in,clk,reset;
    wire out;

    SD1011 dut(out,in,clk,reset);
    
    always #5 clk=~clk;
    initial begin
        $dumpfile("melay1011.vcd");
        $dumpvars(0,melay1011_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"   |  %b | %b ",in,out);
    end

    initial begin

        $display("                  ---------------");
        $display("                  Time | in | out");
        $display("                  ---------------");

        clk=0;
        reset=1;
        #10 reset=0;
        
        #2  in=1;
        #10 in=0; #10 in=1; #10 in=0; #10 in=1;
        #10 in=1; #10 in=1; #10 in=0; #10 in=1;
        #10 in=1; #10 in=0; #10 in=1; #10 in=0;
        #10 $finish ; 
    end

endmodule