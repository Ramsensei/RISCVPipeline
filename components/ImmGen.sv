module ImmGen (OpCode, InstructionP1, InstructionP2, Imm);
    
    input wire [0:4] OpCode;
    input wire [0:11] InstructionP1;
    input wire [0:4] InstructionP2;
    output reg [0:63] Imm;
    
    always_comb begin
        case (OpCode)
            5'b00000: begin
                Imm = {{52{InstructionP1[0]}}, InstructionP1};
            end
            5'b01000: begin
                Imm = {{52{InstructionP1[0]}}, InstructionP1[0:6], InstructionP2}; 
            end
            5'b11000: begin
                Imm = {{52{InstructionP1[0]}}, InstructionP1[0], InstructionP2[4], InstructionP1[1:6], InstructionP2[0:3]};
            end
            5'b00100: begin
                Imm = {{52{InstructionP1[0]}}, InstructionP1};
            end
            default: begin
                Imm = 64'b0;
            end
        endcase
    end

endmodule
