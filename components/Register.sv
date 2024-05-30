module Register #(parameter BITS = 64) (clk, writeData, writeEn, read);
    input wire [0:BITS-1] writeData;
    input wire writeEn, clk;
    output reg [0:BITS-1] read;
    
    reg [0:BITS-1] register;
    
    always_comb begin
        read = register;
    end
    
    always @(negedge clk) begin
        if (writeEn) begin
            register <= writeData;
        end
    end

    initial
        register = 0;


endmodule