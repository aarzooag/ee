module programmable_blinker #(  
    parameter n=2   // n=2 0s added for fast blinker, n=5 0s added for slow blinker
) (
    input clk, 
    input reset,
    input shift_left,
    input shift_right,
    input [21:0] clk_count, 
    input heartbeat,
    output blink_out
);

    wire [n+3:0] count; 
    wire toggle; 

    shifter #(n) shift_blink(.clk(clk), .reset(reset), .shift_left(shift_left), .shift_right(shift_right), .out(count) );
    timer #(n+4) time_blink(.clk(clk), .reset(reset), .clk_count(clk_count), .load_value(count), .count_en(heartbeat), .out(toggle) ); 
    blinker blink(.clk(clk), .reset(reset), .switch(toggle), .out(blink_out) ); 


endmodule