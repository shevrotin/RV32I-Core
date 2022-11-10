`timescale 1ns / 1ps

module muxAdder2
    (
    input [31:0] optionA, optionB,
    input selection,

    output reg [31:0] chosenOption
    );
    
    always@(*)
        begin
        if(selection)
            begin
            chosenOption = optionA;
            end
        else
            begin
            chosenOption = optionB;
            end
        end
endmodule
