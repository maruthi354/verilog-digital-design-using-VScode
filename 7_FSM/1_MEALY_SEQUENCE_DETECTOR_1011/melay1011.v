module SD1011(out,in,clk,reset);

    input in,clk,reset;
    output reg out;
    
    reg [1:0] state;
    parameter s0 = 2'd0, s1 = 2'd1 , s2 = 2'd2 ,  s3 = 2'd3;

    always @(posedge clk ) begin
        if(reset) begin
            state<=s0;
        end
        else begin
          case (state)
            s0:begin
                state<=in?s1:s0;
            end 
            s1: begin
              state<=in?s1:s2;
            end
            s2: begin
              state<=in?s3:s0;
            end
            s3: begin
              state<=in?s1:s2;
            end
            default:begin
              state<=s0;
            end 
          endcase
        end
    end

    always @(*) begin
      case(state)
        s3:out=in;
        default:out=1'b0;
      endcase
    end
endmodule