`timescale 1ns / 1ps

module dataMemory
    (
    input clk, rst,
    input [31:0] address,           // related address
    input [31:0] writeData,         // data to write
    input memRead,                  // read control signal
    input memWrite,                 // write control signal
    input [2:0] funct3,             // to decide load or store 32bits, 16bits or 8 bits
    
    output reg [31:0] readData          // output
    );
    
    reg [31:0] mem [63:0];
    
    //groupB
    localparam [2:0] LB  = 3'b000;
    localparam [2:0] LH  = 3'b001;
    localparam [2:0] LW  = 3'b010;
    localparam [2:0] LBU = 3'b100;
    localparam [2:0] LHU = 3'b101;
    
    //groupC
    localparam [2:0] SB = 3'b000;
    localparam [2:0] SH = 3'b001;
    localparam [2:0] SW = 3'b010;
    
    initial                                             // VALUE "0" WAS WRITTEN IN TO MEMORY ADRESSES FROM 2 TO 63. 
        begin: memInit                                  // VALUES FOR MEMORY ADRESSES 0 AND 1 WERE DEFINED BY HAND
        integer i;
        for(i=2;i<64;i=i+1) 
            begin
            mem [i] = 32'b0; // mem [i] = i;
            end
        
        mem[0] = 32'b01010101010101010101010101010101;
        mem[1] = 32'b10101010101010101010101010101010;
        
        end

    always@(posedge clk)
        begin
        if(memWrite)
            begin
            case(funct3)
                SB:
                    begin
                    mem[address][7:0] <= writeData[7:0];
                    end
                SH:
                    begin
                    mem[address][15:0] <= writeData[15:0];
                    end
                SW: 
                    begin
                    mem[address] <= writeData;
                    end
            endcase
            end   
        end
    
    always@(*)
        begin
        if(memRead)
            begin
            case(funct3)
                LB:
                    begin
                    readData  = { {24{mem[address][7]}}, mem[ address ][7:0]};
                    end
                LH:
                    begin
                    readData  = { {16{mem[address][15]}}, mem[ address ][15:0]};
                    end
                LW:
                    begin
                    readData[31:0] = mem[address][31:0];
                    end
                LBU:
                    begin
                    readData  = { {24{1'b0}}, mem[ address ][7:0]};
                    end
                LHU:
                    begin
                    readData  = { {16{1'b0}}, mem[ address ][15:0]};
                    end
            endcase
            end
        end    
endmodule
