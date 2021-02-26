/*
    CO 224 : Lab 06
    sign extend ; module
    E/16/069
*/
`timescale 1ns/100ps
module sign_extend(IN, OUT);

    // port declaration
    input [7:0] IN;
    output reg [31:0] OUT;

    always @(IN)
    begin
        OUT[7:0] = IN[7:0];
        OUT[31:8] = {24{IN[7]}}; 
    end

endmodule