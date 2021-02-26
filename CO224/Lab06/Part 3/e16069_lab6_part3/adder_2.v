/*
    CO 224 : Lab 06
    adder module with #2 time unit latency 
    E/16/069
*/
`timescale 1ns/100ps
module adder_2(DATA1, DATA2, RESULT);
    
    input [31:0] DATA1,DATA2;
    output reg [31:0] RESULT;

    always @(DATA1,DATA2)
    begin
        #2 RESULT = DATA1 + DATA2;
    end

endmodule
