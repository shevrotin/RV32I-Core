`timescale 1ns / 1ps

module adder2
    (
    input [31:0] inAdderOne,
    input [31:0] inAdderTwo,
    output [31:0] outAdder
    );
    
    assign outAdder = inAdderOne + inAdderTwo;
endmodule
