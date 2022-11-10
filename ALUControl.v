`timescale 1ns / 1ps

module ALUControl
    (
    input [3:0] ALUOp,
    input [2:0] funct3,
    input bit30,
    
    output reg [7:0] decision
    );
    
    localparam [3:0] LUI    = 4'b0000;      // 0000
    localparam [3:0] AUIPC  = 4'b0001;      // 0001 
    localparam [3:0] JAL    = 4'b0010;      // 0010
    localparam [3:0] JALR   = 4'b0011;      // 0011
    
    localparam [3:0] groupA = 4'b0100;      // 0100
        localparam [2:0] BEQ  = 3'b000;
        localparam [2:0] BNE  = 3'b001;
        localparam [2:0] BLT  = 3'b100;
        localparam [2:0] BGE  = 3'b101;
        localparam [2:0] BLTU = 3'b110;
        localparam [2:0] BGEU = 3'b111;
    
    localparam [3:0] groupB = 4'b0101;      // 0101
        localparam [2:0] LB  = 3'b000;
        localparam [2:0] LH  = 3'b001;
        localparam [2:0] LW  = 3'b010;
        localparam [2:0] LBU = 3'b100;
        localparam [2:0] LHU = 3'b101;
    
    localparam [3:0] groupC = 4'b0110;      // 0110
        localparam [2:0] SB = 3'b000;
        localparam [2:0] SH = 3'b001;
        localparam [2:0] SW = 3'b010;
        
    localparam [3:0] groupD = 4'b0111;      // 0111
        localparam [2:0] ADDI  = 3'b000; 
        localparam [2:0] SLTI  = 3'b010;
        localparam [2:0] SLTIU = 3'b011;
        localparam [2:0] XORI  = 3'b100;
        localparam [2:0] ORI   = 3'b110;
        localparam [2:0] ANDI  = 3'b111;
        localparam [2:0] SLLI  = 3'b001;
        localparam [2:0] SRLI  = 3'b101;
        localparam [2:0] SRAI  = 3'b101;
        
    localparam [3:0] groupE = 4'b1000;      // 1000
        localparam [3:0] ADD  = 4'b0000;                                        
        localparam [3:0] SUB  = 4'b1000;
        localparam [3:0] SLL  = 4'b0001;
        localparam [3:0] SLT  = 4'b0010;
        localparam [3:0] SLTU = 4'b0011;
        localparam [3:0] XOR  = 4'b0100;
        localparam [3:0] SRL  = 4'b0101;
        localparam [3:0] SRA  = 4'b1101;
        localparam [3:0] OR   = 4'b0110;
        localparam [3:0] AND  = 4'b0111;
    
    localparam [3:0] FENCE  = 4'b1001;      // 1001
    
    localparam [3:0] groupF = 4'b1010;      // 1010
    
    always@(*)
        begin
        case(ALUOp)
           LUI:
                begin
                decision <= {4'b0000,ALUOp};
                end
           AUIPC:
                begin
                decision <= {4'b0000,ALUOp};
                end
           JAL:
                begin
                decision <= {4'b0000,ALUOp};
                end
           JALR:
                begin
                decision <= {1'b0,funct3,ALUOp};
                end
           groupA:
                begin
                decision <= {1'b0,funct3,ALUOp};
                end
           groupB:
                begin
                decision <= {1'b0,funct3,ALUOp};
                end
           groupC:
                begin
                decision <= {1'b0,funct3,ALUOp};
                end
           groupD:
                begin
                if(funct3 == 3'b101)
                    begin
                    if(bit30)
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    else 
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    end
                else if(funct3 == 3'b001)
                    begin
                    decision <= {1'b0,funct3,ALUOp};
                    end
                else
                    begin    
                    case(funct3)
                        ADDI:
                            begin
                            decision <= {1'b0,funct3,ALUOp};
                            end           
                        SLTI:             
                            begin         
                            decision <= {1'b0,funct3,ALUOp};
                            end           
                        SLTIU:            
                            begin         
                            decision <= {1'b0,funct3,ALUOp};
                            end           
                        XORI:             
                            begin         
                            decision <= {1'b0,funct3,ALUOp};
                            end           
                        ORI:              
                            begin         
                            decision <= {1'b0,funct3,ALUOp};
                            end           
                        ANDI:             
                            begin         
                            decision <= {1'b0,funct3,ALUOp};
                            end
                    endcase
                    end
                end
           groupE:
                begin
                case({bit30,funct3})
                    ADD:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    SUB:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    SLL:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    SLT:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    SLTU:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    XOR:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    SRL:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    SRA:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    OR:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                    AND:
                        begin
                        decision <= {bit30,funct3,ALUOp};
                        end
                endcase
                end
           FENCE:
                begin
                end
           groupF:
                begin
                end
        endcase
        end
endmodule
