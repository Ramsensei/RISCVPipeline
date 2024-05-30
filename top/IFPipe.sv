`include "./components/PCRegister.sv"
`include "./components/InstMemory.sv"
`ifndef TOP
`include "./components/Mux.sv"
`include "./components/Adder.sv"
`endif // TOP
module IFPipe (clk, rst, BranchAddr, Branch, PCWrite, PC, Instruction);

    input wire [11:0] BranchAddr;
    input wire Branch, PCWrite, clk, rst;
    output reg [11:0] PC;
    output reg [31:0] Instruction;

    wire [11:0] PCIn; 
    wire [11:0] BranchMux [1:0];

    PCRegister #(12) PCReg(.clk(clk), .rst(rst), .writeData(PCIn), .writeEn(PCWrite), .read(PC));
    Adder #(12) PCAdder(.a(PC), .b(12'h4), .cin(1'b0), .sum(BranchMux[0]), .cout());
    assign BranchMux[1] = BranchAddr;
    Mux #(2, 12) PCMux(.Data_arr(BranchMux), .selector(Branch), .Out(PCIn));
    InstMemory #(1024, 32) IMem(.address(PC), .readData(Instruction));


endmodule