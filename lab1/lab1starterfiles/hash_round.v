module hash_round #(parameter ROUND = 0)(
    input wire [7:0] in_byte,
    input wire [31:0] in_state,
    output wire [31:0] out_state
);
   
	// Declarations
	wire [7:0] a;
	wire [7:0] b;
	wire [7:0] c;
	wire [7:0] d;
	reg [7:0] mix_func_out;
	wire [7:0] mixed_a = in_byte + (a + mix_func_out);
	wire [7:0] rotated_mixed_a;
	
	// State splitting
	assign {d ,c, b, a} = in_state;
	
	// Mix function
	always @ (*) begin
	   case(ROUND)
	   3'd0, 3'd1, 3'd2 : mix_func_out = (c&b) | (~b & d);
	   3'd3, 3'd4 : mix_func_out = (c&b) | (c&d) | (b&d);
	   3'd5, 3'd6, 3'd7 : mix_func_out = c  ^ b ^ d; 
	   default : mix_func_out  = 3'd0;
	   endcase
	end
	
	// Rotator
	rotator rot1(.in(mixed_a), .out(rotated_mixed_a), .distance(ROUND), .direction(1'b1));
	
	// Output state assignment
	assign out_state = {c, b, rotated_mixed_a, d};

endmodule
