`include "./components/Adder1bit.sv"
module Adder #(parameter BITS = 64) (a, b, cin, sum, cout);
    input wire [BITS-1:0] a, b;
    input wire cin;
    output reg [BITS-1:0] sum;
    output reg cout;
    
    reg [BITS-1:0] cs;
    
    Adder1bit firstAdd (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cs[0]));

    generate
        genvar i;
        for (i = 1; i < BITS; i = i + 1) begin: adderLoop
            Adder1bit adder (.a(a[i]), .b(b[i]), .cin(cs[i-1]), .sum(sum[i]), .cout(cs[i]));
        end
    endgenerate
    assign cout = cs[BITS-1];
endmodule