`timescale 1ns / 1ps

module instructionMemory
    (
    input [31:0] instructionAddress,
    output [31:0] instruction
    );
    
    reg [31:0] mem [0:31];
    initial
        begin
        
        // $readmemh("lui.mem",mem);           // lui
        
        // $readmemh("auipc.mem",mem);         // auipc
        
        // $readmemh("jal.mem",mem);           // jal
        
        // $readmemh("jalr.mem",mem);          // jalr 
        
        // $readmemh("groupA.mem",mem);        // groupA instructions (beq, bne, blt, bge, bltu, bgeu)
        
        // $readmemh("groupB.mem",mem);        // groupB instrucitons (lb, lh, lw, lbu, lhu)  
        
        // $readmemh("groupC.mem",mem);        // groupC instructions (sb, sh, sw)
        
        // $readmemh("groupD.mem",mem);        // groupD instructions (addi, slti, sltiu, xori, ori, andi, slli, srli, srai)
        
        // $readmemh("groupE.mem",mem);        // groupE instructions (add, sub, sll, slt, sltu, xor, srl, sra, or, and)
        
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        
        // INSTRUCTIONS BELOW WERE WRITTEN BY HAND FOR TEST PURPOSES - ALL RV32I INSTRUCTIONS EXCEPT FENCE, ECALL, EBEAK
        
        //lui
        //mem[0] = 32'b00000000000000000001_00010_0110111; // lui  
        
        // auipc
        //mem[0] = 32'b00000000000000000001_00010_0010111; // auipc 
        
        // jal
        //mem[0] = 32'b00000101000000000000_00010_1101111; // jal !!! NOTE: this ins. contains immediate value of 80 !!!
        
        // jalr
       // mem[0] = 32'b000000010000_00000_000_00010_1100111; // jalr !!! this ins. contains immediate value of 16 !!! 

        // groupA
        //mem[0] = 32'b0000010_00001_00000_000_01000_1100011; // beq !!! NOTE: this ins. contains immediate value of 72 !!!
        //mem[0] = 32'b0000010_00001_00000_001_01000_1100011; // bne !!! NOTE: this ins. contains immediate value of 72 !!!             
        //mem[0] = 32'b0000010_00001_00000_100_01000_1100011; // blt !!! NOTE: this ins. contains immediate value of 72 !!!
        //mem[0] = 32'b0000010_00001_00000_101_01000_1100011; // bge !!! NOTE: this ins. contains immediate value of 72 !!!
        //mem[0] = 32'b0000010_00001_00000_110_01000_1100011; // bltu !!! NOTE: this ins. contains immediate value of 72 !!!
        //mem[0] = 32'b0000010_00001_00000_111_01000_1100011; // bgeu !!! NOTE: this ins. contains immediate value of 72 !!! 
        
        // groupB
        //mem[0] = 32'b000000000001_00000_000_00011_0000011; // lb 
        //mem[0] = 32'b000000000001_00000_001_00011_0000011; // lh
        //mem[0] = 32'b000000000001_00000_010_00011_0000011; // lw
        //mem[0] = 32'b000000000001_00000_100_00011_0000011; // lbu
        //mem[0] = 32'b000000000001_00000_101_00011_0000011; // lhu
        
        // groupC
        //mem[0] = 32'b0000000_00001_00000_000_00010_0100011; // sb
        //mem[1] = 32'b0000000_00001_00000_001_00011_0100011; // sh
        //mem[2] = 32'b0000000_00001_00000_010_00100_0100011; // sw
        
        // groupD
        //mem[0] = 32'b000000000011_00000_000_00010_0010011; // addi
        //mem[0] = 32'b000000000001_00000_010_00010_0010011; // slti
        //mem[0] = 32'b000000000011_00000_011_00010_0010011; // sltiu
        //mem[0] = 32'b000000011111_00000_100_00010_0010011; // xori
        //mem[0] = 32'b000000000111_00000_110_00010_0010011; // ori
        //mem[0] = 32'b000000011111_00000_111_00010_0010011; // andi
        //mem[0] = 32'b100000000011_00000_001_00010_0010011; // slli
        //mem[0] = 32'b100000000011_00000_101_00010_0010011; // srli
        //mem[0] = 32'b110000000011_00000_101_00010_0010011; // srai
        
        // groupE
        //mem[0] = 32'b00000_00_00001_00000_000_00010_0110011; // add
        //mem[0] = 32'b01000_00_00001_00000_000_00010_0110011; // sub
        //mem[0] = 32'b00000_00_00001_00000_001_00010_0110011; // sll
        //mem[0] = 32'b00000_00_00001_00000_010_00010_0110011; // slt
        //mem[0] = 32'b00000_00_00001_00000_011_00010_0110011; // sltu
        //mem[0] = 32'b00000_00_00001_00000_100_00010_0110011; // xor
        //mem[0] = 32'b00000_00_00001_00000_101_00010_0110011; // srl
        //mem[0] = 32'b01000_00_00001_00000_101_00010_0110011; // sra
        //mem[0] = 32'b00000_00_00001_00000_110_00010_0110011; // or
        //mem[0] = 32'b00000_00_00001_00000_111_00010_0110011; // and
        
        end
        
    assign instruction =  mem [instructionAddress[31:2]];
endmodule
