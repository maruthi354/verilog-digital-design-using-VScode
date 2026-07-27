`include "Sr_Latch.v"

module Sr_Latch_Tb;

    reg S, R, En;
    wire Q, Q_bar;

    Sr_Latch dut(Q,Q_bar,S,R,En);

    initial begin
        $dumpfile("Sr_Latch.vcd");
        $dumpvars(0,Sr_Latch_Tb);
    end

    initial begin        
        $display("----------------------");
        $display(" EN | S | R || Q | Q_bar ");
        $display("----------------------");
        $monitor("  %b | %b | %b || %b | %b ",En,S,R,Q,Q_bar);
        En=0;
        S=0;R=0;#10
        En=1;
        S=0;R=0;#10
        S=0;R=1;#10
        S=0;R=0;#10 
        S=1;R=0;#10
        S=0;R=0;#10
        S=1;R=1;#10;
        S=1;R=0;#10
        En=0;
        S=0;R=0;#10
        $finish;


    end

endmodule