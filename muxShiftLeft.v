`timescale 1ns / 1ps

module muxShiftLeft
    (
    input [31:0] optionOne, optionTwo,
    input selection,
    
    output reg [31:0] chosenOption
    );
    
    always@(*)
        begin
        if(selection)
            begin
            chosenOption = optionTwo; 
            end
        else
            begin
            chosenOption = optionOne;
            end
        end
endmodule
