`include "Jk_FF.v"
`timescale 1ns/1ps

module Jk_FF_Tb;

    reg J, K, clk;
    wire Q, Q_bar;

    always #5 clk=~clk;

    Jk_FF dut(Q,Q_bar,J,K,clk);

    initial begin
        $dumpfile("Jk_FF.vcd");
        $dumpvars(0,Jk_FF_Tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  | %b | %b || %b |  %b ",J,K,Q,Q_bar);
    end

    initial begin

        $display("                 -----------------------------");
        $display("                 Time | J | K || Q | Q_bar ");
        $display("                 -----------------------------");
        
        clk=0;
        #2
        J=0;K=0;#10
        J=0;K=1;#10
        J=0;K=0;#10 
        J=1;K=0;#10
        J=0;K=0;#10
        J=1;K=1;#10
        J=0;K=0;#10
        J=1;K=0;#10
        J=0;K=0;#10
        $finish;
    end

endmodule
