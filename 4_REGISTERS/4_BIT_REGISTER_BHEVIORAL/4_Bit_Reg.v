//Simple 4 Bit Register Register with Asynchronous Reset and Enable 
// Behavioral Modeling
// This is a common and practical implementation that uses an asynchronous reset and a synchronous enable signal. 

module fourbit_reg(D,Q,clk,reset);

    input [3:0] Q;
    input clk,reset;
    output reg [3:0] D;

    always @(posedge clk or posedge reset) begin
        if(reset)begin
            D<=4'b0000;
        end
        else begin
            D<=Q;
        end
    end

endmodule