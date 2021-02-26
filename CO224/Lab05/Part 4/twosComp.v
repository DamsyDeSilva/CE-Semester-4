/*
    CO 224 : Lab 05 Part3
    Two's Complement module
    E/16/069
*/


module twosComp(Out, In);

    input [7:0] In;
    output reg [7:0] Out;

    always @(In)
    begin
        Out = ~In + 1'b1;
    end


endmodule

