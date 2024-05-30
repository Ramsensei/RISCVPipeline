module EX_MEMReg(clk, EX_ALUResult, EX_WriteData, EX_rd, EX_RegWrite, EX_MemToReg, EX_MemWrite
                    , MEM_ALUResult, MEM_WriteData, MEM_rd, MEM_RegWrite, MEM_MemToReg, MEM_MemWrite);
    
    input wire clk;
    input wire [63:0] EX_ALUResult, EX_WriteData;
    input wire [4:0] EX_rd;
    input wire EX_RegWrite, EX_MemToReg, EX_MemWrite;
    output reg [63:0] MEM_ALUResult, MEM_WriteData;
    output reg [4:0] MEM_rd;
    output reg MEM_RegWrite, MEM_MemToReg, MEM_MemWrite;

    reg innerClk; // internal clock for emulate the setup & hold time
    reg [63:0] ALUResult, WriteData;
    reg [4:0] rd;
    reg RegWrite, MemToReg, MemWrite;

   

    always_ff @(posedge innerClk) begin
        ALUResult <= EX_ALUResult;
        WriteData <= EX_WriteData;
        rd <= EX_rd;
        RegWrite <= EX_RegWrite;
        MemToReg <= EX_MemToReg;
        MemWrite <= EX_MemWrite;
    end

    always_ff @(posedge clk) begin
        MEM_ALUResult <= ALUResult;
        MEM_WriteData <= WriteData;
        MEM_rd <= rd;
        MEM_RegWrite <= RegWrite;
        MEM_MemToReg <= MemToReg;
        MEM_MemWrite <= MemWrite;
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