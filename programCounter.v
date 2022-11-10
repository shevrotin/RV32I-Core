`timescale 1ns / 1ps

module programCounter
    (
    input clk, rst,
    input [31:0] nextPC,
    output reg [31:0] currentPC
    );
    
    always@(posedge clk)
        begin
        if(rst)
            begin
            currentPC <= 0;        
            end
        else
            begin
            currentPC <= nextPC;
            end
        end   
endmodule
