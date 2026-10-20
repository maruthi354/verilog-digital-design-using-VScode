`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 11:21:07 AM
// Design Name: 
// Module Name: Receiver
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

module Receiver (
    input clk,
    input reset,
    input rdy_clr,
    input clk_enb,
    input rx,
    output reg ready,
    output reg [7:0] data_out
);

    parameter START = 2'b00,
              DATA  = 2'b01,
              STOP  = 2'b10;

    reg [1:0] state;
    reg [3:0] bit_pos;
    reg [7:0] data;
    reg [3:0] sample;

    always @(posedge clk) begin
        if (reset) begin
            state    <= START;
            data     <= 8'd0;
            data_out <= 8'd0;
            ready    <= 1'b0;
            bit_pos  <= 4'd0;
            sample   <= 4'd0;
        end
        else begin

            if (rdy_clr)
                ready <= 1'b0;

            if (clk_enb) begin
                case (state)

                    START: begin
                        if (sample == 4'd0 && rx == 1'b0) begin
                            sample <= 4'd1;
                        end
                        else if (sample != 4'd0) begin
                            if (sample == 4'd8) begin
                                if (!rx) begin
                                    state   <= DATA;
                                    sample  <= 4'd0;
                                    bit_pos <= 4'd0;
                                    data    <= 8'd0;
                                end
                                else begin
                                    state  <= START;
                                    sample <= 4'd0;
                                end
                            end
                            else begin
                                sample <= sample + 1'b1;
                            end
                        end
                    end

                    DATA: begin
                        if( sample == 4'd8 ) begin
                            data[bit_pos]<=rx;
                        end
                        if (sample == 4'd15) begin
                            sample <= 4'd0;

                            if (bit_pos == 4'd7)
                                state <= STOP;
                            else
                                bit_pos <= bit_pos + 1'b1;
                        end
                        else begin
                            sample <= sample + 1'b1;
                        end
                    end

                    STOP: begin
                        if (sample == 4'd15) begin
                            sample <= 4'd0;
                            state  <= START;

                            if (rx) begin
                                data_out <= data;
                                ready    <= 1'b1;
                            end
                        end
                        else begin
                            sample <= sample + 1'b1;
                        end
                    end

                    default: begin
                        state  <= START;
                        sample <= 4'd0;
                    end

                endcase
            end
        end
    end

endmodule
