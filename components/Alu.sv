`ifndef TOP
`include "./components/Adder.sv"
`include "./components/Mux.sv"
`endif // TOP
module Alu #(parameter BITS = 64) (SrcA, SrcB, ALUControl, ALUResult, ALUFlags);
    input wire [BITS-1:0] SrcA, SrcB;
	input wire [1:0] ALUControl;
	output reg [BITS-1:0] ALUResult;
	output reg [3:0] ALUFlags;
    
    wire [BITS-1:0] Data_arr_mux2 [1:0];
    wire [BITS-1:0] Data_arr_mux4 [3:0];
	wire [BITS-1:0] mux2_output;
	// wire [0:BITS-1] sum_output;
    wire [BITS-1:0] mux4_output;
    // wire [0:BITS-1] A_or_B;
    // wire [0:BITS-1] A_and_B;
    wire cout;

    assign Data_arr_mux2[0] = SrcB;
    assign Data_arr_mux2[1] = ~SrcB;

	Mux #(2,64) mux2(Data_arr_mux2,ALUControl[0],mux2_output);

	Adder sum(SrcA,mux2_output,ALUControl[0],Data_arr_mux4[0],cout);

    assign Data_arr_mux4[1] = Data_arr_mux4[0];
	assign Data_arr_mux4[2] = SrcA & SrcB;
	assign Data_arr_mux4[3] = SrcA | SrcB;

    // assign Data_arr_mux4[0] = sum_output;
    // assign Data_arr_mux4[2] = A_and_B;
    // assign Data_arr_mux4[3] = A_or_B;

	Mux #(4,64) mux4(Data_arr_mux4, ALUControl, mux4_output);
			  
	assign ALUFlags[3] = ~ALUControl[1] && (mux4_output[BITS-1]||SrcA[BITS-1]) && ~(ALUControl[0]||SrcA[BITS-1]||SrcB[BITS-1]);
	assign ALUFlags[2] = ~ALUControl[1] && cout;
	assign ALUFlags[1] = mux4_output[BITS-1];
	assign ALUFlags[0] = &(~mux4_output);

	// ALUFlags = [Overflow, Carry, Neg, Zero]
			  
	assign ALUResult = mux4_output;
				
endmodule