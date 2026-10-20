`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2026 11:29:18 PM
// Design Name: 
// Module Name: Baud_Rate_Generator
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


module Baud_Rate_Generator(
    input clk,
    input reset,
    output reg enb_rx,
    output reg enb_tx
);

    parameter REF_CLK_FREQUENCY = 100000000;
    parameter BAUD_RATE = 9600;
    parameter SAMPLING_FACTOR = 16;
    
    parameter DIVISOR_TX = REF_CLK_FREQUENCY/BAUD_RATE;
    parameter DIVISOR_RX = REF_CLK_FREQUENCY/(SAMPLING_FACTOR*BAUD_RATE);
    
    reg [15:0] counter_tx;
    reg [15:0] counter_rx;
    
    
    //TRANSMITTER CLK GENERATOR LOGIC
    
    always @(posedge clk) begin
        if(reset)begin
            enb_tx<=1'b0;
            counter_tx<=16'd0;
        end
        else if(counter_tx==DIVISOR_TX-1)begin
            counter_tx<=16'd0;
            enb_tx<=1'b1;
        end
        else begin
            counter_tx<=counter_tx+16'd1;
            enb_tx<=1'b0;
        end
    end
    
    //RECEIVER CLK GENERATOR LOGIC
    
    always @(posedge clk) begin
        
        if(reset) begin
            counter_rx<=16'd0;
            enb_rx<=1'b0;
        end
        else if(counter_rx==DIVISOR_RX-1) begin
            counter_rx<=16'd0;
            enb_rx<=1'b1;
        end
        else begin
            counter_rx<=counter_rx+16'b1;
            enb_rx<=1'b0;
        end
        
    end

endmodule