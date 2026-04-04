`include "NOT_Gate.v"
module NOT_Tb;

    reg A;
    wire F;

    NOT_Gate DUT(F, A);

    initial begin
        $monitor(" %b |  %b",A,F);
        $display(" A | out");
        $display("--------");
        A=1'b0;
        #5 A=1'b1;
        #5 A=1'bx;
        #5 A=1'bZ;
        #5 $finish;
    end


endmodule