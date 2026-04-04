`include "OR_Gate.v"
module OR_Tb;

    reg A, B;
    wire F;
    integer i,j;
    reg [3:0] val;

    OR_Gate DUT(F, A, B);

    initial begin

        val[0]=1'b0;
        val[1]=1'b1;
        val[2]=1'bx;
        val[3]=1'bz;

        $display(" OR |  0   1   x   z");
        $display("--------------------");

        for(i=0;i<4;i=i+1) begin
            A=val[i];
            $write(" %b  | ",A);
            for(j=0;j<4;j=j+1) begin
                B=val[j];
                #1 $write(" %b  ",F);
            end
            $write("\n");
        end


    end

endmodule