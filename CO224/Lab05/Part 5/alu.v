/*
    CO 224 : Lab 05 Part5
    ALU module
    E/16/069
*/

`include "log_right_shift.v"
`include "rotate_right.v"
`include "arith_right_shift.v"


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


    // sensitive to changes of data1, data2 & select operands
    always @(DATA1, DATA2, SELECT)
    begin
        // select aluOperation
        case(SELECT)
            3'b000: #1 RESULT = DATA2 ;            // loadi, mov
                
            3'b001: #2 RESULT = DATA1 + DATA2 ;    // Addition
                 
            3'b010: #1 RESULT = DATA1 & DATA2 ;    // AND
                
            3'b011: #1 RESULT = DATA1 | DATA2 ;    // OR

            3'b100: #2 RESULT = DATA1 * DATA2;     // multipication
                
            3'b101: #2 RESULT = l_shifted;              // srl : logical shift right

            3'b110: #2 RESULT = ar_shifted;           // sra : arithmetic right shift

            3'b111: #2 RESULT = rotated;              // ror : rotate right
                
            default:  RESULT = 8'bxxxxxxxx ;       // unusesd bit combinations
                                
        endcase
    end

    
endmodule


