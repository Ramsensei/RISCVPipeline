`include "./components/Register_File.sv"
module tb_Register_File();

    reg clk;
    reg [4:0] address1, address2, addressw;
    reg [63:0] writeData;
    reg writeEn;
    wire [63:0] read1, read2;

    Register_File register_file(.clk(clk), .address1(address1), .address2(address2), .addressw(addressw), .writeData(writeData), .writeEn(writeEn), .read1(read1), .read2(read2));

    initial begin
        clk = 0;
        forever begin
            clk = ~clk;
            #5;
        end
    end

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_Register_File);
        address1 = 0;
        address2 = 0;
        addressw = 0;
        writeData = 0;
        writeEn = 0;
        #10;
        addressw = 1;
        writeData = 64'h1234567890ABCDEF;
        writeEn = 1;
        #10;
        addressw = 2;
        writeData = 64'hFEDCBA0987654321;
        writeEn = 1;
        #10;
        writeEn = 0;
        address1 = 1;
        address2 = 2;
        #10;
        addressw = 0;
        #10;
        $finish;
    
    end

endmodule