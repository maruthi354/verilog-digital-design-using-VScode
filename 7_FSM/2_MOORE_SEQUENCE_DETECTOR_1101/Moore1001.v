module SD1001(out,in,clk,reset);
    
    input in,clk,reset;
    output reg out;

    reg[2:0] state;
    parameter s0 = 0 , s1 = 1 , s2 = 2 , s3 = 3 ,s4 = 4;

    always @(posedge clk ) begin
        if(reset) 
            state<=s0;
        else begin
            case (state)
                s0:state=in?s1:s0;
                s1:state=in?s1:s2;
                s2:state=in?s1:s3;
                s3:state=in?s4:s0;
                s4:state=in?s1:s2; 
                default: state<=s0;
            endcase
        end
    end
    always @(state) begin
        case (state)
            s4:out<=1; 
            default: out<=0;
        endcase
    end

endmodule