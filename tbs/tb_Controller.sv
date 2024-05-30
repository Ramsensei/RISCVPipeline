`include "./components/Controller.sv"
module tb_Controller();
    reg [0:31] Instruction;
    reg [0:63] Imm;
    reg [0:1] ALUControl;
    reg RegWrite, MemWrite, Branch, MemToReg;
    reg ALUScr;

    Controller controller(
        .Instruction(Instruction),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .MemToReg(MemToReg),
        .ALUScr(ALUScr),
        .Imm(Imm));

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_Controller);
        Instruction = 32'b00110110101000110011010100000011;
        #10;
        Instruction = 32'b00110110101000110011010100100011;
        #10;
        Instruction = 32'b00000000101000110000010100110011;
        #10;
        Instruction = 32'b01000000101000110000010100110011;
        #10;
        Instruction = 32'b00000000101000110111010100110011;
        #10;
        Instruction = 32'b00000000101000110110010100110011;
        #10;
        Instruction = 32'b00010100101000110000010101100011;
        #10;
        Instruction = 32'b00000000000000000000000000000000;
        #10;
        $finish;
    end
endmodule