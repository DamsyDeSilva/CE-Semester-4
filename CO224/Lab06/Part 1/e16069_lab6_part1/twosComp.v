/*
    CO 224 : Lab 06
    Two's Complement module
    E/16/069
*/


module twosComp(Out, In);

    input [7:0] In;
    output reg [7:0] Out;

    always @(In)
    begin
        #1 Out = ~In + 1'b1;
    end


endmodule

