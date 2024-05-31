`define TOP
`include "./components/Mux.sv"
`include "./components/Adder.sv"
`include "./top/Controller.sv"
`include "./top/IFPipe.sv"
`include "./top/IDPipe.sv"
`include "./top/EXPipe.sv"
`include "./top/MEMPipe.sv"
`include "./top/WBPipe.sv"
`include "./top/IF_IDReg.sv"
`include "./top/ID_EXReg.sv"
`include "./top/EX_MEMReg.sv"
`include "./top/MEM_WBReg.sv"
`include "./components/HazardUnit.sv"
`include "./components/Fordwarding_Unit.sv"

module top(clk, rst);

    input clk;
    input rst;

    reg Branch, CtrBranch;
    wire [11:0] BranchAddr, IF_PC;
    wire PCWrite, IF_IDWrite, Flush;
    wire [31:0] IF_Instruction;

    wire [11:0] ID_PC;
    wire [31:0] ID_Instruction;

    wire [63:0] ID_data1, ID_data2, ID_Imm;
    wire [4:0] ID_rd, ID_rs1, ID_rs2;
    wire ID_RegWrite, ID_Equal, ID_MemWrite, ID_MemToReg, ID_ALUScr;
    wire [1:0] ID_ALUControl;

    wire [63:0] EX_data1, EX_data2, EX_Imm, EX_ALUResult, EX_WriteData;
    wire [4:0] EX_rd, EX_rs1, EX_rs2;
    wire EX_RegWrite, EX_MemWrite, EX_MemToReg, EX_ALUScr;
    wire [1:0] EX_ALUControl;

    wire [1:0] SelFwA, SelFwB;

    wire [63:0] MEM_ALUResult, MEM_WriteData, MEM_MemData;
    wire [4:0] MEM_rd;
    wire MEM_RegWrite, MEM_MemToReg, MEM_MemWrite;

    wire [4:0] WB_rd;
    wire [63:0] WB_data, WB_MemData, WB_ALUResult;
    wire WB_RegWrite, WB_MemToReg;

    IFPipe IFPipe(.clk(clk), .rst(rst), .BranchAddr(BranchAddr), .Branch(Branch), .PCWrite(PCWrite), .PC(IF_PC), .Instruction(IF_Instruction));

    IF_IDReg IF_IDReg(.clk(clk), .writeEn(IF_IDWrite), .IF_PC(IF_PC), .IF_Instruction(IF_Instruction), .ID_PC(ID_PC), .ID_Instruction(ID_Instruction));

    HazardUnit HazardUnit(.Branch(Branch), .Flush(Flush), .IF_IDWrite(IF_IDWrite), .PC_Write(PCWrite));

    IDPipe IDPipe(.clk(clk), .writeAddr(WB_rd), .writeData(WB_data), .Instruction(ID_Instruction), .PC(ID_PC), .RegWrite(WB_RegWrite),
                    .BranchAddr(BranchAddr), .Equal(ID_Equal), .data1(ID_data1), .data2(ID_data2), .Imm(ID_Imm), .rd(ID_rd), .rs1(ID_rs1), .rs2(ID_rs2));
    
    Controller Controller(.Instruction(ID_Instruction), .ALUControl(ID_ALUControl), .RegWrite(ID_RegWrite), .MemWrite(ID_MemWrite), .Branch(CtrBranch), .MemToReg(ID_MemToReg), .ALUScr(ID_ALUScr));
    assign Branch = CtrBranch && ID_Equal;


    ID_EXReg ID_EXReg(.clk(clk), .ID_data1(ID_data1), .ID_data2(ID_data2), .ID_Imm(ID_Imm),
                    .ID_rd(ID_rd), .ID_rs1(ID_rs1), .ID_rs2(ID_rs2), .ID_ALUControl(ID_ALUControl),
                    .ID_RegWrite(ID_RegWrite), .ID_MemWrite(ID_MemWrite), .ID_MemToReg(ID_MemToReg), .ID_ALUScr(ID_ALUScr),
                    .EX_data1(EX_data1), .EX_data2(EX_data2), .EX_Imm(EX_Imm),
                    .EX_rd(EX_rd), .EX_rs1(EX_rs1), .EX_rs2(EX_rs2), .EX_ALUControl(EX_ALUControl),
                    .EX_RegWrite(EX_RegWrite), .EX_MemWrite(EX_MemWrite), .EX_MemToReg(EX_MemToReg), .EX_ALUScr(EX_ALUScr));


    EXPipe EXPipe(.data1(EX_data1), .data2(EX_data2), .Imm(EX_Imm), .Fw1(MEM_MemData), .Fw2(MEM_ALUResult), .Fw3(WB_data), .SelFwA(SelFwA), .SelFwB(SelFwB), .ALUScr(EX_ALUScr), .ALUControl(EX_ALUControl), .ALUResult(EX_ALUResult), .WriteData(EX_WriteData));

    EX_MEMReg EX_MEMReg(.clk(clk), .EX_ALUResult(EX_ALUResult), .EX_WriteData(EX_WriteData), .EX_rd(EX_rd), .EX_RegWrite(EX_RegWrite), .EX_MemToReg(EX_MemToReg), .EX_MemWrite(EX_MemWrite),
                        .MEM_ALUResult(MEM_ALUResult), .MEM_WriteData(MEM_WriteData), .MEM_rd(MEM_rd), .MEM_RegWrite(MEM_RegWrite), .MEM_MemToReg(MEM_MemToReg), .MEM_MemWrite(MEM_MemWrite));


    Fordwarding_Unit ForwardUnit(.rs1(EX_rs1), .rs2(EX_rs2), .MEM_rd(MEM_rd), .WB_rd(WB_rd), .MEM_RegWrite(MEM_RegWrite), .WB_RegWrite(WB_RegWrite), .MemToReg(MEM_MemToReg), .FwASel(SelFwA), .FwBSel(SelFwB));

    MEMPipe MEMPipe(.clk(clk), .ALUResult(MEM_ALUResult), .WriteData(MEM_WriteData), .MemWrite(MEM_MemWrite), .MemData(MEM_MemData));

    MEM_WBReg MEM_WBReg(.clk(clk), .MEM_MemData(MEM_MemData), .MEM_ALUResult(MEM_ALUResult), .MEM_rd(MEM_rd), .MEM_MemToReg(MEM_MemToReg), .MEM_RegWrite(MEM_RegWrite),
                        .WB_MemData(WB_MemData), .WB_ALUResult(WB_ALUResult), .WB_rd(WB_rd), .WB_MemToReg(WB_MemToReg), .WB_RegWrite(WB_RegWrite));

    WBPipe WBPipe(.MemData(WB_MemData), .ALUResult(WB_ALUResult), .MemToReg(WB_MemToReg), .WriteData(WB_data));

endmodule