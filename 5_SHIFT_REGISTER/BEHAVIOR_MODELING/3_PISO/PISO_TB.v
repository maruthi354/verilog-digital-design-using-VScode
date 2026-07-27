
`include "PISO.v"

module piso_tb;

    reg [3:0] parallel_in;
    reg clk, load, reset;
    wire serial_out;

    piso dut(serial_out,parallel_in,clk,load,reset);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("PISO.vcd");
        $dumpvars(0,piso_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  |   %b   |      %d     |     %d     ",reset,parallel_in,serial_out);
    end

    initial begin
        $display("                ---------------------------------------");
        $display("                 Time | Reset | Parallel_in | Serial_out ");
        $display("                ---------------------------------------");


        clk=0;
        reset=1;
        load=0;
        parallel_in=4'b0000;#10
        reset=0;

        load=1;
        parallel_in=4'b1101;#10
        load=0;
        #70
        $finish;

    end

endmodule