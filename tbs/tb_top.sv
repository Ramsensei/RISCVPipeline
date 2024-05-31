`include "./top/top.sv"
module tb_top();
    reg clk;
    reg rst;

    top top1(clk, rst);

    initial begin
        clk = 0;
        forever begin
            clk = ~clk;
            #5;
        end
    end

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_top);
        rst = 1;
        #10;
        rst = 0;
        #200;
        //if(top1.datapath.regFile.generate_registers[1].register.register == 2 &&
        //   top1.datapath.regFile.generate_registers[2].register.register == 4 &&
        //   top1.datapath.regFile.generate_registers[3].register.register == 2 &&
        //   top1.datapath.regFile.generate_registers[4].register.register == 2 &&
        //   top1.datapath.regFile.generate_registers[5].register.register == 6 &&
        //   top1.datapath.regFile.generate_registers[6].register.register == 4) begin
        //    $display("Test Passed");
        //   end else begin
        //    $display("Test Failed");
        //   end
        clk = 0;
        $finish;
    end
endmodule