module timer #(
    parameter m=6    // new count size m=6 for fast blinker, m=9 for slow blinker  (m = n + 4)
) (
    input clk, 
    input reset, 
    input [m-1:0] load_value, 
    input count_en, 
    input [21:0] clk_count, 
    output out
);

    wire [m-1:0] next_count, count; 
    
    assign next_count = (count == 0) ? load_value : (count - 1); 

    dffre #(m) timer_ff (.clk(clk), .r(reset), .en(count_en), .d(next_count), .q(count) ); 

    assign out = (clk_count == 0) && (count == 0);  // toggle signal

endmodule