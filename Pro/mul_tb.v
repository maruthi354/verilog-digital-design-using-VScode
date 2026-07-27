`include "mul.v"

module mul_tb;

    reg [3:0] in1,in2;
    wire[4:0]  cur,out;

    mul dd(out,cur,in1,in2);

    initial begin
        in1=9;in2=2;

        #5 $display("%b %d",out,cur);
        #5 $finish;
    end

endmodule