`include "Sr_FF.v"
`timescale 1ns/1ps

module Sr_FF_Tb;

    reg S, R, clk;
    wire Q, Q_bar;

    always #5 clk=~clk;

    Sr_FF dut(Q,Q_bar,S,R,clk);

    initial begin
        $dumpfile("Sr_FF.vcd");
        $dumpvars(0,Sr_FF_Tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  | %b | %b || %b |  %b ",S,R,Q,Q_bar);
    end

    initial begin

        $display("                 -----------------------------");
        $display("                 Time | S | R || Q | Q_bar ");
        $display("                 -----------------------------");

        clk=0;
        #2
        S=0;R=0;#10
        S=0;R=1;#10
        S=0;R=0;#10 
        S=1;R=0;#10
        S=0;R=0;#10
        S=1;R=1;#10
        S=0;R=0;#10
        S=1;R=0;#10
        S=0;R=0;#10
        $finish;

    end

endmodule