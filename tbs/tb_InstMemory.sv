`include "./components/InstMemory.sv"
module tb_InstMemory();

    reg [4:0] address;
    wire [31:0] readData;

    InstMemory #(.DEPTH(32), .BITS(32)) instMemory(.address(address), .readData(readData));

    // initial begin
    //     clk = 0;
    //     forever begin
    //         clk = ~clk;
    //         #5;
    //     end
    // end

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_InstMemory);
        
        address = 0;
        #10 address = 4;
        #10 address = 8;
        #10 address = 12;
        #10 address = 16;
        #10 address = 20;
        #10 address = 24;
        #10 address = 28;
        #10 address = 32;
        $finish;

    end

endmodule
