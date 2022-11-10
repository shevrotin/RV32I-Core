`timescale 1ns / 1ps

module muxALU
    (
    input [31:0] potentialOperandOne,
    input [31:0] potentialOperandTwo,
    input selectOperand,
    
    output reg [31:0] chosenOperand 
    );
    
    always@(*)
        begin
        if(selectOperand) 
            begin
            chosenOperand <= potentialOperandTwo;
            end
        else
            begin
            chosenOperand <= potentialOperandOne;
            end
        end         
endmodule
