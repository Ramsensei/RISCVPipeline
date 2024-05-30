module InstMemory #(parameter DEPTH = 32, BITS = 32) (address, readData);

    input wire [$clog2(DEPTH*(BITS/8))-1:0] address;
    output reg [BITS-1:0] readData;

    reg [7:0] registers [DEPTH*(BITS/8)-1:0];


    always_comb begin
        readData = {registers[address], registers[address+1], registers[address+2], registers[address+3]};
    end
    
    initial
        $readmemh("memory.dat", registers);
endmodule