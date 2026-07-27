

`include "JOHNSON_COUNTER.v"

module johnson_counter_tb;

    reg clk,reset;
    wire q;

    always #5 clk=~clk;

    johnson_counter dut(q,clk,reset);

    initial begin
        $dumpfile("JOHNSON_COUNTER.vcd");
        $dumpvars(0,johnson_counter_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"   | %b ",q);
    end

    initial begin

        $display("                  ----------");
        $display("                  Time | Q ");
        $display("                  ----------");

        reset=1;
        clk=0;
        #10;
        reset=0;
        #200
        $finish;
    end

endmodule