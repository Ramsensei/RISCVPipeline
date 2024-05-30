module Mux #(parameter DEPTH = 8, BITS = 32) (Data_arr, selector, Out);

    input wire [BITS-1:0] Data_arr [DEPTH-1:0];
    input wire [$clog2(DEPTH)-1:0] selector;
    output reg [BITS-1:0] Out;

    assign Out = Data_arr[selector];

endmodule