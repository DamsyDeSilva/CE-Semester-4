/*
    CO 224 : Lab 05 Part5
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
`include "reverse.v"

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
    
    // for implementing part 5
    wire bneqEnable;    
    wire beqEnable;

    wire branchNeq;     // control signals
    
    wire ZeroFlagInverted;

    // for implementing logical shift left operation using logical shift right module
    wire [7:0] revReg1;
    wire shft_L_muxEnable; // control signal
    wire [7:0] operand_1;
    wire [7:0] revAluResult;
    wire [7:0] final_aluReslt;

    // ----------- Implementing left shift ;
    // --> 1. data1 for the alu is reversed before fetching to the alu
    // --> 2. do shift right
    // --> 3. alu result is reversed, outside the alu --> you get logical shift left
    reverse revOperand_1(RegOut1, revReg1);
    mux8 shftLft_Mux(operand_1, RegOut1, revReg1, shft_L_muxEnable);
    reverse revAluRes(AluResult, revAluResult);
    mux8 aluRes(final_aluReslt, AluResult, revAluResult, shft_L_muxEnable);
    
     
    // Control Unit
    controlUnit myControl(RegDes, RegSrc1, RegSrc2, Immediate, AluOp, AluSrc, TwoComplEn, WriteEn, offset_8Bit, branchEq, jump, branchNeq, shft_L_muxEnable, Instruction, CLK);   

    // Register File
    reg_file myRegFile(final_aluReslt, RegOut1, RegOut2, RegDes, RegSrc1, RegSrc2, WriteEn, CLK, RESET);  

    // Obtain 2's complement of RegOut2
    twosComp CompTwo(OutTwoComplement, RegOut2);

    // Mux 
    mux8 muxTwosComp(muxOutTwoComp, RegOut2, OutTwoComplement, TwoComplEn); // selecting twoscomplement: mux
    mux8 muxAluSrc(muxOutAluSrc, Immediate, muxOutTwoComp, AluSrc);          // selecting alusrc between immediate and reg;
    
    // ALU
    alu myALU(operand_1, muxOutAluSrc, AluResult, ZeroFlag, AluOp);

    // generating branchMuxEnable --> 
    //beqEnable = 1 only when both branchEq control signal and ZeroFlag is 1; 
    and andGate1(beqEnable, branchEq, ZeroFlag);
    
    //bneqEnable = 1 only when both branchNeq control signal and ZeroFlag is 0; 
    not n1(ZeroFlagInverted, ZeroFlag);
    and andGate2(bneqEnable, branchNeq, ZeroFlagInverted);

    // taking the branch value for pc when beq or bne is enabled
    or or1(branchMuxEnable, beqEnable, bneqEnable);

    //--Muxs for decide PC for beq and j and bne
    mux32 branchMux(branchMuxOut, pc_4adderOut, jorBranch_target, branchMuxEnable);
    mux32 jumpMux(next_PC, branchMuxOut, jorBranch_target, jump);

    // Program Counter
    adder pc_4adder(PC, 32'd4, pc_4adderOut);   // pc = pc + 4
    adder pc_offsetAdder(pc_4adderOut, leftShift2_offset, jorBranch_target); //pc = (pc+4) + offset

    // updating Program counter
    programCounter myPC(CLK, RESET, next_PC, PC);

    //---signextention of offset
    sign_extend mysignExt(offset_8Bit, signExt_offset);

    // -- left shift the sign extended offset by 2 
    shift_left2 myLeftShift(signExt_offset, leftShift2_offset);

    


endmodule
