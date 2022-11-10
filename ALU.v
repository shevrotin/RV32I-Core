`timescale 1ns / 1ps

module ALU
    (
    input [7:0] selectOperation,                              // function select
    input [31:0] dataOne,                                     // data inputs
    input [31:0] dataTwo,   
    output reg [31:0] result,                                 // data output 
    output reg overflow, carry, negative, zero                // status outputs
    );
    
    // LUI
    localparam [7:0] LUI   = 8'b00000000;
    
    // AUIPC 
    localparam [7:0] AUIPC = 8'b00000001;
    
    // JAL
    localparam [7:0] JAL   = 8'b00000010;                       // 0000 + ALUOp by ALUControl    
    
    // JALR
    localparam [7:0] JALR  = 8'b00000011;
    
    // groupA
    localparam [7:0] BEQ   = 8'b00000100;
    localparam [7:0] BNE   = 8'b00010100;
    localparam [7:0] BLT   = 8'b01000100;
    localparam [7:0] BGE   = 8'b01010100;
    localparam [7:0] BLTU  = 8'b01100100;
    localparam [7:0] BGEU  = 8'b01110100;
    
    // groupB
    localparam [7:0] LB    = 8'b00000101;                       // 0 + funct3 + ALUOp by ALUControl
    localparam [7:0] LH    = 8'b00010101;
    localparam [7:0] LW    = 8'b00100101;
    localparam [7:0] LBU   = 8'b01000101;
    localparam [7:0] LHU   = 8'b01010101;
    
    // groupC
    localparam [7:0] SB    = 8'b00000110;
    localparam [7:0] SH    = 8'b00010110;
    localparam [7:0] SW    = 8'b00100110;  
    
    // groupD   
    localparam [7:0] ADDI  = 8'b00000111;                        // 0 + funct3 + ALUOp by ALUControl
    localparam [7:0] SLTI  = 8'b00100111;                        // 0 + funct3 + ALUOp by ALUControl
    localparam [7:0] SLTIU = 8'b00110111;                        // 0 + funct3 + ALUOp by ALUControl   
    localparam [7:0] XORI  = 8'b01000111;                        // 0 + funct3 + ALUOp by ALUControl   
    localparam [7:0] ORI   = 8'b01100111;                        // 0 + funct3 + ALUOp by ALUControl
    localparam [7:0] ANDI  = 8'b01110111;                        // 0 + funct3 + ALUOp by ALUControl
    
    localparam [7:0] SLLI  = 8'b00010111;                        // 0 + funct3 + ALUOp by ALUControl
    
    localparam [7:0] SRLI  = 8'b01010111;                        // bit30 + funct3 + ALUOp by ALUControl   
    localparam [7:0] SRAI  = 8'b11010111;                        // bit30 + funct3 + ALUOp by ALUControl
    
    // groupE
    localparam [7:0] ADD  = 8'b00001000;                         // bit30 + func3 + ALUOp by ALUControl
    localparam [7:0] SUB  = 8'b10001000;
    localparam [7:0] SLL  = 8'b00011000;
    localparam [7:0] SLT  = 8'b00101000;
    localparam [7:0] SLTU = 8'b00111000;
    localparam [7:0] XOR  = 8'b01001000;
    localparam [7:0] SRL  = 8'b01011000;
    localparam [7:0] SRA  = 8'b11011000;
    localparam [7:0] OR   = 8'b01101000;
    localparam [7:0] AND  = 8'b01111000;
    
    always@(*)
        begin
        zero = 0;
        case(selectOperation)
            
            LUI:
                begin
                result = dataTwo;
                end
            
            AUIPC:
                begin
                zero = 1;
                result = dataTwo;
                end
                 
            JAL:
                begin
                zero = 1;
                result = dataTwo;
                end
            
            JALR:
                begin
                zero = 1;
                result = dataOne + dataTwo;
                end
            
            //groupA
            BEQ:
                begin
                if(dataOne == dataTwo)
                    begin
                    zero = 1;
                    end
                else
                    begin
                    zero = 0;
                    end
                end
            BNE:
                begin
                if(dataOne != dataTwo)
                    begin
                    zero = 1;
                    end
                else
                    begin
                    zero = 0;
                    end     
                end
            BLT:
                begin
                if($signed(dataOne) < $signed(dataTwo))
                    begin
                    zero = 1;
                    end
                else
                    begin
                    zero = 0; 
                    end         
                end
            BGE:
                begin
                if($signed(dataOne) >= $signed(dataTwo))
                    begin
                    zero = 1;
                    end
                else
                    begin
                    zero = 0;
                    end     
                end
            BLTU:
                begin
                if(dataOne < dataTwo)
                    begin
                    zero = 1;
                    end
                else
                    begin
                    zero = 0; 
                    end 
                end
            BGEU:
                begin
                if(dataOne >= dataTwo)
                    begin
                    zero = 1;
                    end
                else
                    begin
                    zero = 0; 
                    end    
                end
            
            //groupB
            LB:
                begin
                result = dataOne + dataTwo;
                end
            LH:
                begin
                result = dataOne + dataTwo;
                end
            LW:
                begin
                result = dataOne + dataTwo;
                end
            LBU:
                begin
                result = dataOne + dataTwo;
                end
            LHU:
                begin
                result = dataOne + dataTwo;
                end
            
            //groupC 
            SB:
                begin
                result = dataOne + dataTwo;
                end
            SH:
                begin
                result = dataOne + dataTwo;
                end
            SW:
                begin
                result = dataOne + dataTwo;
                end
            
            // groupD
            ADDI:
                begin
                result = dataOne + dataTwo;
                end
            SLTI:
                begin
                if($signed(dataOne) < $signed(dataTwo))
                    begin
                    result = 1;
                    end
                else
                    begin
                    result = 0;
                    end
                end 
            SLTIU:
                begin
                if(dataOne < dataTwo)
                    begin
                    result = 1;
                    end
                else
                    begin
                    result = 0;
                    end
                end  
            XORI:   
                begin
                result = dataOne ^ dataTwo;
                end
            ORI:
                begin
                result = dataOne | dataTwo;
                end   
            ANDI:
                begin
                result = dataOne & dataTwo;
                end 
            SLLI:
                begin
                result = dataOne << dataTwo[4:0];
                end
            SRLI:
                begin
                result = dataOne >> dataTwo[4:0];
                end 
            
            // groupE
            ADD:
                begin
                result = dataOne + dataTwo;
                end
            SUB:
                begin
                result = dataOne - dataTwo;
                end
            SLL:
                begin
                result = dataOne << dataTwo[4:0];
                end
            SLT:
                begin
                if($signed(dataOne) < $signed(dataTwo))
                    begin
                    result = 1;
                    end
                else
                    begin
                    result = 0;
                    end
                end
            SLTU:
                begin
                if(dataOne < dataTwo)
                    begin
                    result = 1;
                    end
                else
                    begin
                    result = 0;
                    end
                end
            XOR:    
                begin
                result = dataOne ^ dataTwo;
                end
            SRL:
                begin
                result = dataOne >> dataTwo[4:0];
                end
            
            // IMPORTANT: Verilog Arithmetic rigth shift operator only actually performs
            // an arithmetic shift if the first operand is signed. If the first operand
            // is unsigned, the operator actually performs a logical right shift.
            
            SRA:
                begin
                result = $signed(dataOne) >>> dataTwo[4:0];   // notice $signed(dataOne)
                end
            OR:
                begin
                result = dataOne | dataTwo;
                end
            AND: 
                begin
                result = dataOne & dataTwo;
                end
            
            // IMPORTANT: Verilog Arithmetic rigth shift operator only actually performs
            // an arithmetic shift if the first operand is signed. If the first operand
            // is unsigned, the operator actually performs a logical right shift.
            SRAI:
                begin
                result = $signed(dataOne) >>> dataTwo[4:0];   // notice $signed(dataOne)
                end 
        endcase
        end
endmodule

