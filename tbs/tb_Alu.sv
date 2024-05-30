`include "./components/Alu.sv"
module tb_Alu();

reg [0:64-1] SrcA, SrcB;
reg [0:1] ALUControl;
reg [0:64-1] ALUResult;
reg [0:3] ALUFlags;

Alu dut (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .ALUFlags(ALUFlags)
);


// initial begin
//     clk = 0;
//     forever begin
//         clk = ~clk;
//         #5;
//     end
// end

initial begin
    $dumpfile("pv.vcd");
    $dumpvars(0, tb_Alu);
    
    // Test for the Alu
    // Test sum
    SrcA = 105;
    SrcB = 215;
    ALUControl = 2'b00;
    #10;
    if (ALUResult !== (SrcA + SrcB)) begin
        $display("Test sum failed");
    end

    // Test sub
    SrcA = 105;
    SrcB = 105;
    ALUControl = 2'b01;
    #10;
    if (ALUResult !== (SrcA-SrcB)) begin
        $display("Test sub failed");
    end

    // Test and
    SrcA = 105;
    SrcB = 215;
    ALUControl = 2'b10;
    #10;
    if (ALUResult !== (SrcA & SrcB)) begin
        $display("Test and failed");
    end

    // Test or
    SrcA = 105;
    SrcB = 215;
    ALUControl = 2'b11;
    #10;
    if (ALUResult !== (SrcA | SrcB)) begin
        $display("Test or failed");
    end

    #10;


    $finish;
end


endmodule