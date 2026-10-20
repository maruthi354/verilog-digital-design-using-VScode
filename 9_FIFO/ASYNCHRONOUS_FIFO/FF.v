
module FF #(parameter DEPTH_LOG = 3) (
    input [DEPTH_LOG:0] in,
    input clk,
    input rst_n,
    output reg [DEPTH_LOG:0] sync_in
);

    reg [DEPTH_LOG:0] sync;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sync<=0;
            sync_in<=0;
        end
        else begin
            sync<=in;
            sync_in<=sync;
        end
    end

endmodule