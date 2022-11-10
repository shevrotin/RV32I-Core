`timescale 1ns / 1ps

module registerFile
    (
    input clk, writeEnable,
    input [4:0] readRegister1,
    input [4:0] readRegister2,
    input [4:0] writeRegister,
    input [31:0] writeData,
    
    output [31:0] readData1,
    output [31:0] readData2
    );
    
    reg [0:31] mem [31:0];
    
    initial                                         // VALUES FROM 0 TO 31 WERE WRITTEN IN TO THE MEMORY ADRESSES, SEQUENTIALLY. 
        begin: memInit
        integer i;
        for(i=0;i<32;i=i+1) 
            begin
            mem [i] = i; // mem [i] = 32'b0;
            end
        end
    
    /*
    initial
        begin
        mem[0] = 32'b00000000000000000000000000000100;
        mem[1] = 32'b10000000000000000000000000000011;
        end
    */
    
    assign readData1 = mem[readRegister1];
    assign readData2 = mem[readRegister2];
    
    always@(posedge clk)
        begin
        if(writeEnable)
            begin
            mem [writeRegister] <= writeData;
            end
        end
endmodule
