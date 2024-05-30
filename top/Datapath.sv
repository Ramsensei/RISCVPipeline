`define TOP
`include "Register_File.sv"
`include "Alu.sv"
`include "Memory.sv"
`include "Register.sv"
`include "Mux.sv"
`include "Shifter.sv"
`include "InstMemory.sv"
`include "Adder.sv"
`include "Hot_Bit.sv"
`include "PCRegister.sv"
module Datapath(clk, rst, Instruction, ALUControl, RegWrite, MemWrite, Branch, MemToReg, ALUScr, Imm);
    parameter BITS = 64;
    input wire clk;
    input wire rst;
    input wire [1:0] ALUControl;
    input wire RegWrite, MemWrite, Branch, MemToReg;
    input wire ALUScr;
    input wire [BITS-1:0] Imm;
    output reg [31:0] Instruction;

    wire [BITS-1:0] PCm4;
    wire [BITS-1:0] instAdd;
    wire [BITS-1:0] BranchMux [1:0];
    wire [BITS-1:0] ALUMux [1:0];
    wire [BITS-1:0] WBMux [1:0];
    wire [BITS-1:0] SrcA, SrcB;
    wire [BITS-1:0] ShiftedImm;
    wire [BITS-1:0] WriteBack;
    wire [3:0] ALUFlags;
    reg selBranch;

    PCRegister #(BITS) PC(.clk(clk), .rst(rst), .writeData(PCm4), .writeEn(1'b1), .read(instAdd));
    Adder #(BITS) PCAdder(.a(instAdd), .b(64'h1), .cin(1'b0), .sum(BranchMux[0]), .cout());
    Shifter #(BITS) ImmShifter(.data(Imm), .out(ShiftedImm));
    Adder #(BITS) BAdder(.a(instAdd), .b(ShiftedImm), .cin(1'b0), .sum(BranchMux[1]), .cout());
    assign selBranch = Branch & ALUFlags[0];
    Mux #(2, BITS) PCMux(.Data_arr(BranchMux), .selector(selBranch), .Out(PCm4));

    InstMemory #(1024, 32) instMem(.address(instAdd[9:0]), .readData(Instruction));
    Register_File regFile(.clk(clk), .address1(Instruction[19:15]), .address2(Instruction[24:20]), .addressw(Instruction[11:7]), .writeData(WriteBack), .writeEn(RegWrite), .read1(SrcA), .read2(ALUMux[0]));
    assign ALUMux[1] = Imm;
    Mux #(2, BITS) ALUScrMux(.Data_arr(ALUMux), .selector(ALUScr), .Out(SrcB));

    Alu #(BITS) alu(.SrcA(SrcA), .SrcB(SrcB), .ALUControl(ALUControl), .ALUResult(WBMux[0]), .ALUFlags(ALUFlags));
    Memory #(1024, 64) mem(.clk(clk), .address(WBMux[0][9:0]), .writeData(ALUMux[0]), .writeEn(MemWrite), .readData(WBMux[1]));
    Mux #(2, BITS) WBMuxMux(.Data_arr(WBMux), .selector(MemToReg), .Out(WriteBack));
    

endmodule
