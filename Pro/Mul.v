module mul(out,car,in1,in2);

    input[3:0] in1,in2;
    output reg [4:0] out, car;

    reg[4:0] sum,in;

    always @(*) begin
        sum=0;
        in=in2;
        while (in>0) begin
            sum=in1+sum;
            in=in-1;
        end
        out=sum;
    end

endmodule