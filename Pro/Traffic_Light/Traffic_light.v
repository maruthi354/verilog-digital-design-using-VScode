
module trafic_kight(light,clk,reset);

    input reset,clk;
    output reg [2:0] light;

    reg[1:0] state;
    parameter s0 = 0 ; s1 = 1 ; s2 = 2;
    parameter red = 3'b100 , yellow = 3'b010 , green = 3'b001 ;

    always @(posedge clk or posedge reset) begin
        if(reset) light<=red;
        else begin
            case (state)
                s0: state<=s1;
                s1:
                default: 
            endcase
        end
    end

endmodule