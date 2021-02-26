/*
    CO 224 : Lab 06
    Testbench for cpu module
    E/16/069
*/

`include "cpu.v"
`include "dmem.v"
module cpu_testbench;
    
    reg CLK, RESET;
    wire [31:0] PC;
    reg [31:0] INSTRUCTION;

    reg [7:0] Inst_mem[1023:0] ;  // Instruction Memory

    // for implementing data_memory
    wire Busywait;
    wire Read_Mem, Write_Mem;   // control signals 
    wire [7:0] Read_Data, Write_Data;
    wire [7:0] Address_Mem;

    //cpu mycpu(PC, INSTRUCTION, CLK, RESET);
    cpu mycpu(PC, INSTRUCTION, CLK, RESET, Busywait, Read_Data, Write_Data, Write_Mem, Read_Mem, Address_Mem);
    data_memory myDataMemory(CLK ,RESET,Read_Mem, Write_Mem, Address_Mem, Write_Data, Read_Data, Busywait);

    initial
    begin
        /*
            loadi 0 0x03   // reg[0] = 3
            loadi 1 0x05   // reg[1] = 5
            add 2 1 0      // reg[2] = 8
            swi 0 0x01     // Mem[1] = 3 (=reg[0])
            swi 2 0x02     // Mem[2] = 8 (=reg[2])
            swd 1 2        // Mem[8] = 5
            j 0x01    
            srl 3 1 0x02   // this will be skipped
            lwi 3 0x01     // reg[3] = 3 (=Mem[1]) 
            lwi 5 0x02     // reg[5] = 8 (=Mem[2])
            lwd 4 2        // reg[4] = 5 (=Mem[8])
        */
        
        
        {Inst_mem[3],Inst_mem[2],Inst_mem[1],Inst_mem[0]}     <= 32'b00000000000000000000000000000011; //loadi 0 0x03
        {Inst_mem[7],Inst_mem[6],Inst_mem[5],Inst_mem[4]}     <= 32'b00000000000000010000000000000101; //loadi 1 0x05  
        {Inst_mem[11],Inst_mem[10],Inst_mem[9],Inst_mem[8]}   <= 32'b00000010000000100000000100000000; //add 2 1 0
        {Inst_mem[15],Inst_mem[14],Inst_mem[13],Inst_mem[12]} <= 32'b00010001000000000000000000000001; //swi 0 0x01
        {Inst_mem[19],Inst_mem[18],Inst_mem[17],Inst_mem[16]} <= 32'b00010001000000000000001000000010; //swi 2 0x02
        {Inst_mem[23],Inst_mem[22],Inst_mem[21],Inst_mem[20]} <= 32'b00010000000000000000000100000010; //swd 1 2 
        {Inst_mem[27],Inst_mem[26],Inst_mem[25],Inst_mem[24]} <= 32'b00000111000000010000000000000000; //j 0x01 
        {Inst_mem[31],Inst_mem[30],Inst_mem[29],Inst_mem[28]} <= 32'b00001001000000110000000100000010; //srl 3 1 0x02 // this will be skipped
        {Inst_mem[35],Inst_mem[34],Inst_mem[33],Inst_mem[32]} <= 32'b00001111000000110000000000000001; //lwi 3 0x01
        {Inst_mem[39],Inst_mem[38],Inst_mem[37],Inst_mem[36]} <= 32'b00001111000001010000000000000010; //lwi 5 0x02 
        {Inst_mem[43],Inst_mem[42],Inst_mem[41],Inst_mem[40]} <= 32'b00001110000001000000000000000010; //lwd 4 2 

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
    
        #350
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