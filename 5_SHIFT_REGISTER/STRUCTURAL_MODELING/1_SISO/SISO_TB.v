
`include "SISO.v"

module siso_tb;

    reg clk, Serial_in,reset;
    wire Serail_out;

    siso dut(Serail_out,Serial_in,clk,reset);

    always #5 clk=~clk;

    initial begin
        $dumpfile("SISO.vcd");
        $dumpvars(0,siso_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  |   %b   |     %d     |     %d     ",reset,Serial_in,Serail_out);
    end

    initial begin
        $display("                ---------------------------------------");
        $display("                 Time | Reset | Serial_in | Serail_out ");
        $display("                ---------------------------------------");

        clk=0;
        reset=1;#7
        reset=0;

        Serial_in=0;#10
        Serial_in=1;#10
        Serial_in=0;#10
        Serial_in=1;#10
        Serial_in=1;#10
        Serial_in=0;#10
        $finish;
    end

endmodule