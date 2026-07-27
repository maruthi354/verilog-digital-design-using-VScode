`include "D_Latch.v"

module D_Latch_Tb;

    reg D, En;
    wire Q, Q_bar;

    D_Latch dut(Q,Q_bar,D,En);

    initial begin
        $dumpfile("D_Latch.vcd");
        $dumpvars(0,D_Latch_Tb);
    end

    initial begin
        $display("----------------------");
        $display(" EN | D || Q | Q_bar ");
        $display("----------------------");
        $monitor("  %b | %b || %b | %b ",En,D,Q,Q_bar);


        En=0;
        D=0;#10 D=1;#10 

        En=1;
        D=0;#10 D=1;#10

        En=0;
        D=0;#10 D=1;#10
        $finish;
    end

endmodule