`include "Priority_Encoder_4x2.v"

module Priority_Encoder_4X2_Tb;

    reg [3:0] I;
    wire A1, A0, V;

    Priority_Encoder_4X2 dut(A1, A0, V, I);

    initial begin
        $monitor($time, " I=%b, A1=%b, A0=%b, V=%b",I, A1, A0, V);
        $dumpfile("Priority_Encoder_4X2.vcd");
        $dumpvars(0,Priority_Encoder_4X2_Tb);
    end

    initial begin
        I = 4'b0000;
        #10 I = 4'b0001;
        #10 I = 4'b0010;
        #10 I = 4'b0100;
        #10 I = 4'b1000;
        #10 $finish;
    end

endmodule