`timescale 1ns/1ps
`include "Logical_Gates.v"

module Logical_Gates_Tb;

    reg A, B;
    wire AndG, NandG, OrG, NorG, NotG, XorG, XnorG;
    integer i,j;
    reg [3:0] val ;

    Logical_Gates DUT(AndG, NandG, OrG, NorG, NotG, XorG, XnorG, A, B);

    initial begin

            
        val[0]=1'b0;
        val[1]=1'b1;
        val[2]=1'bx;
        val[3]=1'bz;

        $display(" And|  0   1   x   z");
        $display("--------------------");
               
        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #1 $write(" %b  ",AndG);
            end
            $write("\n");
        end

        $display("\n\n");

        $display("NAnd|  0   1   x   z");
        $display("--------------------");
               
        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #1 $write(" %b  ",NandG);
            end
            $write("\n");
        end

        $display("\n\n");

        $display(" Or |  0   1   x   z");
        $display("--------------------");
               
        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #1 $write(" %b  ",OrG);
            end
            $write("\n");
        end

        $display("\n\n");

        $display(" Nor|  0   1   x   z");
        $display("--------------------");
               
        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #1 $write(" %b  ",NorG);
            end
            $write("\n");
        end

        $display("\n\n");

        $display(" Xor|  0   1   x   z");
        $display("--------------------");
               
        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #1 $write(" %b  ",XorG);
            end
            $write("\n");
        end

        $display("\n\n");

        $display(" Xnor|  0   1   x   z");
        $display("--------------------");
               
        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #10 $write(" %b  ",XnorG);
            end
            $write("\n");
        end

        $display("\n\n");

        $monitor(" %b |  %b",A,NotG);
        $display(" A | Not");
        $display("--------");
        A=1'b0;
        #5 A=1'b1;
        #5 A=1'bx;
        #5 A=1'bZ;
        #5 $finish;
    
    end

endmodule