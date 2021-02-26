/*
    CO 224 : Lab 05 Part1
    ALU module
    E/16/069
*/

module alu(DATA1, DATA2, RESULT, SELECT);

    // port declaration
    input [7:0] DATA1, DATA2;
    input [2:0] SELECT;
    output reg [7:0] RESULT;

    // sensitive to changes of data1, data2 & select operands
    always @(DATA1, DATA2, SELECT)
    begin
        // select aluOperation
        case(SELECT)
            3'b000:     // loadi, mov
                #1 RESULT = DATA2 ; 
            3'b001:     // Addition
                #2 RESULT = DATA1 + DATA2 ; 
            3'b010:     // AND
                #1 RESULT = DATA1 & DATA2 ; 
            3'b011:     // OR
                #1 RESULT = DATA1 | DATA2 ; 
            default:    // unusesd bit combinations
                RESULT = 8'bxxxxxxxx ;                     
        endcase
    end
    
endmodule


