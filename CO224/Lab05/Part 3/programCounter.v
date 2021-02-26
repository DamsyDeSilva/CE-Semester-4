/*
    CO 224 : Lab 05 Part3
    Program Counter module
    E/16/069
*/
`include "adder.v"


module programCounter(CLK, RESET, PC);

    input CLK, RESET;
    output reg [31:0] PC; // PC value (output)

    wire [31:0] pc_adder;

    adder myadder(PC,32'd4,pc_adder); 

    always @(posedge CLK)
    begin
        
        if(!RESET)begin
            #1 PC <= pc_adder;
        end    
    end
    always @(posedge RESET)
    begin  
         #1 PC <= 32'b11111111111111111111111111111100;
    end
    
endmodule
