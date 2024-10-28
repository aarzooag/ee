// 32-beat cycles needed (reset after 3125000-1=d3124999)
`define BEAT_CYCLES 22'd3124999

module beat32 (
    input clk, 
    input reset, 
    output heartbeat, 
    output [21:0] clk_count
);
    reg [21:0] next_count = 0; 
    wire [21:0] count;
    
    always @(*)
        next_count = (count == `BEAT_CYCLES) ? 0 : count + 1; 

    assign heartbeat = (count == 0); 

    dffr #(22) heartbeat_ff (.clk(clk), .r(reset), .d(next_count), .q(count) ); 

    assign clk_count = count; 

endmodule