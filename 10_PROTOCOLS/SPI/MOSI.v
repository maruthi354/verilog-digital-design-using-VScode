
module MOSI(
    input clk,
    input reset,
    input start,
    input miso,
    input [7:0] tx_data,

    output reg [7:0] rx_data,
    output reg s_clk,
    output reg mosi,
    output reg done,
    output reg ss_n,
    output reg busy
);

    parameter IDLE = 2'b00, DATA = 2'b01, FINISH = 2'b10;
    parameter CLK_DIV = 4; 

    reg [1:0] state;
    reg [7:0] tx_shift;
    reg [3:0] bit_count;
    reg [31:0] clock_count;

    always @(posedge clk) begin
        if(reset) begin
            state<=IDLE;
            tx_shift<=8'd0;
            bit_count<=4'd0;
            clock_count<=32'd0;
            rx_data<=8'd0;
            s_clk<=1'b0;
            mosi<=1'b0;
            done<=1'b0;
            ss_n<=1'b1;
            busy<=1'b0;
        end
        else begin
            
            case(state)

                IDLE:begin
                    done<=1'b0;
                    s_clk<=1'b0;
                    bit_count<=4'd0;
                    clock_count<=32'd0;
                    ss_n<=1'b1;
                    busy<=1'b0;
                    if(start) begin
                        state<=DATA;
                        tx_shift<=tx_data;
                        mosi<=tx_data[7];
                        busy<=1'b1;
                        ss_n<=1'b0;
                    end

                end

                DATA:begin
                    if(clock_count==CLK_DIV-1)begin
                        clock_count<=32'd0;
                        if(!s_clk)begin
                            s_clk<=1'b1;
                            rx_data<={rx_data[6:0],miso};
                            if(bit_count==4'd7) begin
                                state<=FINISH;
                            end
                            else begin
                                bit_count<=bit_count+4'd1;
                            end
                        end
                        else begin
                            s_clk<=1'b0;
                            tx_shift<={tx_shift,1'b0};
                            mosi<=tx_shift[6];
                        end
                    end
                    else begin
                        bit_count<=bit_count+32'd1;
                    end
                end

                FINISH:begin
                    state<=IDLE;
                    ss_n<=1'b1;
                    done<=1'b1;
                    busy<=1'b0;
                    s_clk<=1'b0;
                end

                default:state<=IDLE;

            endcase
        
        end
    end

endmodule