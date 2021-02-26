/*
    CO 224 : Lab 06
    arithmetic shift right module
    E/16/069
*/

`timescale 1ns/100ps
module arith_right_shift(IN,shamt, OUT);

    // port declaration
    input [7:0] IN;         // unshifted
    input  [7:0] shamt;     //shift amount
    output reg [7:0] OUT;   // shifted
    
    
    // since input is 8bits possible shiftamounts are upto 7;
    // more than 7 shifts results first bit of the input; (default)

    always @(IN)
    begin
        case(shamt)
            0: OUT = IN;
            1: OUT = { {1{IN[7]}}, IN[7:1] };
            2: OUT = { {2{IN[7]}}, IN[7:2] };
            3: OUT = { {3{IN[7]}}, IN[7:3] };
            4: OUT = { {4{IN[7]}}, IN[7:4] };
            5: OUT = { {5{IN[7]}}, IN[7:5] };
            6: OUT = { {6{IN[7]}}, IN[7:6] };
            7: OUT = { {7{IN[7]}}, IN[7:7] };
            default: OUT = { 8{IN[7]}};
        endcase
    end
    
endmodule