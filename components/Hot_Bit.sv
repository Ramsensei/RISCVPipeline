`include "./components/Nbit_Equal_Comp.sv"
module Hot_Bit #(DEPTH = 8) (index, Out);
    parameter BITS = $clog2(DEPTH);
    input [BITS-1:0] index;
    output reg [DEPTH-1:0] Out;


    genvar i;
    generate
        for (i = 0; i < DEPTH; i++) begin : generate_hotbit_outputs
            Nbit_Equal_Comp #(BITS) equal_n_bits(.Data0(index), .Data1(i[BITS-1:0]), .Out(Out[i]));
        end
    endgenerate
    
endmodule