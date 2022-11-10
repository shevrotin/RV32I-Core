`timescale 1ns / 1ps

module immediateGenerator
    (
    input [31:0] instruction,
    
    output reg [31:0] immediate
    );
    
    localparam [6:0] LUI    = 7'b0110111;      // u type
    localparam [6:0] AUIPC  = 7'b0010111;      // u type
    localparam [6:0] JAL    = 7'b1101111;      // j type
    localparam [6:0] JALR   = 7'b1100111;      // i type
    localparam [6:0] groupA = 7'b1100011;      // b type
    localparam [6:0] groupB = 7'b0000011;      // i type
    localparam [6:0] groupC = 7'b0100011;      // s type
    localparam [6:0] groupD = 7'b0010011;      // i type and s type
    localparam [6:0] groupE = 7'b0110011;      // r type, groupE does not contain instructions that contain immediates
    localparam [6:0] FENCE  = 7'b0001111;      // 
    localparam [6:0] groupF = 7'b1110011;      // i type
   
    always@(*)
        begin
        case(instruction[6:0])
            LUI:
                begin
                immediate <= { instruction[31], instruction[30:20], instruction[19:12], 12'b000000000000 }; // u type
                end
            AUIPC:
                begin
                immediate <= { instruction[31], instruction[30:20], instruction[19:12], 12'b000000000000 }; // u type
                end
            JAL:
                begin
                immediate <= { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], 1'b0}; // j type
                end
            JALR:
                begin
                immediate <= { {21{instruction[31]}},  instruction[30:25], instruction[24:21], instruction[20]}; // i type
                end    
            groupA:
                begin
                immediate <= { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // b type
                end
            groupB:
                begin
                immediate <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]}; // i type
                end
            groupC:
                begin
                immediate <= { {21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]}; // s type
                end
            groupD:               
                begin
                immediate <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]}; // i type   
                end
            groupE:             // r type, groupE does not contain instructions that contain immediates
                begin
                end
            FENCE:
                begin
                
                end
            groupF:
                begin
                immediate <= { {21{instruction[31]}},  instruction[30:25], instruction[24:21], instruction[20]}; // i type
                end
        endcase        
        end
endmodule
