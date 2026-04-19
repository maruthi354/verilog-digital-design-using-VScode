`include "Bcd_To_7Segment.v"

module Bcd_To_7Segment_Tb;

    reg A,B,C,D;
    wire a,b,c,d,e,f,g;

    Bcd_To_7Segment dut(A,B,C,D,a,b,c,d,e,f,g);

    initial begin
        $dumpfile("Bcd_To_7Segment.vcd");
        $dumpvars(0,Bcd_To_7Segment_Tb);
    end

    initial begin
        // $monitor($time," A=%b, B=%b, C=%b, D=%b,  a=%b,b=%b,c=%b,d=%b,e=%b,f=%b,g=%b",A,B,C,D,a,b,c,d,e,f,g);

        $display("---------------------------------------------");
        $display(" A | B | C | D || a | b | c | d | e | f | g ");
        $display("---------------------------------------------");

        $monitor(" %b | %b | %b | %b || %b | %b | %b | %b | %b | %b | %b  ",A,B,C,D,a,b,c,d,e,f,g);

        {A,B,C,D}=4'b0000;#10
        {A,B,C,D}=4'b0001;#10
        {A,B,C,D}=4'b0010;#10
        {A,B,C,D}=4'b0011;#10
        {A,B,C,D}=4'b0100;#10
        {A,B,C,D}=4'b0101;#10
        {A,B,C,D}=4'b0110;#10
        {A,B,C,D}=4'b0111;#10
        {A,B,C,D}=4'b1000;#10
        {A,B,C,D}=4'b1001;#10
        $display("---------------------------------------------");
        $finish;

    end

endmodule