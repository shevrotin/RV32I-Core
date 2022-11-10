`timescale 1ns / 1ps

module core
    (
    input clk, rst
    );
    
    wire [31:0] instruction;
    wire [31:0] regFileToALU1, regFileToALU2;
    
    wire [31:0] PCToSome;
    wire [31:0] immGenToSome;
    wire [31:0] regFileToSome;
    
    wire [31:0] muxALUToALU;
    wire [31:0] ALUToSome;
    wire [31:0] ALUToDataMem;
    wire [7:0] ALUControlToALU;
    wire ALUToAndGate;

    wire [31:0] dataMemToMuxDataMem;
    wire [31:0] muxDataMemToRegFile;
    
    wire andGateToMuxBranch;
    wire [31:0] adderToMuxBranch;
    wire [31:0] adder2ToMuxBranch;
    wire [31:0] muxBranchToPC;
    wire [31:0] shiftLeftToAdder2;
    wire [31:0] muxShiftLeftToShiftLeft;
    wire [31:0] shiftLeftToMuxAdder2;
    wire [31:0] muxAdder2ToAdder2;
    
    wire controlToMuxShiftLeft;
    wire controlToMuxALU;
    wire controlToMuxAdder2;
    wire controlToMuxDataMem;
    wire controlToAndGate;
    wire controlToDataMem1;
    wire controlToDataMem2;
    wire controlToRegFile;
    wire [3:0] controlToALUControl;
    
    programCounter duty1
    (
    .clk(clk), 
    .rst(rst), 
    .nextPC(muxBranchToPC), 
    .currentPC(PCToSome)
    );

    adder duty2
    (
    .inAdder(PCToSome), 
    .outAdder(adderToMuxBranch)
    );
    
    muxShiftLeft duty3
    (
    .optionOne(immGenToSome),
    .optionTwo(ALUToSome),
    .selection(controlToMuxShiftLeft),
    .chosenOption(muxShiftLeftToShiftLeft)
    );
    
    shiftLeft duty4
    (
    .shifterInput(muxShiftLeftToShiftLeft),
    .shifterOutput(shiftLeftToMuxAdder2)
    );
    
    muxAdder2 duty5
    (
    .optionA(immGenToSome),
    .optionB(shiftLeftToMuxAdder2),
    .selection(controlToMuxAdder2),
    .chosenOption(muxAdder2ToAdder2)
    );
    
    adder2 duty6
    (
    .inAdderOne(PCToSome),
    .inAdderTwo(muxAdder2ToAdder2),
    .outAdder(adder2ToMuxBranch)
    );
    
    andGate duty7
    (
    .a(controlToAndGate),
    .b(ALUToAndGate),
    .c(andGateToMuxBranch)
    );
    
    muxBranch duty8
    (
    .optionOne(adderToMuxBranch),
    .optionTwo(adder2ToMuxBranch),
    .selection(andGateToMuxBranch),
    .chosenOption(muxBranchToPC)
    );
    
    instructionMemory duty9
    (
    .instructionAddress(PCToSome), 
    .instruction(instruction)
    );
    
    registerFile duty10
    (
    .clk(clk),
    
    .readRegister1(instruction[19:15]),
    .readRegister2(instruction[24:20]),
    .readData1(regFileToALU1), 
    .readData2(regFileToSome),   
    
    .writeEnable(controlToRegFile), 
    .writeRegister(instruction[11:7]),
    .writeData(muxDataMemToRegFile)
    );
    
    immediateGenerator duty11
    (
    .instruction(instruction),
    .immediate(immGenToSome)
    );
    
    control duty12
    (
    .clk(clk), 
    .opcode(instruction[6:0]), 
    .ALUOp(controlToALUControl), 
    .regWrite(controlToRegFile),
    .ALUSrc(controlToMuxALU),
    .memRead(controlToDataMem1),
    .memWrite(controlToDataMem2),
    .memToReg(controlToMuxDataMem),
    .branch(controlToAndGate),
    .customControlOne(controlToMuxAdder2),
    .customControlTwo(controlToMuxShiftLeft)
    );
    
    ALUControl duty13
    (
    .ALUOp(controlToALUControl),
    .funct3(instruction[14:12]),
    .bit30(instruction[30]),
    .decision(ALUControlToALU)
    );
    
    muxALU duty14
    (
    .potentialOperandOne(regFileToSome),
    .potentialOperandTwo(immGenToSome),
    .selectOperand(controlToMuxALU),
    .chosenOperand(muxALUToALU)
    );
    
    ALU duty15
    (
    .selectOperation(ALUControlToALU), 
    .dataOne(regFileToALU1), 
    .dataTwo(muxALUToALU),
    .result(ALUToSome),
    .zero(ALUToAndGate)
    );
    
    dataMemory duty16
    (
    .clk(clk),
    .rst(rst),
    .address(ALUToSome),
    .funct3(instruction[14:12]),
    .writeData(regFileToSome),
    .memRead(controlToDataMem1),
    .memWrite(controlToDataMem2),
    .readData(dataMemToMuxDataMem)
    );
    
    muxDataMemory duty17
    (
    .selectData(controlToMuxDataMem),
    .potentialDataOne(dataMemToMuxDataMem),
    .potentialDataTwo(ALUToSome),
    .chosenData(muxDataMemToRegFile)
    );
    
endmodule
