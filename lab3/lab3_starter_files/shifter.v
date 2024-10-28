module shifter #(
    parameter n=2   // n=2 0s added for fast blink, n=5 for slow blink
) (
    input clk, 
    input reset, 
    input shift_left,
    input shift_right, 
    output [n+3:0] out
);

    reg [3:0] next_state;
    wire [3:0] state; 
    
    wire blink_type = (n==2);  // high fast, low slow
    wire one_hot = (state == 4'b1000) || (state == 4'b0100) || (state == 4'b0010) || (state == 4'b0001);

    dff #(4) shifter_ff (.clk(clk), .d(next_state), .q(state) ); 

    always @(*) begin
        casex ({reset, shift_left, shift_right, state})
            7'b1xxxxxx : next_state = blink_type ? 4'b1000 : 4'b0001;
            7'b0100xxx : next_state = one_hot ? (state << 1) : (blink_type ? 4'b1000 : 4'b0001); 
            7'b001xxx0 : next_state = one_hot ? (state >> 1) : (blink_type ? 4'b1000 : 4'b0001);
            default : next_state = one_hot ? state : (blink_type ? 4'b1000 : 4'b0001); 
        endcase
    end

    assign out = {state, {n{1'b0}}}; 

endmodule