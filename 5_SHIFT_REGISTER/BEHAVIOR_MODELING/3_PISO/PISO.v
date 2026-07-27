
module piso(serial_out,parallel_in,clk,load,reset);

    input clk,load,reset;
    input [3:0] parallel_in;
    output serial_out;

    reg [3:0] shift;

    always @(posedge clk or posedge reset) begin
        if(reset)
            shift<=4'b0000;
        else if (load)
            shift<=parallel_in;
        else
            shift<={1'b0,shift[3:1]};
    end

    assign serial_out=shift[0];

endmodule