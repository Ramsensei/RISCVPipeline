module Memory #(parameter DEPTH = 32, BITS = 64) (clk, address, writeData, writeEn, readData);

    input wire [0:$clog2(DEPTH)-1] address;
    input wire [0:BITS-1] writeData;
    input wire writeEn, clk;
    output reg [0:BITS-1] readData;

    reg [0:BITS-1] registers [0:DEPTH-1];

    always @(posedge clk) begin
        readData <= registers[address];
    end

    always @(negedge clk) begin
        if (writeEn) begin
            registers[address] <= writeData;
        end 
    end
 
endmodule