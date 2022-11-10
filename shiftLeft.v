`timescale 1ns / 1ps

module shiftLeft
    (
    input [31:0] shifterInput,
    
    output [31:0] shifterOutput
    );
    
    assign shifterOutput = {shifterInput[31:12] << 1, shifterInput[11:0]};
endmodule
