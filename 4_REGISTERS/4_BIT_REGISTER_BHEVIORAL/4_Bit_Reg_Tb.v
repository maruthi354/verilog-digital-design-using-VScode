

`include "4_Bit_Reg.v"

module fourbit_reg_tb;

    reg [3:0] Q ;
    reg clk, reset;
    wire [3:0] D ;

    fourbit_reg dut(D,Q,clk,reset);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("4_Bit_Reg.vcd");
        $dumpvars(0,fourbit_reg_tb);
    end

    always @(posedge clk) begin
        $strobe($time,"  |   %b   | %d | %d ",reset,Q,D);
    end

    initial begin

        $display("                -----------------------");
        $display("                 Time | Reset | Q  | D ");
        $display("                -----------------------");


        clk=0;
        #7
        Q=4'b0010;#10
        Q=4'b0101;#10
        Q=4'b1111;#10
        Q=4'b1011;#10
        $finish;
    end

    initial begin
        reset=1;#7
        reset=0;
    end

endmodule