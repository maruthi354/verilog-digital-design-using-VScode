`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2026 11:20:06 PM
// Design Name: 
// Module Name: SPI_Slave
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


module SPI_Slave(

    input logic clk,
    input logic rst_n,
    
    input logic sclk,
    input logic cs,
    input logic mosi,
    
    output logic miso
    );
    
    logic [7:0] shift_reg;
    logic [7:0] rx_byte;
    logic [2:0] bit_count;
    logic       rx_valid;
    
    //      SPI_byte_receiver
    
    always @(posedge sclk , posedge cs) begin
        if(cs) begin
            rx_byte<=8'd0;
            shift_reg<=8'd0;
            bit_count<=3'd0;
            rx_valid<=1'd0;
        end
        else begin
            rx_valid<=1'd0;
            shift_reg<={shift_reg[6:0],mosi};
            if(bit_count==3'd7) begin
                rx_byte<={shift_reg[6:0],mosi};
                bit_count<=3'd0;
                rx_valid<=1'b1;
            end
            else begin
                bit_count<=bit_count+3'd1;
            end
        end
    end
    
    //      SPI_FSM
    
    typedef enum logic [2:0]{
        CMD,
        ADDRESS,
        DATA,
        WRITE,
        READ
    }state_t;
    
    state_t state;
    
    logic [7:0] command;
    logic [7:0] address;
    logic [31:0] data;
    logic [1:0] data_count;
    
    always_ff @(posedge sclk , posedge cs) begin
        if(cs) begin
            state<=CMD;
            command<=8'd0;
            address<=8'd0;
            data<=32'd0;
            data_count<=2'd0;
        end
        else begin
            if(rx_valid) begin
                case(state)
                    CMD:begin
                        command<=rx_byte;
                        state<=ADDRESS;
                    end
                    ADDRESS:begin
                        address<=rx_byte;
                        if(command==8'd1)begin
                            data_count<=2'd0;
                            state<=DATA;
                        end
                        else if(command==8'd2) begin
                            state<=READ;
                        end
                        else
                            state<=CMD;
                    end
                    DATA:begin
                        case(data_count)
                            2'd0:begin
                                data[31:24]<=rx_byte;
                                data_count<=2'd1;
                            end
                            2'd1:begin
                                data[23:16]<=rx_byte;
                                data_count<=2'd2;
                            end
                            2'd2:begin
                                data[15:8]<=rx_byte;
                                data_count<=2'd3;
                            end
                            2'd3:begin
                                data[7:0]<=rx_byte;
                                state<=WRITE;
                            end
                        endcase
                    end
                    WRITE:begin
                        state<=CMD;
                    end
                    READ:begin
                        state<=CMD;
                    end
                endcase
            end
        end
    end
    
    //      REGISTER_BANK
    
    logic [31:0] control_reg;
    logic [31:0] status_reg;
    logic [31:0] config_reg;
    logic [31:0] counter_reg;
    logic [31:0] error_count_reg;
    
    logic wr_en;
    assign wr_en = (state == WRITE);
    
    always_ff @(posedge clk , posedge cs)begin
        if(cs)begin
            control_reg<=32'd0;
            status_reg<=32'd0;
            config_reg<=32'd0;
            counter_reg<=32'd0;
            error_count_reg<=32'd0;
        end
        else begin
            if(wr_en) begin
                case(address)
                    8'h00:control_reg<=data;
                    8'h04:status_reg<=data;
                    8'h08:config_reg<=data;
                    8'h0c:counter_reg<=data;
                    8'h10:error_count_reg<=data;
                    default:error_count_reg<=error_count_reg+1'd1;
                endcase
            end
        end
    end
    
    //          READ_MULTIPLEXER
    
    logic [31:0] read_data;
    
    always_comb begin
        case(address)
            8'h00:read_data=control_reg;
            8'h04:read_data=status_reg;
            8'h08:read_data=config_reg;
            8'h0c:read_data=counter_reg;
            8'h10:read_data=error_count_reg;
            default:read_data=32'hDEAD_BEEF;
        endcase
    end
    
    //          SPI_TRANSMISSSION
    
    logic [31:0] tx_shift_reg;
    logic [5:0] tx_data_count;
    
    always_ff @(negedge sclk , posedge cs) begin
        if(cs) begin
            tx_shift_reg<=32'd0;
            tx_data_count<=6'd0;
            miso<=1'b0;
        end
        else begin
            if(state==READ && rx_valid) begin
                tx_shift_reg<=read_data;
                tx_data_count<=6'd0;
                miso<=read_data[31];
            end
            else begin
                tx_shift_reg<={tx_shift_reg[30:0],1'b0};
                miso<=tx_shift_reg[30];
                tx_data_count<=tx_data_count+1'b1;
            end
        end
    end
    
endmodule

