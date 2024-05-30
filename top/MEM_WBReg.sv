module EX_MEMReg(clk, MEM_MemData, MEM_ALUResult, MEM_rd, MEM_MemToReg, MEM_RegWrite,
                    WB_MemData, WB_ALUResult, WB_rd, WB_MemToReg, WB_RegWrite);

    input wire clk;
    input wire [63:0] MEM_MemData, MEM_ALUResult;
    input wire [4:0] MEM_rd;
    input wire MEM_MemToReg, MEM_RegWrite;
    output reg [63:0] WB_MemData, WB_ALUResult;
    output reg [4:0] WB_rd;
    output reg WB_MemToReg, WB_RegWrite;

    reg innerClk; // internal clock for emulate the setup & hold time
    reg [63:0] MemData, ALUResult;
    reg [4:0] rd;
    reg MemToReg, RegWrite;   

    always_ff @(posedge innerClk) begin
        MemData <= MEM_MemData;
        ALUResult <= MEM_ALUResult;
        rd <= MEM_rd;
        MemToReg <= MEM_MemToReg;
        RegWrite <= MEM_RegWrite;
    end

    always_ff @(posedge clk) begin
        WB_MemData <= MemData;
        WB_ALUResult <= ALUResult;
        WB_rd <= rd;
        WB_MemToReg <= MemToReg;
        WB_RegWrite <= RegWrite;
    end

    initial begin
        innerClk = 0;
        #1;
        forever begin
            #8 innerClk = ~innerClk; // emulate the setup & hold time
            #2 innerClk = ~innerClk; // emulate the setup & hold time
        end
    end

endmodule