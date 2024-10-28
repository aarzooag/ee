module blinker (
    input clk, 
    input reset,
    input switch, 
    output out
);
 
    reg next_state = 0; 

    always @(*)
        next_state = switch ? ~out : out;     
    
    dffr #(1) blinker_ff (.clk(clk), .r(reset), .d(next_state), .q(out) ); 


endmodule