

module wr_handler #(parameter DEPTH_LOG = 3) (
    input wclk,
    input wrst_n,
    input w_en,
    input [DEPTH_LOG:0] g_rptr_sync,
    output reg [DEPTH_LOG:0] g_wptr,
    output reg [DEPTH_LOG:0] b_wptr,
    output reg Full
);

    wire [DEPTH_LOG:0] b_wptr_next;
    wire [DEPTH_LOG:0] g_wptr_next;
    wire wfull;

    always @(posedge wclk , negedge wrst_n) begin
        if(!wrst_n) begin
            b_wptr<=0;
            g_wptr<=0;
            Full<=1'b0;
        end
        else begin
            b_wptr<=b_wptr_next;
            g_wptr<=g_wptr_next;
            Full<=wfull;
        end
    end

    assign b_wptr_next = b_wptr+(w_en & ~Full);
    assign g_wptr_next = (b_wptr_next>>1)^b_wptr_next;
    assign wfull = (g_wptr_next == {~g_rptr_sync[DEPTH_LOG:DEPTH_LOG-1],g_rptr_sync[DEPTH_LOG-2:0]});

    
endmodule