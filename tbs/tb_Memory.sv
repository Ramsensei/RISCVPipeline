`include "./components/Memory.sv"
module tb_Memory();
    reg [7:0] address;
    reg [63:0] writeData;
    wire [63:0] readData;
    reg writeEn;
    reg clk;

    Memory #(.DEPTH(256), .BITS(64)) memory(.address(address), .writeData(writeData), .readData(readData), .writeEn(writeEn), .clk(clk));

    initial begin
        clk = 0;
        forever begin
            clk = ~clk;
            #5;
        end
    end

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_Memory);
        
        address = 0;
        writeData = 0;
        writeEn = 1;
        #10 address = 1;
        writeData = 1;
        #10 address = 2;
        writeData = 2;
        #10 address = 3;
        writeData = 3;
        #10 writeEn = 0;
        #10 address = 0;
        #10 address = 1;
        #10 address = 2;
        #10 address = 3;
        #10 address = 0;
        #10 $finish;

    end
endmodule