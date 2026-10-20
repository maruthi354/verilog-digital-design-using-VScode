`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 12:28:10 AM
// Design Name: 
// Module Name: Transmitter
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

module Transmitter(
    input clk,
    input reset,
    input wr_enb,
    input enb,
    input [7:0] data_in,
    output reg tx,
    output tx_busy
);

    parameter IDLE = 0, START = 1 , DATA = 2 , STOP = 3;
    
    reg [7:0] data;
    reg [2:0] bit_pos;
    reg [1:0] state=IDLE;
    
    always @(posedge clk) begin
        
        if(reset)begin 
            tx<=1'b1;
            state<=IDLE;
            data<=8'd0;
            bit_pos<=3'd0;
        end
        else begin
            case (state) 
                
                IDLE:begin
                    if(wr_enb) begin
                        state<=START;
                        bit_pos<=3'd0;
                        data<=data_in;
                    end
                end
                
                START:begin
                    if(enb) begin
                        state<=DATA;
                        tx<=1'b0;
                    end
                end
                
                DATA:begin
                    if(enb) begin
                        if(bit_pos==3'd7)
                            state<=STOP;
                        else 
                            bit_pos<=bit_pos+3'd1;
                        tx<=data[bit_pos];
                    end
                end
                
                STOP:begin
                    if(enb)begin
                        state<=IDLE;
                        tx<=1'b1;
                    end
                end
                
                default:begin
                    tx<=1'b1;
                    state<=IDLE;
                end
                
            endcase
        end
    end

    assign tx_busy = (state!=IDLE);

endmodule
