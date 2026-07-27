
module siso(Serail_out, Serial_in, clk, reset);

    input Serial_in,clk,reset;
    output Serail_out;

    reg [3:0] shift;
    
    assign Serail_out=shift[0];

    always @(posedge clk or posedge reset) begin
        if(reset) 
            shift<=4'b0000;
        else
            shift<={Serial_in,shift[3:1]};
        
    end

    
endmodule