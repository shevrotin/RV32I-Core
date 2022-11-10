`timescale 1ns / 1ps

module control
    (
    input clk,
    input [6:0] opcode,
    
    output reg branch, 
    output reg memRead,
    output reg memToReg,
    output reg [3:0] ALUOp,
    output reg memWrite,
    output reg ALUSrc,
    output reg regWrite,
    output reg customControlOne,
    output reg customControlTwo
    );
     
    localparam [6:0] LUI    = 7'b0110111;      // 0000
    localparam [6:0] AUIPC  = 7'b0010111;      // 0001 
    localparam [6:0] JAL    = 7'b1101111;      // 0010
    localparam [6:0] JALR   = 7'b1100111;      // 0011
    localparam [6:0] groupA = 7'b1100011;      // 0100
    localparam [6:0] groupB = 7'b0000011;      // 0101
    localparam [6:0] groupC = 7'b0100011;      // 0110
    localparam [6:0] groupD = 7'b0010011;      // 0111
    localparam [6:0] groupE = 7'b0110011;      // 1000
    localparam [6:0] FENCE  = 7'b0001111;      // 1001
    localparam [6:0] groupF = 7'b1110011;      // 1010
    
    always@(*)
        begin
        branch = 0;
        case(opcode)
            LUI:
                begin
                ALUOp <= 0;
                memToReg <= 0;
                regWrite <= 1;
                branch <= 0;
                ALUSrc <= 1;
                end
            AUIPC:
                begin
                ALUOp <= 1;
                memToReg <= 0;
                regWrite <= 1;
                branch <= 1;
                ALUSrc <= 1;
                customControlOne <= 1;
                customControlTwo <= 0;
                end
            JAL:
                begin
                ALUOp <= 2;
                customControlOne <= 0;
                customControlTwo <= 1;
                memToReg <= 0;
                regWrite <= 1;
                branch <= 1;
                ALUSrc <= 1;
                end
            JALR:
                begin
                ALUOp <= 3;
                customControlOne <= 0;
                customControlTwo <= 1;
                memToReg <= 0;
                regWrite <= 1;
                ALUSrc <= 1;
                branch <= 1;
                end    
            groupA:
                begin
                ALUOp <= 4;
                branch <= 1;
                ALUSrc <= 0;
                memToReg <= 0;
                customControlOne <= 1;
                customControlTwo <= 0;
                end
            groupB:
                begin
                ALUOp <= 5;
                memRead <= 1;
                memToReg <= 1;
                ALUSrc <= 1;
                regWrite <= 1;
                end
            groupC:
                begin
                ALUOp <= 6;
                ALUSrc <= 1;
                memWrite <= 1;
                memToReg <= 0;
                end
            groupD:
                begin
                ALUOp <= 7;
                ALUSrc <= 1;
                memToReg <= 0;
                regWrite <= 1;
                end
            groupE:
                begin
                ALUOp <= 8;
                regWrite <= 1;
                ALUSrc <= 0;
                memToReg <= 0;
                end
            FENCE:
                begin
                ALUOp <= 9;
                end    
            groupF:
                begin
                ALUOp <= 10;
                end
        endcase
        end
endmodule