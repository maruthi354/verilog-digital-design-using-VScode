`timescale 1ns/1ps
`include "Mux_2X1.v"

module Mux_2X1_Tb;

reg I0, I1, S;
wire Y;

Mux_2X1 uut (Y,I0,I1,S);

initial begin
    $dumpfile("Mux_2X1.vcd");
    $dumpvars(0,Mux_2X1_Tb);
end

initial
begin
    $display("-------------");
    $display("I0| I1| S | Y");
    $display("-------------");
    $monitor("%b | %b | %b | %b", I0, I1, S, Y);

    I0 = 0; I1 = 0; S = 0; 
    #10 I0 = 0; I1 = 1; S = 0; 
    #10 I0 = 1; I1 = 0; S = 0; 
    #10 I0 = 1; I1 = 1; S = 0; 
    #10 I0 = 0; I1 = 0; S = 1; 
    #10 I0 = 0; I1 = 1; S = 1; 
    #10 I0 = 1; I1 = 0; S = 1; 
    #10 I0 = 1; I1 = 1; S = 1;
    #10 $display("-------------");
        I0 = 1'bx; I1 = 1'bz; S = 1;
    #10 I0 = 1'bx; I1 = 1'bz; S = 0;
    #10 I0 = 1; I1 = 0; S = 1'bz;
    #10 I0 = 1; I1 = 0; S = 1'bx;
    #10 $display("-------------");
         $finish;

end

endmodule