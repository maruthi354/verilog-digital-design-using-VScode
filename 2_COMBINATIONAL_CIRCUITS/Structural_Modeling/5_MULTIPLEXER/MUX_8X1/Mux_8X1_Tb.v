`include "Mux_8X1.v"

module Mux_8X1_Tb;

    reg [7:0] I;
    reg [2:0] S;
    wire Y;

    Mux_8X1 dut(Y,I,S);

    initial begin
        $dumpfile("Mux_8X1.vcd");
        $dumpvars(0,Mux_8X1_Tb);
    end

    initial begin
        $monitor($time," I=%b  S=%b  Y=%b", I, S, Y);

        I=8'b10011010;
        S=0;
        #10 S=1;
        #10 S=2;
        #10 S=3;
        #10 S=4;
        #10 S=5;
        #10 S=6;
        #10 S=7;
        #10 $finish;

    end


endmodule