`include "Controller.sv"
`include "Datapath.sv"
module top(clk, rst);
    
    input wire clk;
    input wire rst;
    wire [31:0] Instruction;
    wire [1:0] ALUControl;
    wire RegWrite, MemWrite, Branch, MemToReg;
    wire ALUScr;
    wire [63:0] Imm;

    Controller control(Instruction, ALUControl, RegWrite, MemWrite, Branch, MemToReg, ALUScr, Imm);
    Datapath datapath(clk, rst, Instruction, ALUControl, RegWrite, MemWrite, Branch, MemToReg, ALUScr, Imm);


endmodule