/*
    CO 224 : Lab 06
    Testbench for cpu module
    E/16/069
*/


`include "cpu.v"
`include "dmem_for_dcache.v"
`include "dcache.v"
`timescale 1ns/100ps
module cpu_testbench;
    
    reg CLK, RESET;
    wire [31:0] PC;
    reg [31:0] INSTRUCTION;

    reg [7:0] Inst_mem[1023:0] ;  // Instruction Memory

    // for connect data_cache and cpu
    wire Busywait;
    wire Read, Write;    
    wire [7:0] Read_Data, Write_Data;
    wire [7:0] Address;

    // for connect data_cache and data_memory
    wire Mem_Busywait;
    wire Mem_Read, Mem_Write;  
    wire [31:0] Mem_ReadData, Mem_WriteData;
    wire [5:0] Mem_Address;

    cpu mycpu(PC, INSTRUCTION, CLK, RESET, Busywait, Read_Data, Write_Data, Write, Read, Address);

    dcache myCache(CLK, RESET, Address, Read, Write, Write_Data, Read_Data, Busywait, Mem_Address, Mem_Read, Mem_Write, Mem_WriteData, Mem_ReadData, Mem_Busywait);

    data_memory myDataMemory(CLK ,RESET, Mem_Read, Mem_Write, Mem_Address, Mem_WriteData, Mem_ReadData, Mem_Busywait);



    initial
    begin
        /*
           loadi 0 0x02
           loadi 1 0x05
           swi 2 0x03
           swd 1 0 
           lwi 3 0x03
           lwd 4 1
           loadi 5 0x21
           swi 5 0x20
           swd 1 5

        */

        {Inst_mem[3],Inst_mem[2],Inst_mem[1],Inst_mem[0]}     <= 32'b00000000000000000000000000000010;  //loadi 0 0x02
        {Inst_mem[7],Inst_mem[6],Inst_mem[5],Inst_mem[4]}     <= 32'b00000000000000010000000000000101;  //loadi 1 0x05
        {Inst_mem[11],Inst_mem[10],Inst_mem[9],Inst_mem[8]}   <= 32'b00010001_000000000000001000000011; //swi 2 0x03
        {Inst_mem[15],Inst_mem[14],Inst_mem[13],Inst_mem[12]} <= 32'b00010000_000000000000000100000000; //swd 1 0
        {Inst_mem[19],Inst_mem[18],Inst_mem[17],Inst_mem[16]} <= 32'b00001111_000000110000000000000011; //lwi 3 0x03
        {Inst_mem[23],Inst_mem[22],Inst_mem[21],Inst_mem[20]} <= 32'b00001110_000001000000000000000001; // lwd 4 1 
        {Inst_mem[27],Inst_mem[26],Inst_mem[25],Inst_mem[24]} <= 32'b00000000000001010000000000100001; // loadi 5 0x21
        {Inst_mem[31],Inst_mem[30],Inst_mem[29],Inst_mem[28]} <= 32'b00010001000000000000010100100000; // swi 5 0x20
        {Inst_mem[35],Inst_mem[34],Inst_mem[33],Inst_mem[32]} <= 32'b00010000000000000000000100000101; // swd 1 5

    
    end


    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_testbench);
        
        CLK = 1'b1;
        RESET = 1'b0;
        
        #1 
        RESET = 1'b1;
        #9
        RESET = 1'b0;
    
        #800
        $finish;      
    end

    always @(PC)
    begin
        if (PC >= 0)
        begin
            #2 INSTRUCTION <= {Inst_mem[PC+32'd3],Inst_mem[PC+32'd2], Inst_mem[PC+32'd1], Inst_mem[PC]};
        end
        
    end
    
    // clock signal generation
    always #4 CLK = ~CLK;
        
endmodule