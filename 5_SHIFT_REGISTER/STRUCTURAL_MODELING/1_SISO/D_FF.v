

module d_ff(Q,D,clk,reset);

    input D,clk,reset;
    output reg Q;

    always @(posedge clk ) begin
        if(reset)
            Q<=0;
        else
            Q<=D;
    end

endmodule