module Decoder (OpCode, funct1, funct2, ALUControl, RegWrite, MemWrite, Branch, MemToReg, ALUScr);

    input wire [0:4] OpCode;
    input wire [0:2] funct1;
    input wire funct2;
    output reg [0:1] ALUControl;
    output reg RegWrite, MemWrite, Branch, MemToReg;
    output reg ALUScr;

    always_comb begin
        case (OpCode)
            5'b00000: begin
                ALUControl = 2'b00;
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b1;
                ALUScr = 1'b1;
            end
            5'b01000: begin
                ALUControl = 2'b00;
                RegWrite = 1'b0;
                MemWrite = 1'b1;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUScr = 1'b1;
            end
            5'b01100: begin
                if (funct1 == 3'b000) ALUControl = funct2 ? 2'b01 : 2'b00;
                else ALUControl = funct1[2] ? 2'b10 : 2'b11;
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUScr = 1'b0;
            end
            5'b11000: begin
                ALUControl = 2'b01;
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b1;
                MemToReg = 1'b0;
                ALUScr = 1'b0;
            end
            5'b00100: begin
                ALUControl = 2'b00;
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUScr = 1'b1;
            end
            default: begin
                ALUControl = 2'b00;
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                MemToReg = 1'b0;
                ALUScr = 1'b0;
            end
            
        endcase
    end
    
endmodule