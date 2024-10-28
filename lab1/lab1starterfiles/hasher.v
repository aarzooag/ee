module hasher ( input wire [63:0] data, 
                input wire [3:0] data_len,
                output wire [31:0] hash
   
);

	// DO IT GORDON
	// DECLARTIONS
	wire [31:0] final_state;
	wire [31:0] r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;
	
	//assignments
	hash_round #(.ROUND(0)) hasher0(.in_byte(data[7:0]), .in_state(32'h55555555), .out_state(r0_out));
	hash_round #(.ROUND(1)) hasher1(.in_byte(data[15:8]), .in_state(32'hAAAAAAAA), .out_state(r1_out));
	hash_round #(.ROUND(2)) hasher2(.in_byte(data[23:16]), .in_state(r0_out), .out_state(r2_out));
	hash_round #(.ROUND(3)) hasher3(.in_byte(data[31:24]), .in_state(r1_out), .out_state(r3_out));
	hash_round #(.ROUND(4)) hasher4(.in_byte(data[39:32]), .in_state(r2_out), .out_state(r4_out));
	hash_round #(.ROUND(5)) hasher5(.in_byte(data[47:40]), .in_state(r3_out), .out_state(r5_out));
    hash_round #(.ROUND(6)) hasher6(.in_byte(data[55:48]), .in_state(r4_out), .out_state(r6_out));
    hash_round #(.ROUND(7)) hasher7(.in_byte(data[63:56]), .in_state(r5_out), .out_state(r7_out));
    assign final_state = r6_out ^ r7_out;
    rotator #(.WIDTH(32)) hash_rotator(.in(final_state), .distance({3'b000, final_state[4:0]}), .direction(^data_len), .out(hash));
	
endmodule
