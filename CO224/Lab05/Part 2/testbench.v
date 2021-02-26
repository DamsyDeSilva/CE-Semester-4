/*
    CO 224 : Lab 05 Part2
    Testbench for Register File module
    E/16/069
*/
module testbench;

    reg [7:0] WRITEDATA;
    reg [2:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [7:0] REGOUT1, REGOUT2;

    reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);

    initial
    begin
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("regFile_wavedata.vcd");
        $dumpvars(0, testbench);
    end
  
    initial
    begin
        CLK = 1'b1;
        RESET = 1'b0;
        WRITEENABLE = 1'b0;

        #1
        RESET = 1'b1;
        READREG1 = 3'd0;
        READREG2 = 3'd1;

        #6 //7s
        WRITEREG = 3'd1;
        WRITEDATA = 8'd65;
        WRITEENABLE = 1'b1;
        
        #5 //12s
        RESET = 1'b0;

        #11 //23s
        WRITEENABLE = 1'b0;

        #10 //33s
        WRITEREG = 3'd2;
        WRITEDATA = 8'd75;
        READREG2 = 3'd2;
        WRITEENABLE = 1'b1;

        #10 //43s
        WRITEENABLE = 1'b0;
        //WRITEDATA = 8'd95;

        #5 //48s
        WRITEENABLE = 1'b1;
        WRITEDATA = 8'd95;

        #12//60s
        WRITEENABLE = 1'b0;

        #10 //70s
        WRITEENABLE = 1'b1;
        WRITEREG = 3'd0;
        WRITEDATA = 8'd121;

        #20 //90s
        WRITEENABLE = 1'b0;
        RESET = 1'b1;

        #10 //100s
        $finish;

    end
    // clock signal generation
    always
        #5 CLK = ~CLK;
    


endmodule