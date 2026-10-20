`include "Receiver.v"
`include "Baud_Rate_Generator.v"
`include "Transmittor.v"

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 11:50:05 AM
// Design Name: 
// Module Name: UART
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART (
    input clk,
    input rst,
    input wr_enb,
    input rdy_clr,
    input [7:0] data_in,
    output ready,
    output busy,
    output [7:0] data_out
);

    wire rx_clk_enb;
    wire tx_clk_enb;
    wire tx_temp;

    Baud_Rate_Generator bg (
        .clk  (clk),
        .reset  (rst),
        .enb_rx (rx_clk_enb),
        .enb_tx (tx_clk_enb)
    );

    Transmitter ts (
        .clk     (clk),
        .reset   (rst),
        .wr_enb  (wr_enb),
        .enb     (tx_clk_enb),
        .data_in (data_in),
        .tx      (tx_temp),
        .tx_busy (busy)
    );

    Receiver rc (
        .clk     (clk),
        .reset   (rst),
        .rdy_clr (rdy_clr),
        .clk_enb (rx_clk_enb),
        .rx      (tx_temp),
        .ready   (ready),
        .data_out(data_out)
    );

endmodule
