`include "Mux_4X1.v"

module Mux_4X1_Tb;

    reg I0, I1, I2, I3;
    reg [1:0] S;
    wire Y;

    Mux_4X1 dut(Y,I0,I1,I2,I3,S);

    initial begin
        $dumpfile("Mux_4X1.vcd");
        $dumpvars(0,Mux_4X1_Tb);
    end

    initial begin
    
        $display("-------------------");
        $display("   I  | S1 | S0 | Y");
        $display("-------------------");
        $monitor(" %b%b%b%b | %b  | %b  | %b",I0,I1,I2,I3,S[1],S[0],Y);
        I0=0; I1=1; I2=0; I3=1;
        S[1]=0; S[0]=0; #10;   
        S[1]=0; S[0]=1; #10;   
        S[1]=1; S[0]=0; #10;   
        S[1]=1; S[0]=1; #10; 
        $display("-------------------");
        S[1]=1; S[0]=1;I2=1'bx; #10; 
        S[1]=1; S[0]=1;I3=1'bx; #10; 
        S[1]=1'bx; S[0]=1; #10; 
        S[1]=1'bx; S[0]=1'bz; #10; 
        S[1]=1'b1; S[0]=1'bz; #10; 
        #10 $display("-------------------");
            $finish;
    end


endmodule

