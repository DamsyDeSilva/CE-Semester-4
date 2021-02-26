/*
    CO 224 : Lab 05 Part3
    adder module 
    E/16/069
*/

module adder(DATA1, DATA2, RESULT);
    
    input [31:0] DATA1,DATA2;
    output reg [31:0] RESULT;

    always @(DATA1,DATA2)
    begin
        #2 RESULT = DATA1 + DATA2;
    end

endmodule