module Fordwarding_Unit(rs1, rs2, MEM_rd, WB_rd, RegWrite, MemToReg, FwASel, FwBSel);

    input wire [4:0] rs1, rs2, MEM_rd, WB_rd;
    input wire MEM_RegWrite, WB_RegWrite, MemToReg;
    output reg [1:0] FwASel, FwBSel;

    always_comb begin
        
        if (MEM_RegWrite && (rs1 == MEM_rd) && MemToReg) begin
            FwASel = 2'b01;
        end else if (MEM_RegWrite && (rs1 == MEM_rd)) begin
            FwASel = 2'b10;
        end else begin
            FwASel = WB_RegWrite && (rs1 == WB_rd) ? 2'b11 : 2'b00;
        end

        if (MEM_RegWrite && (rs2 == MEM_rd) && MemToReg) begin
            FwBSel = 2'b01;
        end else if (MEM_RegWrite && (rs2 == MEM_rd)) begin
            FwBSel = 2'b10;
        end else begin
            FwBSel = WB_RegWrite && (rs2 == WB_rd) ? 2'b11 : 2'b00;
        end

    end

endmodule