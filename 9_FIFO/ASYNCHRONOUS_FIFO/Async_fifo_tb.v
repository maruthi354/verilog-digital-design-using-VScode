`timescale 1ns/1ps

`include "ASYNC_FIFO.v"

module Async_FIFO_tb;

parameter WIDTH = 32;
parameter DEPTH = 8;

reg [WIDTH-1:0] data_in;
reg w_en;
reg w_clk;
reg wrst_n;

reg r_en;
reg r_clk;
reg rrst_n;

wire [WIDTH-1:0] data_out;
wire Full;
wire Empty;

integer i;
integer errors;

reg [WIDTH-1:0] expected [0:DEPTH-1];
integer wr_count;
integer rd_count;

Async_FIFO #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
) DUT (
    .data_in(data_in),
    .w_en(w_en),
    .w_clk(w_clk),
    .wrst_n(wrst_n),
    .r_en(r_en),
    .r_clk(r_clk),
    .rrst_n(rrst_n),
    .data_out(data_out),
    .Full(Full),
    .Empty(Empty)
);

initial begin
    w_clk = 0;
end

initial begin
    $dumpfile("async_fifo_w.vcd");
    $dumpvars(0,Async_FIFO_tb);
end

always #5 w_clk = ~w_clk;

initial begin
    r_clk = 0;
end

always #7 r_clk = ~r_clk;

task reset_fifo;
begin
    wrst_n = 0;
    rrst_n = 0;
    w_en = 0;
    r_en = 0;
    data_in = 0;

    repeat(3) @(posedge w_clk);
    repeat(3) @(posedge r_clk);

    wrst_n = 1;
    rrst_n = 1;

    repeat(3) @(posedge w_clk);
    repeat(3) @(posedge r_clk);

    $display("[%0t] RESET DONE", $time);
end
endtask

task write_fifo;
input [WIDTH-1:0] data;
begin
    @(negedge w_clk);

    if (!Full) begin
        w_en = 1;
        data_in = data;

        @(posedge w_clk);

        $display("[%0t] WRITE : %0d", $time, data);

        @(negedge w_clk);
        w_en = 0;
    end
    else begin
        $display("[%0t] WRITE BLOCKED : FIFO FULL", $time);
    end
end
endtask

task read_fifo;
begin
    @(negedge r_clk);

    if (!Empty) begin
        r_en = 1;

        @(posedge r_clk);
        #1;

        $display("[%0t] READ  : %0d", $time, data_out);

        @(negedge r_clk);
        r_en = 0;
    end
    else begin
        $display("[%0t] READ BLOCKED : FIFO EMPTY", $time);
    end
end
endtask

task write_check;
input [WIDTH-1:0] data;
begin
    @(negedge w_clk);

    if (!Full) begin
        w_en = 1;
        data_in = data;

        @(posedge w_clk);

        expected[wr_count] = data;
        wr_count = wr_count + 1;

        $display("[%0t] WRITE : %0d", $time, data);

        @(negedge w_clk);
        w_en = 0;
    end
end
endtask

task read_check;
begin
    @(negedge r_clk);

    if (!Empty) begin
        r_en = 1;

        @(posedge r_clk);
        #1;

        if (data_out !== expected[rd_count]) begin
            $display("[%0t] ERROR: Expected=%0d Got=%0d",
                     $time, expected[rd_count], data_out);
            errors = errors + 1;
        end
        else begin
            $display("[%0t] PASS : Expected=%0d Got=%0d",
                     $time, expected[rd_count], data_out);
        end

        rd_count = rd_count + 1;

        @(negedge r_clk);
        r_en = 0;
    end
end
endtask

initial begin

    errors = 0;
    wr_count = 0;
    rd_count = 0;

    reset_fifo;

    $display("\n----------- TEST 1: BASIC -----------");

    write_fifo(10);
    write_fifo(20);
    write_fifo(30);

    read_fifo;
    read_fifo;
    read_fifo;

    repeat(3) @(posedge r_clk);

    if (Empty)
        $display("TEST 1 PASS: FIFO EMPTY");
    else begin
        $display("TEST 1 FAIL: FIFO NOT EMPTY");
        errors = errors + 1;
    end


    reset_fifo;

    $display("\n----------- TEST 2: FIFO FULL -----------");

    for (i = 0; i < DEPTH; i = i + 1)
        write_fifo(i + 100);

    repeat(3) @(posedge w_clk);

    if (Full)
        $display("TEST 2 PASS: FIFO FULL");
    else begin
        $display("TEST 2 FAIL: FIFO NOT FULL");
        errors = errors + 1;
    end


    $display("\n----------- TEST 3: WRITE WHEN FULL -----------");

    write_fifo(999);

    if (Full)
        $display("TEST 3 PASS: WRITE BLOCKED");
    else begin
        $display("TEST 3 FAIL");
        errors = errors + 1;
    end


    $display("\n----------- TEST 4: READ ALL DATA -----------");

    for (i = 0; i < DEPTH; i = i + 1)
        read_fifo;

    repeat(3) @(posedge r_clk);

    if (Empty)
        $display("TEST 4 PASS: FIFO EMPTY");
    else begin
        $display("TEST 4 FAIL: FIFO NOT EMPTY");
        errors = errors + 1;
    end


    $display("\n----------- TEST 5: READ WHEN EMPTY -----------");

    read_fifo;

    if (Empty)
        $display("TEST 5 PASS: READ BLOCKED");
    else begin
        $display("TEST 5 FAIL");
        errors = errors + 1;
    end


    reset_fifo;

    $display("\n----------- TEST 6: FIFO ORDER -----------");

    wr_count = 0;
    rd_count = 0;

    for (i = 0; i < DEPTH; i = i + 1)
        write_check(i * 10);

    repeat(5) @(posedge r_clk);

    for (i = 0; i < DEPTH; i = i + 1)
        read_check;

    if (errors == 0)
        $display("TEST 6 PASS: FIFO ORDER CORRECT");


    reset_fifo;

    $display("\n----------- TEST 7: PARTIAL FIFO -----------");

    write_fifo(111);
    write_fifo(222);
    write_fifo(333);
    write_fifo(444);

    read_fifo;
    read_fifo;

    write_fifo(555);
    write_fifo(666);

    read_fifo;
    read_fifo;
    read_fifo;
    read_fifo;

    repeat(3) @(posedge r_clk);

    if (Empty)
        $display("TEST 7 PASS");
    else begin
        $display("TEST 7 FAIL");
        errors = errors + 1;
    end


    reset_fifo;

    $display("\n----------- TEST 8: SIMULTANEOUS READ/WRITE -----------");

    write_fifo(100);
    write_fifo(200);
    write_fifo(300);

    fork
        begin
            for (i = 0; i < 5; i = i + 1)
                write_fifo(i + 1000);
        end

        begin
            repeat(5)
                read_fifo;
        end
    join

    #100;

    $display("\n---------------------------------");
    $display("SIMULATION COMPLETED");
    $display("ERROR COUNT = %0d", errors);

    if (errors == 0)
        $display("***** ALL TESTS PASSED *****");
    else
        $display("***** TESTS FAILED *****");

    $display("--------------------------------------");

    #20;
    $finish;

end

endmodule