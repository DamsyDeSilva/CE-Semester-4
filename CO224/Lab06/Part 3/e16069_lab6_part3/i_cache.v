/*
    CO 224 : Lab 06
    instruction cache module
    E/16/069
*/

`timescale 1ns/100ps
module i_cache(
    Clk,
    Reset,
    PC,
    Instruction,
    Busy_Wait,
    IMem_ReadData,
    IMem_Read,
    IMem_Address,
    IMem_BusyWait
);

    //---port declaration----
    input Clk, Reset;
    // cpu to icache
    input [31:0] PC;
    output reg [31:0] Instruction;
    output reg Busy_Wait;

    // icache to imem
    input [127:0] IMem_ReadData;
    input IMem_BusyWait;
    output reg [5:0] IMem_Address;
    output reg IMem_Read;

    // --icache variables
    reg [2:0] TAG [7:0];
    reg VALID [7:0];
    reg [127:0] i_cacheDATA [7:0];

    // Getting 10 bit Address from from 32bit pc
    wire [9:0] Address; 
    assign Address = PC[9:0];

    // --parameters should obtain from Address
    wire [2:0] index;
    wire [2:0] tag;
    wire [1:0] offset;

    // obtain tag, index and offset from address
    assign tag = Address[9:7];
    assign index = Address[6:4];
    assign offset = Address[3:2];

    // intemediate variables that should extracted from correct cache entry
    wire valid;
    wire [2:0] ic_tag;
    wire [127:0] instructionBlock;

    wire Hit; // store hit status
    wire tag_compared; // store tag comparison status

    // store correct data word from datablock
    reg [31:0] Instruction_Word;

    integer i;    
    // Reset the cache data 
    always @(Reset)
    begin
        if(Reset) 
        begin
            for (i = 0; i < 8; i++) begin
                i_cacheDATA[i] = 32'dx;
                TAG[i] = 0;
                VALID[i] = 0; 
            end      
            Busy_Wait = 0;
        end    
    end
    
    // detecting incoming I_cache access from cpu
    always @(PC)
    begin
        Busy_Wait =  1 ;
    end

    // extracy stored datablock, tag and valid from correct cache entry
    assign #1 valid = VALID[index];
    assign #1 ic_tag = TAG[index];
    assign #1 instructionBlock = i_cacheDATA[index];

    // tag comaprison and detecting hit status
    assign #1 tag_compared = (tag == ic_tag) ? 1 : 0;
    assign Hit = (tag_compared && valid) ? 1 : 0;

    always @(*)
    begin
        // select correct instruction from extracted instructionBlock
        if (offset == 2'b00)
            #1 Instruction = instructionBlock[31:0];
        else if (offset == 2'b01)
            #1 Instruction = instructionBlock[63:32];
        else if (offset == 2'b10)
            #1 Instruction = instructionBlock[95:64];
        else if (offset == 2'b11)
            #1 Instruction = instructionBlock[127:96];

        
    end
    
    always @(posedge Clk)
    begin
        // de-asserting Busy_Wait at positive clk edge if its a hit;
        if (Hit)
        begin
            Busy_Wait = 0;
        end
    end

    /* Cache Controller FSM Start */
    parameter IDLE = 2'b00, IMEM_READ = 2'b01, ICACHE_UPDATE = 2'b10;
    reg [1:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if (!Hit && PC < 32'd1024)  
                    next_state = IMEM_READ;
                else 
                    next_state = IDLE;
            
            IMEM_READ:
                if (!IMem_BusyWait)
                    next_state = ICACHE_UPDATE;
                else    
                    next_state = IMEM_READ;
                        
            ICACHE_UPDATE:
                    next_state = IDLE;

        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin        
                Busy_Wait = 0;
                IMem_Read = 0;
            end
         
            IMEM_READ: 
            begin
                Busy_Wait = 1;
                IMem_Read = 1;
                IMem_Address = {tag,index};
            end

            ICACHE_UPDATE: 
            begin
                Busy_Wait = 1;
                IMem_Read = 0;
                #1 i_cacheDATA[index] = IMem_ReadData;
                TAG[index] = tag;
                VALID[index] = 1;

            end
            
        endcase
    end

    // sequential logic for state transitioning 
    always @(posedge Clk, Reset)
    begin
        if(Reset)
            state = IDLE;
        else
            state = next_state;
    end

    /* Cache Controller FSM End */

endmodule