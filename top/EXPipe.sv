`include "./components/Alu.sv"
module EXPipe(data1, data2, Imm, Fw1, Fw2, Fw3, SelFwA, SelFwB, ALUScr, ALUControl, ALUResult, WriteData);

    input wire [63:0] data1, data2, Imm, Fw1, Fw2, Fw3;
    input wire [1:0] SelFwA, SelFwB;
    input wire ALUScr, ALUControl;
    output reg [63:0] ALUResult;
    output reg [63:0] WriteData;

    reg [63:0] ALUIn1, ALUIn2, FwBOut;
    reg [63:0] FwAData [3:0];
    reg [63:0] FwBData [3:0];
    reg [63:0] ScrData [1:0];

    assign FwAData[0] = data1;
    assign FwAData[1] = Fw1;
    assign FwAData[2] = Fw2;
    assign FwAData[3] = Fw3;

    assign FwBData[0] = data2;
    assign FwBData[1] = Fw1;
    assign FwBData[2] = Fw2;
    assign FwBData[3] = Fw3;

    Mux #(4, 64) FwAMux(.Data_arr(FwAData), .selector(SelFwA), .Out(ALUIn1));
    Mux #(4, 64) FwBMux(.Data_arr(FwBData), .selector(SelFwB), .Out(FwBOut));

    assign ScrData[0] = FwBOut;
    assign ScrData[1] = Imm;

    Mux #(2, 64) ScrMux(.Data_arr(ScrData), .selector(ALUScr), .Out(ALUIn2));

    Alu alu(
        .a(ALUIn1),
        .b(ALUIn2),
        .control(ALUControl),
        .result(ALUResult));

    assign WriteData = FwBOut;

endmodule