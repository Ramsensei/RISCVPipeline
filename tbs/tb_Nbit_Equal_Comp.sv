`include "./components/Nbit_Equal_Comp.sv"
module tb_Nbit_Equal_Comp;
    reg [31:0] Data0, Data1;
    wire Out;

    Nbit_Equal_Comp #(32) nbit_equal_comp(.Data0(Data0), .Data1(Data1), .Out(Out));

    initial begin
        $dumpfile("pv.vcd");
        $dumpvars(0, tb_Nbit_Equal_Comp);
        Data0 = 32'h00000000;
        Data1 = 32'h00000000;
        #10;
        Data0 = 32'h01234567;
        Data1 = 32'h01234567;
        #10;
        Data0 = 32'h01234567;
        Data1 = 32'h76543210;
        #10;
        Data0 = 32'h01234567;
        Data1 = 32'h01234568;
        #10;
        Data0 = 32'h01234567;
        Data1 = 32'h01234566;
        #10;
        Data0 = 32'h12de24f6;
        Data1 = 32'h12de24f6;
        #10;
        Data0 = 32'h00000000;
        Data1 = 32'h00000001;
        #10 $finish;
    end
endmodule