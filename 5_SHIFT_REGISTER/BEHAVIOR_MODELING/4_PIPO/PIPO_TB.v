
`include "PIPO.v"

module pipo_tb;

    reg [3:0] parallel_in;
    reg clk,reset;
    wire [3:0] parallel_out;

    pipo dut(parallel_out, parallel_in, clk, reset);

    always #5 clk=~clk;

    initial begin
        $dumpfile("PIPO.vcd");
        $dumpvars(0,pipo_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  |   %b   |      %d     |     %d     ",reset,parallel_in,parallel_out);
    end

    initial begin
        $display("                -------------------------------------------");
        $display("                 Time | Reset | parallel_in | parallel_out ");
        $display("                -------------------------------------------");

        clk=0;
        reset=1;
        parallel_in=4'b1001;#10
        reset=0;

        parallel_in=4'b1011;#10
        parallel_in=4'b1000;#10
        parallel_in=4'b1001;#10
        parallel_in=4'b0110;#10
        $finish;

    end

endmodule