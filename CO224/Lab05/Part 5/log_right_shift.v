/*
    CO 224 : Lab 05 Part5
    logical shift right module
    E/16/069
*/


module log_right_shift(IN,shamt, OUT);

    // port declaration
    input [7:0] IN;         // unshifted
    input  [7:0] shamt;     // shift amount
    output reg [7:0] OUT;   // shifted
    
    
    // since input is 8bits possible shiftamounts are upto 7;
    // more than 7 shifts results 0; (default)
    
    always @(IN)
    begin
        
        case(shamt)
            0: OUT = IN;
            1: OUT = { 1'b0, IN[7:1] };
            2: OUT = { 2'b0, IN[7:2] };
            3: OUT = { 3'b0, IN[7:3] };
            4: OUT = { 4'b0, IN[7:4] };
            5: OUT = { 5'b0, IN[7:5] };
            6: OUT = { 6'b0, IN[7:6] };
            7: OUT = { 7'b0, IN[7:7] };
            default: OUT = 8'd0;
        endcase
    end
    
endmodule