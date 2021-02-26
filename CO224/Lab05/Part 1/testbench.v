/*
    CO 224 : Lab 05 Part1
    testbech for ALU module
    E/16/069
*/
module testbench;

    reg [7:0] OPERAND_1, OPERAND_2;
    reg [2:0] ALU_OP;
    wire [7:0] ALU_RESULT;

    alu myalu(OPERAND_1, OPERAND_2, ALU_RESULT, ALU_OP);

    initial
    begin
        $monitor($time, " OPERAND_1: %8b , OPERAND_2: %8b , ALU_RESULT: %8b , ALU_OP: %3b ", OPERAND_1, OPERAND_2,  ALU_RESULT, ALU_OP);
        $dumpfile("wavedata.vcd");
        $dumpvars(0, testbench);
    end

    initial
    begin

        // test "add" aluOp
        ALU_OP = 3'b001;
        OPERAND_1 = 8'b00001001;    
        OPERAND_2 = 8'b00010011 ;    
        //expected Result : 00011100  

        #10
        // test "load, mov" aluOp
        ALU_OP = 3'b000;
        //expected Result : 00010011  

        #10
        // test "AND" aluOp
        ALU_OP = 3'b010;
        OPERAND_1 = 8'b00010100;    
        OPERAND_2 = 8'b01011010;
        // expected Result : 00010000 

        #10
        // test "OR" aluOp
        ALU_OP = 3'b011;
        OPERAND_1 = 8'b00010100;    
        OPERAND_2 = 8'b01011010;
        // expected Result : 01011110 

        #10
        // test an unsused bit combination of aluOp
        ALU_OP = 3'b111;
        // expected Result : xxxxxxxx 

    end
endmodule
