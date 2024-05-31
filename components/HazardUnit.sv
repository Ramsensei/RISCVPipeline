module HazardUnit(Branch, Flush, IF_IDWrite, PC_Write);
    input wire Branch;
    output reg Flush;
    output reg IF_IDWrite;
    output reg PC_Write;

    assign Flush = Branch;
    assign IF_IDWrite = 0;
    assign PC_Write = 0;


endmodule