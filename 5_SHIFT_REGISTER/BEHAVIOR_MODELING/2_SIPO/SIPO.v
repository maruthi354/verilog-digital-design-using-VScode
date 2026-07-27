
module sipo(parallel_out, serial_in, clk, reset);

    input serial_in, clk, reset;
    output reg [3:0] parallel_out;



    always @(posedge clk or posedge reset) begin
        if(reset)
            parallel_out<={4{1'b0}};
        else
            parallel_out<={serial_in,parallel_out[3:1]};
    end

endmodule