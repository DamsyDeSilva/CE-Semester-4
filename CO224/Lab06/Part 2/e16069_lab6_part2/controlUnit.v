/*
    CO 224 : Lab 06
    Control Unit module
    E/16/069
*/
`timescale 1ns/100ps
module controlUnit(
    RegDes, 
    RegSrc1, 
    RegSrc2, 
    Immediate, 
    aluOp, 
    aluSrc, 
    twoComplEn, 
    writeEn, 
    offset, 
    branchEq,
    jump, 
    branchNeq, 
    shiftLeftEnble, 
    read_Mem,
    write_Mem,
    Instruction, 
    CLK
);

    input [31:0] Instruction;
    input CLK;

    output [7:0] Immediate,offset;
    output [2:0] RegSrc1, RegSrc2, RegDes;
        
    // contol signals
    output reg aluSrc, writeEn, twoComplEn; 
    output reg [2:0] aluOp;
    output reg branchEq, jump, branchNeq;
    output reg shiftLeftEnble;

    output reg read_Mem, write_Mem;

    reg [31:0] InstructionReg;
    wire [7:0] opcode;

    // store control signals corresponding to the opcodes 
    // 18 instructions and 10 control signals(aluOp contain 3bits --> total bits of control signals = 12 ) 
    reg [11:0] ctrlSignal_file [17:0] ;   

    initial 
    begin
        ctrlSignal_file[0] <= 12'b000000100000;  //loadi: opcode = 8'd0
        ctrlSignal_file[1] <= 12'b000000101000;  //mov  : opcode = 8'd1
        ctrlSignal_file[2] <= 12'b000000101001;  //add  : opcode = 8'd2
        ctrlSignal_file[3] <= 12'b000000111001;  //sub  : opcode = 8'd3
        ctrlSignal_file[4] <= 12'b000000101010;  //and  : opcode = 8'd4
        ctrlSignal_file[5] <= 12'b000000101011;  //or   : opcode = 8'd5
        ctrlSignal_file[6] <= 12'b000001011001;  //beq  : opcode = 8'd6
        ctrlSignal_file[7] <= 12'b000010000000;  //j    : opcode = 8'd7
        ctrlSignal_file[8] <= 12'b000000101100;  //mul  : opcode = 8'd8
        ctrlSignal_file[9] <= 12'b000000100101;  //srl  : opcode = 8'd9
       ctrlSignal_file[10] <= 12'b000100100101;  //sll  : opcode = 8'd10
       ctrlSignal_file[11] <= 12'b000000100110;  //sra  : opcode = 8'd11
       ctrlSignal_file[12] <= 12'b000000100111;  //ror  : opcode = 8'd12
       ctrlSignal_file[13] <= 12'b001000011001;  //bne  : opcode = 8'd13
       ctrlSignal_file[14] <= 12'b100000101000;  //lwd  : opcode = 8'd14
       ctrlSignal_file[15] <= 12'b100000100000;  //lwi  : opcode = 8'd15
       ctrlSignal_file[16] <= 12'b010000001000;  //swd  : opcode = 8'd16
       ctrlSignal_file[17] <= 12'b010000000000;  //swi  : opcode = 8'd17
    end

    assign RegDes = InstructionReg[18:16];
    assign RegSrc1 = InstructionReg[10:8];
    assign RegSrc2 = InstructionReg[2:0];
    assign Immediate = InstructionReg[7:0];
    assign opcode = InstructionReg[31:24];  
    assign offset = InstructionReg[23:16];  // jump and branch offsets  

    always @(Instruction)
    begin
        InstructionReg <= Instruction; 
        write_Mem <= 1'b0;
        read_Mem <= 1'b0; 
        #1
             aluOp <= ctrlSignal_file[opcode][2:0];
            aluSrc <= ctrlSignal_file[opcode][3];
        twoComplEn <= ctrlSignal_file[opcode][4];
           writeEn <= ctrlSignal_file[opcode][5];
          branchEq <= ctrlSignal_file[opcode][6];
              jump <= ctrlSignal_file[opcode][7];
    shiftLeftEnble <= ctrlSignal_file[opcode][8];
         branchNeq <= ctrlSignal_file[opcode][9];
         write_Mem <= ctrlSignal_file[opcode][10];
          read_Mem <= ctrlSignal_file[opcode][11]; 

    end

endmodule