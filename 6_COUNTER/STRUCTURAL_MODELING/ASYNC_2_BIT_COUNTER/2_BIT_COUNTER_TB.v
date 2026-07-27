

`include "2_BIT_COUNTER.v"

module twobit_counter_tb;

    reg clk,areset;
    wire [1:0] Q;

    twobit_counter dut(Q,clk,areset);

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
        areset=0;#12
        areset=1;
        #50;
        $finish;
    end


endmodule

