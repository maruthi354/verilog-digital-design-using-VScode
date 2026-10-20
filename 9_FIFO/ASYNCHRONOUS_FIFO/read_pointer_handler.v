
module rd_handler #(parameter DEPTH_LOG = 3) (
    input r_clk,
    input r_en,
    input rrst_n,
    input [DEPTH_LOG:0] g_wptr_sync,
    output reg Empty,
    output reg [DEPTH_LOG:0] g_rptr,
    output reg [DEPTH_LOG:0] b_rptr
);

    wire [DEPTH_LOG:0] g_rptr_next;
    wire [DEPTH_LOG:0] b_rptr_next;
    wire rempty;

    always @(posedge r_clk , negedge rrst_n) begin
        if(!rrst_n) begin
            Empty<=1'b0;
            g_rptr<=0;
            b_rptr<=0;
        end
        else begin
            Empty<=rempty;
            g_rptr<=g_rptr_next;
            b_rptr<=b_rptr_next;
        end
    end

    assign rempty = (g_wptr_sync == g_rptr_next);
    assign b_rptr_next = b_rptr+(r_en && ~Empty);
    assign g_rptr_next = (b_rptr_next>>1)^b_rptr_next;

endmodule