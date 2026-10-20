
module FIFO #(parameter WIDTH = 32, DEPTH=8 , DEPTH_LOG =3) (
    input [WIDTH-1:0] data_in,
    input w_en,
    input wclk,
    input Full,
    input r_en,
    input r_clk,
    input Empty,
    input [DEPTH_LOG:0] b_wptr,
    input [DEPTH_LOG:0] b_rptr,
    output reg [WIDTH-1:0] data_out
);

    reg [WIDTH-1:0] fifo [0:DEPTH-1];

    always @(posedge wclk) begin
        if(!Full && w_en ) begin
            fifo[b_wptr[DEPTH_LOG-1:0]]<=data_in;
        end
    end

    always @(posedge r_clk) begin
        if(!Empty && r_en) begin
            data_out<=fifo[b_rptr[DEPTH_LOG-1:0]]; 
        end
    end
    
endmodule