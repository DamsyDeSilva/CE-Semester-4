/*
    CO 224 : Lab 05 Part4
    sign extend ; module
    E/16/069
*/

module sign_extend(IN, OUT);

    // port declaration
    input [7:0] IN;
    output reg [31:0] OUT;

    always @(IN)
    begin
        OUT[7:0] = IN[7:0];
        OUT[31:8] = {24{IN[7]}}; 
    end

endmodule