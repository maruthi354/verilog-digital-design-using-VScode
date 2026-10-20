
`include "FIFO.v"
`include "FF.v"
`include "read_pointer_handler.v"
`include "write_pointer_handler.v"

module Async_FIFO #(parameter WIDTH=32, DEPTH = 8) (
    input [WIDTH-1:0] data_in,
    input w_en,
    input w_clk,
    input wrst_n,

    input r_en,
    input r_clk,
    input rrst_n,
    
    output [WIDTH-1:0] data_out,
    output Full,
    output Empty
);
    
    parameter DEPTH_LOG =$clog2(DEPTH);

    wire [DEPTH_LOG:0] b_wptr;
    wire [DEPTH_LOG:0] g_wptr;

    wire [DEPTH_LOG:0] b_rptr;
    wire [DEPTH_LOG:0] g_rptr;

    wire [DEPTH_LOG:0] g_wptr_sync;
    wire [DEPTH_LOG:0] g_rptr_sync;

    wr_handler #(
        .DEPTH_LOG(DEPTH_LOG)
    ) WRITE_HANDLER (
        .wclk(w_clk),
        .wrst_n(wrst_n),
        .w_en(w_en),
        .g_rptr_sync(g_rptr_sync),

        .g_wptr(g_wptr),
        .b_wptr(b_wptr),
        .Full(Full)
    );

    rd_handler #(
        .DEPTH_LOG(DEPTH_LOG)
    ) READ_HANDLER (
        .r_clk(r_clk),
        .r_en(r_en),
        .rrst_n(rrst_n),
        .g_wptr_sync(g_wptr_sync),

        .Empty(Empty),
        .g_rptr(g_rptr),
        .b_rptr(b_rptr)
    );

    FF #(
        .DEPTH_LOG(DEPTH_LOG)
    ) SYNC_RPTR (
        .in(g_rptr),
        .clk(w_clk),
        .rst_n(wrst_n),
        .sync_in(g_rptr_sync)
    );

    FF #(
        .DEPTH_LOG(DEPTH_LOG)
    ) SYNC_WPTR (
        .in(g_wptr),
        .clk(r_clk),
        .rst_n(rrst_n),
        .sync_in(g_wptr_sync)
    );

    FIFO #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH),
        .DEPTH_LOG(DEPTH_LOG)
    ) FIFO_MEMORY (
        .data_in(data_in),
        .w_en(w_en),
        .wclk(w_clk),
        .Full(Full),

        .r_en(r_en),
        .r_clk(r_clk),
        .Empty(Empty),

        .b_wptr(b_wptr),
        .b_rptr(b_rptr),

        .data_out(data_out)
    );

endmodule