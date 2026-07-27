
module d_ff(q,q_bar,d,clk,reset);

    input d,clk,reset;
    output reg q;
    output q_bar;

    always @(posedge clk or posedge reset) begin
        if(reset)
            q<=0;
        else
            q<=d;
    end

    assign q_bar=~q;
 
endmodule