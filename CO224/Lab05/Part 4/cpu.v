/*
    CO 224 : Lab 05 Part4
    CPU module
    E/16/069
*/

`include "controlUnit.v"
`include "reg_file.v"
`include "alu.v"
`include "mux8.v"
`include "mux32.v"
`include "programCounter.v"
`include "twosComp.v"
`include "sign_extend.v"
`include "shift_left2.v"
`include "adder.v"


module cpu(PC, Instruction, CLK, RESET);
    
    input [31:0] Instruction;
    input CLK, RESET;

    output [31:0] PC;
  
    //Control unit outputs
    wire [7:0] Immediate;
    wire [2:0] RegSrc1, RegSrc2, RegDes;
    wire [2:0] AluOp;
    wire AluSrc, WriteEn, TwoComplEn; 
    wire branchEq, jump;
    
    wire ZeroFlag;  //for alu

    wire [7:0]  RegOut1, RegOut2;   //  Register File Outputs

    wire [7:0] OutTwoComplement;    // Twos Complement Output

    wire [7:0] muxOutTwoComp, muxOutAluSrc; // Mux outputs

    wire [7:0] AluResult; 
    
    // pc updates
    wire [31:0] pc_4adderOut;

    // for pc calculating of branch and jump instructions
    wire [7:0] offset_8Bit;
    wire [31:0] signExt_offset;
    wire [31:0] leftShift2_offset;
    wire [31:0] jorBranch_target;

    wire [31:0] branchMuxOut;
    wire [31:0] next_PC; 

    wire branchMuxEnable;

    // updating Program counter
    programCounter myPC(CLK, RESET, next_PC, PC);
    
    // Control Unit
    controlUnit myControl(RegDes, RegSrc1, RegSrc2, Immediate, AluOp, AluSrc, TwoComplEn, WriteEn, offset_8Bit, branchEq, jump, Instruction, CLK);   

    // Register File
    reg_file myRegFile(AluResult, RegOut1, RegOut2, RegDes, RegSrc1, RegSrc2, WriteEn, CLK, RESET);  

    // Obtain 2's complement of RegOut2
    twosComp CompTwo(OutTwoComplement, RegOut2);

    // Mux 
    mux8 muxTwosComp(muxOutTwoComp, RegOut2, OutTwoComplement, TwoComplEn);
    mux8 muxAluSrc(muxOutAluSrc, Immediate, muxOutTwoComp, AluSrc);
    
    //--Muxs for decide beq and j PC;
    mux32 branchMux(branchMuxOut, pc_4adderOut, jorBranch_target, branchMuxEnable);
    mux32 jumpMux(next_PC, branchMuxOut, jorBranch_target, jump);

    // ALU
    alu myALU(RegOut1, muxOutAluSrc, AluResult, ZeroFlag, AluOp);

    // generating branchMuxEnable --> branchMuxEnable = 1 only when both branchEq control signal and ZeroFlag is 1; 
    and andGate1(branchMuxEnable, branchEq, ZeroFlag);

    //---signextention of offset
    sign_extend mysignExt(offset_8Bit, signExt_offset);

    // -- left shift the sign extended offset by 2 
    shift_left2 myLeftShift(signExt_offset, leftShift2_offset);

    // Program Counter
    adder pc_4adder(PC, 32'd4, pc_4adderOut);   // pc = pc + 4
    adder pc_offsetAdder(pc_4adderOut, leftShift2_offset, jorBranch_target); //pc = (pc+4) + offset


endmodule
