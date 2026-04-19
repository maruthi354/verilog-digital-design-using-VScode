//"Structural modeling using a generate block to instantiate N Full Adder modules, forming a ripple carry adder."

`include "N_Bit_Adder.v"

module N_Bit_Adder_Tb;

    parameter N = 4;
    reg [N-1:0] A,B;
    reg C_IN;
    wire [N-1:0] SUM;
    wire CARRY;
    
    N_Bit_Adder dut(SUM, CARRY, A, B, C_IN);

    initial begin
        $monitor($time," A = %b, B = %b, Sum = %b , Carry = %b", A, B, SUM, CARRY);
        $dumpfile("N_Bit_Adder.vcd");
        $dumpvars(0,N_Bit_Adder_Tb);
    end

    initial begin
        C_IN = 0;
        A=4'b1011;
        B=4'b0101;
        #10 
        A=4'b1111;
        B=4'b1010;
        #10
        $finish;
    end

endmodule