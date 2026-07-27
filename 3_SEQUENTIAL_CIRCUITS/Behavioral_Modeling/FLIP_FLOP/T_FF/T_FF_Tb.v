`include "T_FF.v"
`timescale 1ns/1ps

module T_FF_Tb;

reg T, clk, reset;
wire Q, Q_bar;

always #5 clk = ~clk;

T_FF dut(Q, Q_bar, T, clk, reset);

initial
begin
    $dumpfile("T_FF.vcd");
    $dumpvars(0, T_FF_Tb);
end

always @(posedge clk) begin
    $strobe($time,"  |  %b   | %b || %b |  %b ",reset,T,Q,Q_bar);
end

initial
begin
    $display("                 -----------------------------");
    $display("                 Time |Reset | T || Q | Q_bar ");
    $display("                 -----------------------------");

    clk = 0;
    #2
    #2  T=0; 
    reset=1;
    #10 T=1; 
    reset=0; 
    #10 T=1;  
    #10 T=0; 
    #10 T=1;  
    #10 T=0;

    #20 $finish;
end

endmodule