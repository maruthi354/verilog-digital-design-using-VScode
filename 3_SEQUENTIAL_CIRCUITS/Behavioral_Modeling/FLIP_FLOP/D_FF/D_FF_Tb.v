`include "D_FF.v"
`timescale 1ns/1ps

module D_FF_Tb;

    reg D, clk,reset;
    wire Q, Q_bar;

    always #5 clk = ~clk;

    D_FF dut(Q,Q_bar,D,clk,reset);

    initial begin
        $dumpfile("D_FF.vcd");
        $dumpvars(0,D_FF_Tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  |  %b   | %b || %b |  %b ",reset,D,Q,Q_bar);
    end
    initial begin
        
        $display("                 -----------------------------");
        $display("                 Time |Reset | D || Q | Q_bar ");
        $display("                 -----------------------------");

        reset=1;
        clk=0;
        #7
        reset=0;
        D=0;#10
        D=1;#10
        D=0;#20
        $finish;
    end

endmodule