/*
    CO 224 : Lab 06
    ALU module
    E/16/069
*/

`include "log_right_shift.v"
`include "rotate_right.v"
`include "arith_right_shift.v"
`timescale 1ns/100ps

module alu(DATA1, DATA2, RESULT, ZeroFlag, SELECT);

    // port declaration
    input [7:0] DATA1, DATA2;
    input [2:0] SELECT;
    output reg [7:0] RESULT;
    output ZeroFlag;
   
    assign ZeroFlag = ~|RESULT;   

    wire [7:0] l_shifted;
    wire [7:0] ar_shifted, rotated;

    log_right_shift myRshift(DATA1, DATA2, l_shifted);
    arith_right_shift arithshift(DATA1, DATA2, ar_shifted);
    rotate_right myRotate(DATA1, DATA2, rotated);


    // alu results
    wire [7:0] add_res,and_res, or_res, mul_res, forward_res, shft_res, arShft_res, ror_res;

    assign #2 add_res = DATA1 + DATA2; // addition
    assign #1 and_res = DATA1 & DATA2; // and
    assign #1 or_res = DATA1 | DATA2 ; // or
    assign #2 mul_res = DATA1 * DATA2; // multiplication
    assign #1 forward_res = DATA2;  // loadi, mov
    assign #2 shft_res = l_shifted; // logical shift
    assign #2 arShft_res = ar_shifted; // arithmetic shift
    assign #2 ror_res = rotated; // rotate

    always @(*)
    begin
        // select aluOperation
        case(SELECT)
            3'b000: RESULT = forward_res ;  // loadi, mov
                
            3'b001: RESULT = add_res ;    // Addition
                 
            3'b010: RESULT = and_res ;    // AND
                
            3'b011: RESULT = or_res ;    // OR

            3'b100: RESULT = mul_res;     // multipication
                
            3'b101: RESULT = shft_res;    // srl : logical shift right

            3'b110: RESULT = arShft_res;   // sra : arithmetic right shift

            3'b111: RESULT = ror_res;      // ror : rotate right
                
            default:  RESULT = 8'bxxxxxxxx ;  // unusesd bit combinations
                                
        endcase
    end
    


    
endmodule


