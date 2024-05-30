`include "./components/Decoder.sv"
module Controller(Instruction, ALUControl, RegWrite, MemWrite, Branch, MemToReg, ALUScr);
    parameter BITS = 32;
    input wire [BITS-1:0] Instruction;

    output reg [0:63] Imm;
    output reg [0:1] ALUControl;
    output reg RegWrite, MemWrite, Branch, MemToReg;
    output reg ALUScr;

    Decoder decoder(
        .OpCode(Instruction[6:2]),
        .funct1(Instruction[14:12]),
        .funct2(Instruction[30]),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .ALUScr(ALUScr));


endmodule