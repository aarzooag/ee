module cam ( input wire[63:0] data,
             input wire[3:0] data_len,
             output wire[2:0] addr,
             output wire valid
      
);
	// wire declarations\\
	wire [67:0] data_word;
	wire [7:0] entry_matches;

	// data concatenation
	assign data_word = {data_len, data};
	
	// 8 equality comparisons
	assign entry_matches[0] = 68'h3_00000000004F454C == data_word;
	assign entry_matches[1] = 68'h5_0000004E4F524141 == data_word;
	assign entry_matches[2] = 68'h5_000000594C4C4F48 == data_word;
	assign entry_matches[3] = 68'h5_0000004449564144 == data_word;
	assign entry_matches[4] = 68'h6_0000455249414C43 == data_word;
	assign entry_matches[5] = 68'h5_0000004B4E415246 == data_word;
	assign entry_matches[6] = 68'h5_00000045434E414C== data_word;
	assign entry_matches[7] = 68'h4_000000004E415952 == data_word;
	// encoder instantiation
	encoder enc_incam(.in(entry_matches), .out(addr));	
	// valid logic
	assign valid = |entry_matches;

	
endmodule
