

`include "cla.v"

module cla_tb;

    reg [3:0] A,B;
    reg C;
    wire [3:0] sum;
    wire carry;

    cla dut(sum,carry,A,B,C);

    initial begin
        $dumpfile("cla.vcd");
        $dumpvars(0,cla_tb);
    end

    initial begin
        
            
        $display("---------------------------------");
        $display("  A   |  B   | C || Sum  | Carry");
        $display("---------------------------------");

        $monitor(" %b | %b | %b || %b | %b ",A, B ,C, sum,carry);

        A=4'b1101;
        B=4'b1001;
        C=1;        #10
        A=4'b0100;
        B=4'b1010;
        C=0;        #10
        A=4'b1111;
        B=4'b0110;
        C=0;        #10
        $display("---------------------------------");
        $finish;

    end

endmodule