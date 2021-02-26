/*
    CO 224 : Lab 05 Part5
    Control Unit module
    E/16/069
*/

module controlUnit(RegDes, RegSrc1, RegSrc2, Immediate, aluOp, aluSrc, twoComplEn, writeEn, offset, branchEq, jump, branchNeq, shiftLeftEnble, Instruction, CLK);

    input [31:0] Instruction;
    input CLK;
    output [7:0] Immediate,offset;
    output [2:0] RegSrc1, RegSrc2, RegDes;
    output aluSrc, writeEn, twoComplEn; 
    output [2:0] aluOp;
    output branchEq;
    output reg jump, branchNeq;
    output shiftLeftEnble;

    reg [31:0] InstructionReg;
    wire [7:0] Opcode;

    /*
        opcodes: 
            loadi: 00100_000 
            mov  : 00101_000
            add  : 00101_001
            sub  : 00111_001
            and  : 00101_010
            or   : 00101_011 
            
            beq  : 01011_001 // aluop for beq is aluop for substraction;  
            j    : 00000000  
        
            bne  : 00011_001 // aluop for beq is aluop for substraction;

            mult : 00101_100 
            srl  : 00100_101 // logical shift right
            sll  : 10100_101 // logical shift left  -----> same opcode for both srl, sll
            sra  : 00100_110 // arithmetic shift right
            ror  : 00100_111 // rotate right


            aluOp   = opcode[2:0]
            aluSrc  = opcode[3]     
        twoComplEn  = opcode[4]
        writeEnable = opcode[5]
          branchEq  = opcode[6] 

    shiftLeftEnble =  opcode[7]
        branchNeq = 1'b1; for bne and  0 for every other opcode


     
    */

    assign RegDes = InstructionReg[18:16];
    assign RegSrc1 = InstructionReg[10:8];
    assign RegSrc2 = InstructionReg[2:0];
    assign Immediate = InstructionReg[7:0];
    assign Opcode = InstructionReg[31:24];  
    assign offset = InstructionReg[23:16];  // jump and branch offsets   

    assign #1 aluOp   = Opcode[2:0];
    assign #1 aluSrc  = Opcode[3];     
    assign #1 twoComplEn  = Opcode[4];
    assign #1 writeEn = Opcode[5];
    assign #1 branchEq = Opcode[6];
    assign #1 shiftLeftEnble = Opcode[7];
    

    always @(Instruction)
    begin
        InstructionReg <= Instruction;      
    end
    
    // for additional controlsignals
    always @(Opcode)
    begin
        case(Opcode)
            
            // jump instruction
            8'b00000000:
                begin
                    #1
                    jump <= 1'b1; 
                    branchNeq <= 1'b0;
                end
                
            // bne instruction
            8'b00011001: 
                begin
                    #1 
                    branchNeq <= 1'b1;
                    jump <= 1'b0;
                end
         
            default:
                begin
                    #1 
                    branchNeq <= 1'b0;
                    jump <= 1'b0;
                end
                
        endcase
        
    end

endmodule