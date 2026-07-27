`timescale 1ns/1ps
`include "Moore1001.v"

module Moore_tb;

    reg in,reset,clk;
    wire out;

    SD1001 dut(out,in,clk,reset);

    initial begin
        // $monitor($time,"in=%b out=%b",in,out);
        $dumpfile("Moore1001.vcd");
        $dumpvars(0,Moore_tb);
    end

    always #5 clk=~clk;

    always @(posedge clk) begin
        $strobe($time,"   |  %b | %b ",in,out);
    end

    initial begin

        $display("                  ---------------");
        $display("                  Time | in | out");
        $display("                  ---------------");
        
        clk=0;
        reset=1;
        #7 reset=0;

        #2  in=1; 
        #10 in=0; #10 in=1; #10 in=0; #10 in=0;
        #10 in=1; #10 in=0; #10 in=0; #10 in=1;
        #10 in=1; #10 in=0; #10 in=0; #10 in=1;
        #10 $finish;
    end


endmodule