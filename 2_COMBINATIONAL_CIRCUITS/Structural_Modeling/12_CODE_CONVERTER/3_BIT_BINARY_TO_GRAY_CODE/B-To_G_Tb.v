`include "B_To_G.v"

module B_To_G_Tb;

    reg [2:0] I; 
    wire [2:0] O;

    B_To_G dut(O,I);

    initial begin
        $dumpfile("B_To_G.vcd");
        $dumpvars(0,B_To_G_Tb);
    end

    initial begin
            
        $display("------------------------------");
        $display(" I2 | I1 | I0 || Y2 | Y1 | Y0");
        $display("------------------------------");

        $monitor("  %b |  %b |  %b ||  %b |  %b | %b ",I[2],I[1],I[0],O[2],O[1],O[0]);

        I=3'b000;#10
        I=3'b001;#10
        I=3'b010;#10
        I=3'b011;#10
        I=3'b100;#10
        I=3'b101;#10
        I=3'b110;#10
        I=3'b111;#10
        $finish;

    end

endmodule