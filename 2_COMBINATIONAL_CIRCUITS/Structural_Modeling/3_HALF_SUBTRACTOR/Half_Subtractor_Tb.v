
`timescale 1ns/1ps
`include "Half_Subtractor.v"

module Half_Subtractor_Tb;
    
    reg A, B;
    wire Diff, Borrow;

    integer i,j;
    reg [3:0] val;


    Half_Subtractor DUT (Borrow, Diff, A, B);

    initial begin
        //$monitor($time," A = %b , B = %b , Diff = %b , Borrow = %b", A, B, Diff, Borrow);
        $dumpfile("Half_Subtractor.vcd");
        $dumpvars(0,Half_Subtractor_Tb);
    end

    initial begin
    val[0]=1'b0;
    val[1]=1'b1;
    val[2]=1'bx;
    val[3]=1'bz;

    $display("\t\t\t\t ","-----------------------------");
    $display("\t\t\t\t  ","time| A | B |Diff | Borrow");
    $display("\t\t\t\t ","-----------------------------");

    for(i=0;i<2;i=i+1)begin
      A=val[i];
      for(j=0;j<2;j=j+1)begin
        B=val[j];
        #5 $write($time,"  | %b | %b |  %b  |  %b\n",A,B,Diff,Borrow);
      end
    end

    $display("\t\t\t\t ","-------------------------");

    for(i=2;i<4;i=i+1)begin
      A=val[i];
      for(j=0;j<4;j=j+1)begin
        B=val[j];
        #5 $write($time,"  | %b | %b |  %b  |  %b\n",A,B,Diff,Borrow);
      end
    end
    
    #5 $finish;

  end

endmodule
