/*
    CO 224 : Lab 06
    Testbench for cpu module
    E/16/069
*/


`include "cpu.v"
`include "dmem_for_dcache.v"
`include "dcache.v"
`include "i_cache.v"
`include "imem_for_icache.v"
`timescale 1ns/100ps

module cpu_testbench;
    
    reg CLK, RESET;

    // for connect data_cache and cpu
    wire dcache_Busywait;
    wire Read, Write;    
    wire [7:0] Read_Data, Write_Data;
    wire [7:0] Address;

    // for connect data_cache and data_memory
    wire Mem_Busywait;
    wire Mem_Read, Mem_Write;  
    wire [31:0] Mem_ReadData, Mem_WriteData;
    wire [5:0] Mem_Address;

    
    // for connect intruction_cache and cpu
    wire icache_BusyWait;
    wire [31:0] PC;
    wire [31:0] INSTRUCTION;

    // for connect intruction_cache and instruction_memory
    wire [127:0] IMem_ReadData;
    wire IMem_Read;
    wire [5:0] IMem_Address;
    wire IMem_BusyWait;

    // final Busywait of cpu
    wire Busywait; 
    or or1(Busywait, dcache_Busywait, icache_BusyWait);

    // instruction cache
    i_cache myInsCache(CLK, RESET, PC, INSTRUCTION, icache_BusyWait, IMem_ReadData, IMem_Read, IMem_Address, IMem_BusyWait);
    // instruction memory 
    inst_memory myInsMemory(CLK, IMem_Read, IMem_Address, IMem_ReadData, IMem_BusyWait);
    // cpu 
    cpu mycpu(PC, INSTRUCTION, CLK, RESET, Busywait, Read_Data, Write_Data, Write, Read, Address);
    // data cache 
    dcache myCache(CLK, RESET, Address, Read, Write, Write_Data, Read_Data, dcache_Busywait, Mem_Address, Mem_Read, Mem_Write, Mem_WriteData, Mem_ReadData, Mem_Busywait);
    // data memory
    data_memory myDataMemory(CLK ,RESET, Mem_Read, Mem_Write, Mem_Address, Mem_WriteData, Mem_ReadData, Mem_Busywait);

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
    
        #3000
        $finish;      
    end

    // clock signal generation
    always #4 CLK = ~CLK;
        
endmodule