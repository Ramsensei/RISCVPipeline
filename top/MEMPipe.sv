`include "./components/Memory.sv"
module MEMPipe(clk, ALUResult, WriteData, MemWrite, MemData);

    input wire clk;
    input wire [63:0] ALUResult, WriteData;
    input wire MemWrite;
    output reg [63:0] MemData;

    Memory #(1024, 64) mem(
        .clk(clk),
        .address(ALUResult[9:0]),
        .writeData(WriteData),
        .writeEn(MemWrite),
        .readData(MemData));


endmodule