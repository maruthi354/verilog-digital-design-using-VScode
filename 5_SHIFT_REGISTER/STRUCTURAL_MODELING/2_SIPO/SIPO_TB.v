
`include "SIPO.v"

module sipo_tb;

    reg serial_in, clk,reset;
    wire [3:0] parallel_out;

    sipo dut(parallel_out,serial_in,clk,reset);

    always #5 clk=~clk;

    initial begin
        $dumpfile("SIPO.vcd");
        $dumpvars(0,sipo_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  |   %b   |     %d     |     %d     ",reset,serial_in,parallel_out);
    end

    initial begin
        $display("                -----------------------------------------");
        $display("                 Time | Reset | Serial_in | parallel_out ");
        $display("                -----------------------------------------");

        clk=0;
        reset=1;#7
        reset=0;

        serial_in=0;#10
        serial_in=1;#10
        serial_in=0;#10
        serial_in=0;#10
        serial_in=1;#10
        $finish;
    end

endmodule