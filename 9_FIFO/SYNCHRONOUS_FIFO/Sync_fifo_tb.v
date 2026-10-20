`timescale 1ns/1ns
`include "Sync_fifo.v"

module Sync_fifo_tb;

    parameter FIF0_DEPTH = 8;
    parameter DATA_WIDTH = 32;

    reg clk;
    reg rst_n;
    reg cs;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;
    wire Full;
    wire Empty;

    Sync_fifo #(
        .FIF0_DEPTH(FIF0_DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) DUT (
        .clk(clk),
        .rst_n(rst_n),
        .cs(cs),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .Full(Full),
        .Empty(Empty)
    );
    initial clk = 0;
    always #5 clk = ~clk;

    integer i;

    task write_data;
        input [DATA_WIDTH-1:0] d_in;
        begin
            @(negedge clk);

            cs     = 1;
            wr_en  = 1;
            rd_en  = 0;
            data_in = d_in;

            @(posedge clk);

            if (Full)
                $display("WRITE BLOCKED: FIFO FULL");
            else
                $display("[%0t] WRITE: data = %0d", $time, d_in);

            @(negedge clk);

            wr_en = 0;
            cs    = 0;
        end
    endtask


    task read_data;
        begin
            @(negedge clk);

            cs    = 1;
            wr_en = 0;
            rd_en = 1;

            @(posedge clk);
            #1;

            if (Empty)
                $display("READ BLOCKED: FIFO EMPTY");
            else
                $display("[%0t] READ: data = %0d", $time, data_out);

            @(negedge clk);

            rd_en = 0;
            cs    = 0;
        end
    endtask


    initial begin

        // Initial values
        rst_n  = 0;
        cs     = 0;
        wr_en  = 0;
        rd_en  = 0;
        data_in = 0;

        // Reset
        #12;
        rst_n = 1;


        $display("-------------------------------");
        $display("SCENARIO 1: BASIC READ/WRITE");
        $display("-------------------------------");

        write_data(1);
        write_data(10);
        write_data(100);

        read_data();
        read_data();
        read_data();



        $display("-------------------------------");
        $display("SCENARIO 2: FIFO FULL TEST");
        $display("-------------------------------");

        for(i = 0; i < FIF0_DEPTH; i = i + 1) begin
            write_data(i*i);
        end

        #1;

        if (Full)
            $display("PASS: FIFO FULL flag asserted");
        else
            $display("FAIL: FIFO FULL flag not asserted");


        // Extra write
        write_data(999);



        $display("-------------------------------");
        $display("SCENARIO 3: FIFO EMPTY TEST");
        $display("-------------------------------");

        for(i = 0; i < FIF0_DEPTH; i = i + 1) begin
            read_data();
        end

        #1;

        if (Empty)
            $display("PASS: FIFO EMPTY flag asserted");
        else
            $display("FAIL: FIFO EMPTY flag not asserted");


        // Extra read
        read_data();



        $display("-------------------------------");
        $display("SIMULATION COMPLETED");
        $display("-------------------------------");

        #20;
        $finish;

    end

endmodule