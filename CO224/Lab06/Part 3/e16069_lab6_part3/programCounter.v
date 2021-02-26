/*
    CO 224 : Lab 06
    Program Counter module
    E/16/069
*/

`timescale 1ns/100ps

module programCounter(CLK, RESET, busywait, nxt_PC, PC);

    input CLK, RESET, busywait; 
    input [31:0] nxt_PC;
    output reg [31:0] PC; // PC value (output)

    //wire [31:0] pc_adder;

    //adder myadder(PC,32'd4,pc_adder); 

    always @(posedge CLK)
    begin
        #1 
        if(!RESET && !busywait)begin
            PC <= nxt_PC;
        end    
    end
    always @(posedge RESET)
    begin  
        #1 PC <= -32'd4;
    end
    
endmodule
