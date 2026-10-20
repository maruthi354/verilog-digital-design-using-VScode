`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2026 03:31:04 PM
// Design Name: 
// Module Name: SPI_Transmitter
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


module SPI_Transmitter(
    input logic sclk,
    input logic cs,
    input logic tx_state,
    input logic [7:0] tx_data,
    
    output logic miso
    );
    
    logic [7:0] shift_reg;
    logic [2:0] bit_count;
    
    always_ff @(negedge sclk , posedge cs) begin
        if(cs) begin
            shift_reg<=8'd0;
            bit_count<=3'd0;
            miso<=1'b0;
        end
        else if(tx_state) begin
           miso<=tx_data[7];
           shift_reg<={tx_data[6:0],1'b0};
           bit_count<=1'b1; 
        end
        else begin
            miso<=tx_data[7];
            shift_reg<={shift_reg[6:0],1'b0};
           
            if(bit_count!=8'd7) begin
                bit_count<=bit_count+3'd1;
            end
        end
    end
    
endmodule
