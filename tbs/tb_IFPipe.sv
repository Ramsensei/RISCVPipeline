`include "./top/IFPipe.sv"
module tb_pv();

reg clk, rst;
reg [11:0] BranchAddr, PC;
reg Branch, PCWrite;
reg [31:0] Instruction;

IFPipe dut (.clk(clk), .rst(rst), .BranchAddr(BranchAddr), .Branch(Branch), .PCWrite(PCWrite), .PC(PC), .Instruction(Instruction));

initial begin
    clk = 0;
    forever begin
        clk = ~clk;
        #5;
    end
end

initial begin
    $dumpfile("pv.vcd");
    $dumpvars(0, tb_pv);
    rst = 1;
    #10;
    rst = 0;
    PCWrite = 1;
    Branch = 0;
    BranchAddr = 12'h0;
    #80;
    PCWrite = 1;
    Branch = 1;
    BranchAddr = 12'h4;
    #10;


    $finish;
end


endmodule