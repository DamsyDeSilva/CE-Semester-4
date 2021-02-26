/*
    CO 224 : Lab 05 Part4
    Testbench for cpu module
    E/16/069
*/


`include "cpu.v"
module cpu_testbench;
    
    reg CLK, RESET;
    wire [31:0] PC;
    reg [31:0] INSTRUCTION;

    reg [7:0] Inst_mem[1023:0] ;  // Instruction Memory

    initial
    begin
        /*
            loadi 0 0x03
            loadi 1 0x02
            loadi 2 0x02
            loadi 3 0x00

            beq 0x02 0 1  // will not take the branch
            beq 0x01 1 2  // will take the branch

            add 4 0 1   // r4 = 5
            add 5 4 2   // r5 = 9

            j 0xFE
        */
        
        {Inst_mem[3],Inst_mem[2],Inst_mem[1],Inst_mem[0]}     <= 32'b00100000000000000000000000000011; 
        {Inst_mem[7],Inst_mem[6],Inst_mem[5],Inst_mem[4]}     <= 32'b00100000000000010000000000000010;
        {Inst_mem[11],Inst_mem[10],Inst_mem[9],Inst_mem[8]}   <= 32'b00100000000000100000000000000010;
        {Inst_mem[15],Inst_mem[14],Inst_mem[13],Inst_mem[12]} <= 32'b00100000000000110000000000000000;

        {Inst_mem[19],Inst_mem[18],Inst_mem[17],Inst_mem[16]} <= 32'b01011001000000100000000000000001;
        {Inst_mem[23],Inst_mem[22],Inst_mem[21],Inst_mem[20]} <= 32'b01011001000000010000000100000010;
        
        {Inst_mem[27],Inst_mem[26],Inst_mem[25],Inst_mem[24]} <= 32'b00101001000001000000000000000001;
        {Inst_mem[31],Inst_mem[30],Inst_mem[29],Inst_mem[28]} <= 32'b00101001000001010000010000000010;

        {Inst_mem[35],Inst_mem[34],Inst_mem[33],Inst_mem[32]} <= 32'b00000000111111100000000000000000;
        //{Inst_mem[39],Inst_mem[38],Inst_mem[37],Inst_mem[36]} <= 32'b00000000111111100000000000000000;

    end

    cpu mycpu(PC, INSTRUCTION, CLK, RESET);

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_testbench);
        
        CLK = 1'b1;
        RESET = 1'b0;
        
        #1 
        RESET = 1'b1;
        #11
        RESET = 1'b0;
    
        #120
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
    always #5 CLK = ~CLK;
        
endmodule