`include "Demux_1X2.v"

module Demux_1X2_Tb;

    reg I,S;
    wire Y1,Y0;

    Demux_1X2 dut(Y1,Y0,I,S);

    initial begin
        $dumpfile("Demux_1X2.vcd");
        $dumpvars(0,Demux_1X2_Tb);
    end

    initial begin
        $display("\t\t\t\t"," time| I | S | Y1  Y0");
        $display("\t\t\t\t","-----------------------");

        $monitor($time, " | %b | %b | %b   %b",I,S,Y1,Y0);
        I=0;S=0;#10
        I=1;S=0;#10
        I=0;S=1;#10
        I=1;S=1;#10
        $finish;
    end

endmodule