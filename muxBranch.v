`timescale 1ns / 1ps

module muxBranch
    (
    input [31:0] optionOne,
    input [31:0] optionTwo,
    input selection,
    
    output reg [31:0] chosenOption
    );
    
    always@(*)
        begin
        if(selection)
            begin
            chosenOption <= optionTwo;
            end
        else
            begin
            chosenOption <= optionOne;
            end
        end
endmodule

