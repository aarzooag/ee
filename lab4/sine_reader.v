`define ROM_MAX 20'b11111111110000000000
`define ROM_MIN 20'b0
`define ONE 20'b00000000010000000000

module sine_reader(
    input clk,
    input reset,
    input [19:0] step_size,
    input generate_next,

    output sample_ready,
    output wire [15:0] sample
);  

    wire[21:0] addr;
    reg[21:0] next_addr;
    
    wire [19:0] input_change = addr[20] == 1'b1 ?  ~addr[19:0] : addr[19:0];
    
    //current address flip flop
    dffre #(.WIDTH(22)) addr_ff(.clk(clk), .r(reset), .en(generate_next), .d(addr + step_size), .q(addr));
        
    //GET SINE WAVE AMPLITUDE VALUE
    wire[15:0] amp;
    sine_rom sine_rom(.clk(clk), .addr(input_change[19:10]), .dout(amp));

    //if its in Q 3 or 4 make the value negative
    assign sample = addr[21] == 1'b1 ? -amp  : amp;

        
    //delay by a clock cycle
    
    wire delay;
    
    dffr #(.WIDTH(1)) delay_ff(.clk(clk), .r(reset), .d(generate_next), .q(delay));
    dffr  #(.WIDTH(1)) delay2_ff(.clk(clk), .r(reset), .d(delay), .q(sample_ready));


endmodule