/*
    CO 224 : Lab 05 Part3
    Control Unit module
    E/16/069
*/

module controlUnit(RegDes, RegSrc1, RegSrc2, Immediate, aluOp, aluSrc, twoComplEn, writeEn, Instruction, CLK);

    input [31:0] Instruction;
    input CLK;
    output [7:0] Immediate;
    output [2:0] RegSrc1, RegSrc2, RegDes;
    output aluSrc, writeEn, twoComplEn; 
    output [2:0] aluOp;
    
    reg [31:0] InstructionReg;
    wire [7:0] Opcode;

    /*
        opcodes: 
            loadi: 00100000 
            mov  : 00101000
            add  : 00101001
            sub  : 00111001
            and  : 00101010
            or   : 00101011   
 
            aluOp   = opcode[2:0]
            aluSrc  = opcode[3]     
        twoComplEn  = opcode[4]
        writeEnable = opcode[5]
            
    */

    assign RegDes = InstructionReg[18:16];
    assign RegSrc1 = InstructionReg[10:8];
    assign RegSrc2 = InstructionReg[2:0];
    assign Immediate = InstructionReg[7:0];
    assign Opcode = Instruction[31:24];  

    assign #1 aluOp   = Opcode[2:0];
    assign #1 aluSrc  = Opcode[3];     
    assign #1 twoComplEn  = Opcode[4];
    assign #1 writeEn = Opcode[5];

    always @(Instruction)
    begin
        InstructionReg <= Instruction;      
    end

endmodule