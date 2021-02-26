/*
    CO 224 : Lab 05 Part3
    mux module
    E/16/069
*/
module mux(Out, In0, In1, Sel);

    // Port Declaration
    input [7:0] In0, In1;
    input Sel;
    output reg [7:0] Out;

    always @(Sel or In0 or In1)
    begin
        case(Sel)
            1'b0 : Out <= In0;
            1'b1 : Out <= In1;
        endcase
    end

endmodule
