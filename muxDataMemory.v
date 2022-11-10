`timescale 1ns / 1ps

module muxDataMemory
    (
    input selectData,
    input [31:0] potentialDataOne,
    input [31:0] potentialDataTwo,
    
    output reg [31:0] chosenData
    );
    
    always@(*)
        begin
        if(selectData)
            begin
            chosenData <= potentialDataOne;
            end
        else
            begin
            chosenData <= potentialDataTwo;
            end
        end
endmodule
