
module Sync_fifo #(
    parameter FIF0_DEPTH = 8,
    parameter DATA_WIDTH=32
) 
(
    input cs,
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output Full,
    output Empty
);

    localparam FIF0_DEPTH_log = $clog2(FIF0_DEPTH) ;

    reg [FIF0_DEPTH_log-1:0] write_pointer;
    reg [FIF0_DEPTH_log-1:0] read_pointer;

    reg [DATA_WIDTH-1:0] fifo [0:FIF0_DEPTH-1];

    // Write Operation

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            write_pointer<=0;
        else if(cs && wr_en && !Full) begin
            fifo[write_pointer]<=data_in;
            write_pointer<=write_pointer+1'b1;
        end
    end

    //Read Operation

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            read_pointer<=0;
        else if (cs && rd_en && !Empty) begin
            data_out<=fifo[read_pointer];
            read_pointer<=read_pointer+1'b1;
        end
    end

    assign Empty = (read_pointer==write_pointer);
    assign Full = (write_pointer+1) == read_pointer ;

    
endmodule