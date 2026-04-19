module Demux_1X2(Y1,Y0,I,S);

    input I,S;
    output Y1,Y0;

    wire S_n;

    not n(S_n,S);

    and D0(Y0,I,S_n);
    and D0(Y1,I,S);

endmodule