module Demux_1X2(Y1,Y0,I,S);

    input I,S;
    output Y1,Y0;

    assign Y0 = I & ~S;
    assign Y1 = I & S; 

endmodule