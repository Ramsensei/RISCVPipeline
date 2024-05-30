module Equal_Comp (Data0, Data1, Out);
    input Data0, Data1;
    output reg Out;
    assign Out = !(Data0 ^ Data1);

endmodule