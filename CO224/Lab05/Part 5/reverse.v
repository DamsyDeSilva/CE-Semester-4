/*
    CO 224 : Lab 05 Part5
    module for reverse the 8 bit input : using for do shift_left using shift_right module
    E/16/069
*/

module reverse(In, Out);

    // port declaration
    input [7:0] In;
    output reg [7:0] Out;

    always @(In)
    begin
        Out[0] = In[7];
        Out[1] = In[6];
        Out[2] = In[5];
        Out[3] = In[4];
        Out[4] = In[3];
        Out[5] = In[2];
        Out[6] = In[1];
        Out[7] = In[0];
    end
endmodule