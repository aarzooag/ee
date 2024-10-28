module verifier (input wire [63:0] password,
                 input wire [63:0] username,
                 output wire valid
   
);

	// FINISH HIM
	wire [3:0] pass_lf_out, usern_lf_out;
	wire [31:0] hasher_out;
	wire [2:0] usern_addr;
	wire usern_valid;
	wire [31:0]pass_rom_data;
	
	length_finder lf_pass(.string(password), .length(pass_lf_out));
    length_finder lf_usern(.string(username), .length(usern_lf_out));
    hasher passw_hasher(.data(password), .data_len(pass_lf_out), .hash(hasher_out));
    cam usern_cam(.data_len(usern_lf_out), .data(username), .addr(usern_addr), .valid(usern_valid));
    hash_rom pass_rom(.addr(usern_addr), .data(pass_rom_data));
    assign valid = (pass_rom_data == hasher_out) & usern_valid;
    

endmodule
