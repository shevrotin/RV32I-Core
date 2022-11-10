`timescale 1ns / 1ps

module adder
    (
    input [31:0] inAdder,
    output [31:0] outAdder
    );
    
    reg [31:0] constantStep = 4;
    assign outAdder = inAdder + constantStep;
    
endmodule
