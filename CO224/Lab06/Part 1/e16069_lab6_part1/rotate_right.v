/*
    CO 224 : Lab 06
    rotate right module
    E/16/069
*/

//`include "mux8.v"


module rotate_right(IN, r_amt, OUT);

    // port declaration
    input [7:0] IN;
    input [7:0] r_amt;
    output [7:0] OUT;

    wire [7:0] r1, r2, r3;


   // rotate by either 0 or 1 bits.
   mux8 rt0( r1, IN, {{IN[0]}, {IN[7:1]}}, r_amt[0]);

   // rotate by either 0 or 2 bits.
   mux8 rt1( r2, r1, {{r1[1:0]}, {r1[7:2]}}, r_amt[1]);

   // rotate by either 0 or 4 bits.
   mux8 rt2( r3, r2, {{r2[3:0]}, {r2[7:4]}}, r_amt[2]);

   // rotate by either 0 or 8 bits.
   mux8 rt3( OUT, r3, {r3[7:0]}, r_amt[3]);

endmodule