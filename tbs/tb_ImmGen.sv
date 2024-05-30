`include "./components/ImmGen.sv"
module tb_ImmGen();

    reg [0:4] OpCode;
    reg [0:11] InstructionP1;
    reg [0:4] InstructionP2;
    wire [0:63] Imm;

    ImmGen immGen(
        .OpCode(OpCode),
        .InstructionP1(InstructionP1),
        .InstructionP2(InstructionP2),
        .Imm(Imm));

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_ImmGen);
        OpCode = 5'b00000;
        InstructionP1 = 12'b111111111101;
        InstructionP2 = 5'b00000;
        #10;
        $display("Imm = %b", Imm);
        OpCode = 5'b01000;
        InstructionP1 = 12'b111111100000;
        InstructionP2 = 5'b11101;
        #10;
        $display("Imm = %b", Imm);
        OpCode = 5'b11000;
        InstructionP1 = 12'b011110100000;
        InstructionP2 = 5'b10110;
        #10;
        $display("Imm = %b", Imm);
        OpCode = 5'b11111;
        InstructionP1 = 12'b001011101011;
        InstructionP2 = 5'b10011;
        #10;
        $display("Imm = %b", Imm);
        $finish;
    end

endmodule
