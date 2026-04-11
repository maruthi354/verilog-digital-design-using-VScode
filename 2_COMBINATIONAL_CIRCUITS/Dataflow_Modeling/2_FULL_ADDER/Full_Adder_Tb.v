
`timescale 1ns/1ps
`include "Full_Adder.v"

module Full_Adder_Tb;
    
    reg A, B, C_in;
    wire sum, c_out;

    integer i,j,k;
    reg[3:0] val;

    Full_Adder DUT (sum, c_out, A, B, C_in);

    initial begin
        $dumpfile("Full_Adder.vcd");
        $dumpvars(0,Full_Adder_Tb);
    end

        initial begin
        val[0]=1'b0;
        val[1]=1'b1;
        val[2]=1'bx;
        val[3]=1'bz;

        $display("\t\t\t\t ","---------------------------------");
        $display("\t\t\t\t  ","time| A | B | Cin | sum | carry");
        $display("\t\t\t\t ","---------------------------------");

        for(i=0;i<2;i=i+1)begin
          A=val[i];
          for(j=0;j<2;j=j+1)begin
            B=val[j];
            for(k=0;k<2;k=k+1)begin
                C_in=val[k];
                #5 $write($time,"  | %b | %b |  %b  |  %b  |  %b\n",A,B,C_in,sum,c_out);
            end
          end
        end

        
        $display("\t\t\t\t ","------------------------------");

        for(i=0;i<2;i=i+1)begin
          A=val[i];
          for(j=2;j<4;j=j+1)begin
            B=val[j];
            for(k=0;k<2;k=k+1)begin
                C_in=val[k];
                #5 $write($time,"  | %b | %b |  %b  |  %b  |  %b\n",A,B,C_in,sum,c_out);
            end
          end
        end
        
        #5 $finish;

    end

endmodule