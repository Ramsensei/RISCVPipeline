`include "./components/Hot_Bit.sv"
module tb_Hot_Bit();

    reg [2:0] index;
    wire [7:0] Out;

    Hot_Bit #(.DEPTH(8)) hot_bit(.index(index), .Out(Out));

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_Hot_Bit);
        index = 0;
        #10 index = 1;
        #10 index = 2;
        #10 index = 3;
        #10 index = 4;
        #10 index = 5;
        #10 index = 6;
        #10 index = 7;
        #10 index = 0;
        $finish;
    end

    always @(Out) begin
        $display("Out = %b", Out);
    end

endmodule