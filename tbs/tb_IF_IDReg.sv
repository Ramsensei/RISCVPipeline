`include "./top/IF_IDReg.sv"
module tb_IF_IDReg();

reg clk;
reg [11:0] IF_PC;
reg [31:0] IF_Instruction;
reg [11:0] ID_PC;
reg [31:0] ID_Instruction;

IF_IDReg dut (.IF_PC(IF_PC), .IF_Instruction(IF_Instruction), .ID_PC(ID_PC), .ID_Instruction(ID_Instruction), .clk(clk));

initial begin
    clk = 0;
    forever begin
        clk = ~clk;
        #5;
    end
end

initial begin
    $dumpfile("pv.vcd");
    $dumpvars(0, tb_IF_IDReg);
    IF_PC = 12'h0;
    IF_Instruction = 32'h0;
    #10;
    IF_PC = 12'h4;
    IF_Instruction = 32'h4;
    #10;
    IF_PC = 12'h8;
    IF_Instruction = 32'h8;
    #10;
    IF_PC = 12'hC;
    IF_Instruction = 32'hC;
    #10;
    $finish;
end

endmodule