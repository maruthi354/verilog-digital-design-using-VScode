
`timescale 1ns/1ps
`include "Full_Subtractor.v"

module Full_Subtractor_Tb;

    reg A, B, Z;
    wire Diff, Borrow;

    integer i,j,k;
    reg[3:0] val;

    Full_Subtractor SUB(Diff, Borrow, A, B, Z);

    initial begin
        $dumpfile("Full_Subtractor.vcd");
        $dumpvars(0,Full_Subtractor_Tb);
    end

        initial begin
        val[0]=1'b0;
        val[1]=1'b1;
        val[2]=1'bx;
        val[3]=1'bz;

        $display("\t\t\t\t ","----------------------------------");
        $display("\t\t\t\t  ","time| A | B | Z |Diff | Borrow");
        $display("\t\t\t\t ","----------------------------------");

        for(i=0;i<2;i=i+1)begin
          A=val[i];
          for(j=0;j<2;j=j+1)begin
            B=val[j];
            for(k=0;k<2;k=k+1)begin
                Z=val[k];
                #5 $write($time,"  | %b | %b | %b |  %b  |  %b\n",A,B,Z,Diff,Borrow);
            end
          end
        end

        
        $display("\t\t\t\t ","------------------------------");

        for(i=0;i<2;i=i+1)begin
          A=val[i];
          for(j=2;j<4;j=j+1)begin
            B=val[j];
            for(k=0;k<2;k=k+1)begin
                Z=val[k];
                #5 $write($time,"  | %b | %b | %b |  %b  |  %b\n",A,B,Z,Diff,Borrow);
            end
          end
        end
        
        #5 $finish;

    end

endmodule

