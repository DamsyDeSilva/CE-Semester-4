/*
    CO 224 : Lab 06
    Register File module
    E/16/069
*/

`timescale 1ns/100ps

module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET, BusyWait);

    // port declaration
    input CLK, WRITE, RESET;
    input [7:0] IN;
    input [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;  
    input BusyWait;  
    output [7:0] OUT1, OUT2;

    // eight 8-bit registers
    reg [7:0] regfile [0:7];
    
    

    // Read Registers
    assign #2 OUT1 = regfile [OUT1ADDRESS];
    assign #2 OUT2 = regfile [OUT2ADDRESS];
    
    // Reset Registers
    integer i; 
    always @(RESET)
    begin
        if(RESET) 
        begin
            #2
            for (i = 0; i < 8; i++) begin
                regfile[i] <= 0;
            end   
        end
      
    end

    // Write to Registers
    always @(posedge CLK)
    begin  
        #1 
        if (WRITE && !RESET && !BusyWait)
        begin
            regfile[INADDRESS] <= IN;
        end
    end
endmodule