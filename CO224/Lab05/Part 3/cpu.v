/*
    CO 224 : Lab 05 Part3
    CPU module
    E/16/069
*/

`include "controlUnit.v"
`include "reg_file.v"
`include "alu.v"
`include "mux.v"
`include "programCounter.v"
`include "twosComp.v"


module cpu(PC, Instruction, CLK, RESET);
    
    input [31:0] Instruction;
    input CLK, RESET;

    output [31:0] PC;
  
    //Control unit outputs
    wire [7:0] Immediate;
    wire [2:0] RegSrc1, RegSrc2, RegDes;
    wire [2:0] AluOp;
    wire AluSrc, WriteEn, TwoComplEn; 

    wire [7:0]  RegOut1, RegOut2;   //Register File Outputs

    wire [7:0] OutTwoComplement;    // Twos Complement Output

    wire [7:0] muxOutTwoComp, muxOutAluSrc; // Mux outputs

    wire [7:0] AluResult; 

    // Control Unit
    controlUnit myControl(RegDes, RegSrc1, RegSrc2, Immediate, AluOp, AluSrc, TwoComplEn, WriteEn, Instruction, CLK);   

    // Register File
    reg_file myRegFile(AluResult, RegOut1, RegOut2, RegDes, RegSrc1, RegSrc2, WriteEn, CLK, RESET);  

    // Obtain 2's complement of RegOut2
    twosComp CompTwo(OutTwoComplement, RegOut2);

    // Mux 
    mux muxTwosComp(muxOutTwoComp, RegOut2, OutTwoComplement, TwoComplEn);
    mux muxAluSrc(muxOutAluSrc, Immediate, muxOutTwoComp, AluSrc);

    // ALU
    alu myALU(RegOut1, muxOutAluSrc, AluResult, AluOp);

    // Program Counter
    programCounter myPC(CLK, RESET, PC);

endmodule
