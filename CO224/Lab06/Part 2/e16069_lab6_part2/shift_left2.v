/*
    CO 224 : Lab 06
    shift left by 2; module; written for program counter modifying
    E/16/069
*/
`timescale 1ns/100ps
module shift_left2(IN, shift_OUT);

    // port declaration
    input [31:0] IN;
    output reg [31:0] shift_OUT;

    always@(IN)
    begin
        shift_OUT[1:0] = 2'b00;     // two LSBs of output filled with zeroes
        shift_OUT[31:2] = IN[29:0];  // left shift by 2
    end

endmodule


