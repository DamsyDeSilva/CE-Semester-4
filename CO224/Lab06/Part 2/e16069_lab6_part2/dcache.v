/*
    CO 224 : Lab 06
    dcache module
    E/16/069
*/

`timescale 1ns/100ps
module dcache(
    Clk,
    Reset,
    Address,
    Read,
    Write,
    Write_Data,
    Read_Data,
    Busy_Wait,
    Mem_Address,
    Mem_Read,
    Mem_Write,
    Mem_WriteData,
    Mem_ReadData,
    Mem_BusyWait

);
    // -----port declaration-----
    // cpu to cache
    input Clk, Reset, Read, Write;
    input [7:0] Address, Write_Data;
    output reg Busy_Wait;
    output reg [7:0] Read_Data;

    // cache to memory
    input [31:0] Mem_ReadData;
    input Mem_BusyWait;
    output reg [31:0] Mem_WriteData;
    output reg [5:0] Mem_Address;
    output reg Mem_Read, Mem_Write;

    // --cache variables
    reg [2:0] TAG [7:0];
    reg VALID [7:0];
    reg DIRTY [7:0];
    reg [31:0] cacheDATA [7:0];

    // --parameters should obtain from Address
    wire [2:0] index;
    wire [2:0] tag;
    wire [1:0] offset;

    // obtain tag, index and offset from address
    assign tag = Address[7:5];
    assign index = Address[4:2];
    assign offset = Address[1:0];


    // intemediate variables that should extracted from correct cache entry
    wire dirty, valid;
    wire [2:0] c_tag;
    wire [31:0] datablock;

    wire Hit; // store hit status
    wire tag_compared; // store tag comparison status

    // store correct data word from datablock
    reg [7:0] read_DataWord;

    integer i;    
    // Reset the cache data 
    always @(Reset)
    begin
        if(Reset) 
        begin
            for (i = 0; i < 8; i++) begin
                cacheDATA[i] = 0;
                TAG[i] = 0;
                VALID[i] = 0; 
                DIRTY[i] = 0;
            end      
            Busy_Wait = 0;
        end
      
    end


    // detecting incoming cache access from cpu
    always @(Read, Write)
    begin
        Busy_Wait = (Read || Write)? 1 : 0;
    end

    // extracy stored datablock, tag, valid, and dirty status from correct cache entry
    assign #1 valid = VALID[index];
    assign #1 dirty = DIRTY[index];
    assign #1 c_tag = TAG[index];
    assign #1 datablock = cacheDATA[index];

    // tag comaprison and detecting hit status
    assign #0.9 tag_compared = (tag == c_tag) ? 1 : 0;
    assign Hit = (tag_compared && valid) ? 1 : 0;


    always @(posedge Clk)
    begin
        // de-asserting Busy_Wait at positive clk edge if its a hit;
        if (Hit)
        begin
            Busy_Wait = 0;
        end
    end

    always @(posedge Clk)
    begin
         //---- write hit----
        if (Hit && Write)
        begin
            if (offset == 2'b00)
            begin
                #1
                cacheDATA[index][7:0] = Write_Data;
                DIRTY[index] = 1;
            end
            else if (offset == 2'b01)
            begin
                #1
                cacheDATA[index][15:8] = Write_Data;
                DIRTY[index] = 1;
            end    
            else if (offset == 2'b10)
            begin
                #1
                cacheDATA[index][23:16] = Write_Data;
                DIRTY[index] = 1;
            end     
            else if (offset == 2'b11)
            begin
                #1
                cacheDATA[index][31:24] = Write_Data;
                DIRTY[index] = 1;
            end         
        end
    end

    //----Read-----
    always @(*)
    begin            
        // select correct dataword from extracted datablock
        if (offset == 2'b00)
            #1 read_DataWord = datablock [7:0];
        else if (offset == 2'b01)
            #1 read_DataWord = datablock[15:8];
        else if (offset == 2'b10)
            #1 read_DataWord = datablock[23:16];
        else if (offset == 2'b11)
            #1 read_DataWord = datablock[31:24];

        // when its a hit assign extracted data word to the final output to cpu   
        if (Hit && Read) 
            Read_Data <= read_DataWord;
    end

    /* Cache Controller FSM Start */
    parameter IDLE = 2'b00, MEM_READ = 2'b01, WRITE_BACK = 2'b10, CACHE_UPDATE = 2'b11;
    reg [1:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((Read || Write) && !dirty && !Hit)  
                    next_state = MEM_READ;
                else if ((Read || Write) && dirty && !Hit)
                    next_state = WRITE_BACK;
                else 
                    next_state = IDLE;
            
            MEM_READ:
                if (!Mem_BusyWait)
                    next_state = CACHE_UPDATE;
                else    
                    next_state = MEM_READ;
            
            WRITE_BACK:
                if (!Mem_BusyWait)
                    next_state = MEM_READ;
                else    
                    next_state = WRITE_BACK;
            
            CACHE_UPDATE:
                    next_state = IDLE;

        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin        
                Mem_Read = 0;
                Mem_Write = 0;
                Busy_Wait = 0;
            end
         
            MEM_READ: 
            begin
                Mem_Read = 1;
                Mem_Write = 0;
                Mem_Address = {tag, index};
                Busy_Wait = 1;
            end

            WRITE_BACK: 
            begin
                Mem_Read = 0;
                Mem_Write = 1;
                Mem_Address = {c_tag, index};
                Mem_WriteData = cacheDATA[index];
                Busy_Wait = 1;
            end

            CACHE_UPDATE: 
            begin
                Mem_Read = 0;
                Mem_Write = 0;
                #1 cacheDATA[index] = Mem_ReadData;
                TAG[index] = tag;
                VALID[index] = 1;
                Busy_Wait = 1;
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