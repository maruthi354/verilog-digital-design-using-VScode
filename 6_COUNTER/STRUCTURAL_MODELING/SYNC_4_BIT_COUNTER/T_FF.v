
module  t_ff(D,T,clk,reset);
    
    input clk,reset,T;
    output reg D;

    always @(posedge clk or posedge reset) begin
        if(reset)
            D<=0;
        else if(T)
            D<=~D;
        else
            D<=D;
    end

endmodule