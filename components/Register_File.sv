`include "./components/Register.sv"
`include "./components/Hot_Bit.sv"
`ifndef TOP
`include "./components/Mux.sv"
`endif // TOP
module Register_File (clk, address1, address2, addressw, writeData, writeEn, read1, read2);
    parameter DEPTH = 32;
    parameter BITS = 64;
    input wire [($clog2(DEPTH)-1):0] address1, address2, addressw;
    input wire [BITS-1:0] writeData;
    input wire writeEn, clk;
    output reg [BITS-1:0] read1, read2;

    reg [DEPTH-1:0] hotbitOut;
    wire [BITS-1:0] Mux [DEPTH-1:0];
    wire [DEPTH-1:0] regEnable;
    Hot_Bit #(DEPTH) hotbit1(.index(addressw), .Out(hotbitOut));

    assign Mux[0] = 0;

    genvar i;
    generate
        for (i = 1; i < DEPTH; i++) begin : generate_registers
            assign regEnable[i] = hotbitOut[i] & writeEn;
            Register #(BITS) register(.clk(clk), .writeData(writeData), .writeEn(regEnable[i]), .read(Mux[i]));
        end
    endgenerate

    Mux #(DEPTH, BITS) mux1(.Data_arr(Mux), .selector(address1), .Out(read1));
    Mux #(DEPTH, BITS) mux2(.Data_arr(Mux), .selector(address2), .Out(read2));

endmodule