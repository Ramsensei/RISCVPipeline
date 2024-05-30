module Shifter #(parameter BITS = 64) (data, out);

    input wire [BITS-1:0] data;
    output reg [BITS-1:0] out;

    assign out = {data[BITS-2:0], 1'b0};
endmodule