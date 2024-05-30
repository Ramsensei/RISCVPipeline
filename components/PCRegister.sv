module PCRegister #(parameter BITS = 64) (clk, rst, writeData, writeEn, read);
    input wire [BITS-1:0] writeData;
    input wire rst;
    input wire writeEn, clk;
    output reg [BITS-1:0] read;
    
    reg [BITS-1:0] register;
    
    always @(posedge clk) begin
        read <= register;
    end

    always @(negedge clk, posedge rst) begin
        if (rst) begin
            register <= 0;
        end else if (writeEn) begin
            register <= writeData;
        end
    end

    initial
        read = 0;


endmodule