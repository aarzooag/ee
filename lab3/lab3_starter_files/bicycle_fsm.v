// Bicycle Light FSM
//
// This module determines how the light functions in the given state and what
// the next state is for the given state.
// 
// It is a structural module: it just instantiates other modules and hooks
// up the wires between them correctly.

// State variable definitions
`define OFF1 3'd0
`define ON 3'd1
`define OFF2 3'd2
`define FLASH1 3'd3
`define OFF3 3'd4
`define FLASH2 3'd5

// --------------------------------

// MUX select line defintions
`define LIGHT_OFF 2'b00
`define LIGHT_ON 2'b01
`define BLINK_SLOW 2'b10
`define BLINK_FAST 2'b11


module bicycle_fsm(
    input clk, 
    input faster, 
    input slower, 
    input next, 
    input reset, 
    output wire rear_light
);

    reg out_light = 0; 
    wire slow_left, slow_right, fast_left, fast_right, heartbeat; 
    wire [1:0] sel; 
    wire slow_blink, fast_blink; 
    wire [21:0] clk_count; 

    // Instantiations of master_fsm, beat32, fast_blinker, slow_blinker
    master_fsm master_control (
                            .clk(clk), 
                            .reset(reset),
                            .next(next), 
                            .faster(faster), 
                            .slower(slower), 
                            .slow_left(slow_left), 
                            .slow_right(slow_right), 
                            .fast_left(fast_left),
                            .fast_right(fast_right),
                            .mux_out(sel)
    ); 

    programmable_blinker #(2) fast_blinker(
                                    .clk(clk), 
                                    .reset(reset), 
                                    .shift_left(fast_left), 
                                    .shift_right(fast_right), 
                                    .clk_count(clk_count), 
                                    .heartbeat(heartbeat), 
                                    .blink_out(fast_blink)
    ); 

    programmable_blinker #(5) slow_blinker(
                                    .clk(clk), 
                                    .reset(reset), 
                                    .shift_left(slow_left), 
                                    .shift_right(slow_right), 
                                    .clk_count(clk_count),
                                    .heartbeat(heartbeat), 
                                    .blink_out(slow_blink)
    ); 

    beat32 beat_control (.clk(clk), .reset(reset), .heartbeat(heartbeat), .clk_count(clk_count) ); 

    // Output mux here
    always @(*) begin
        case (sel)
            `LIGHT_ON : out_light = 1'b1;
            `LIGHT_OFF : out_light = 1'b0;
            `BLINK_SLOW : out_light = slow_blink; 
            `BLINK_FAST : out_light = fast_blink; 
            default : out_light = 1'b0;
        endcase
    end
    
    assign rear_light = out_light;
 
endmodule
