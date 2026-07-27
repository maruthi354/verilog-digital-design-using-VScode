

`include "2_BIT_COUNTER.v"

module twobit_counter_tb;

    reg clk,reset;
    wire [1:0] Q;

    twobit_counter dut(Q,clk,reset);

    always #5 clk=~clk;

    initial begin
        $dumpfile("2_BIT_COUNTER.vcd");
        $dumpvars(0,twobit_counter_tb);
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
        #50;
        $finish;
    end


endmodule