


`include "4_BIT_COUNTER.v"

module four_bit_counter_tb;

    reg clk,reset;
    wire [3:0] Q;

    always #5 clk=~clk;

    four_bit_counter dut(Q,clk,reset);

    initial begin
        $dumpfile("4_BIT_COUNTER.vcd");
        $dumpvars(0,four_bit_counter_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"   | %b ",Q);
    end

    initial begin

        $display("                  ----------");
        $display("                  Time | Q ");
        $display("                  ----------");

        clk=0;
        reset=1;#7
        reset=0;
        #200;
        $finish;
    end

endmodule