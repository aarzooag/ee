module master_fsm (
    input clk, 
    input reset, 
    input next, 
    input faster, 
    input slower, 
    output slow_left, 
    output slow_right, 
    output fast_left, 
    output fast_right, 
    output reg [1:0] mux_out
);

    reg [2:0] next_state = 0; 
    wire [2:0] state; 

    dffr #(3) master_ff (.clk(clk), .r(reset), .d(next_state), .q(state) ); 
   
    always @(*) begin
        case (state)
            `OFF1 : next_state = next ? `ON : state; 
            `ON : next_state = next ? `OFF2 : state; 
            `OFF2 : next_state = next ? `FLASH1 : state;
            `FLASH1 : next_state = next ? `OFF3 : state;
            `OFF3 : next_state = next ? `FLASH2 : state;
            `FLASH2 : next_state = next ? `OFF1 : state;
            default : next_state = `OFF1;
        endcase
    end


    always @(*) begin
        case (state)
            `OFF1, `OFF2, `OFF3 : mux_out = `LIGHT_OFF; 
            `ON : mux_out = `LIGHT_ON; 
            `FLASH1 : mux_out = `BLINK_SLOW;
            `FLASH2 : mux_out = `BLINK_FAST;
            default : mux_out = `OFF1;
        endcase
    end

    assign slow_left = (state == `FLASH1) && slower; 
    assign slow_right = (state == `FLASH1) && faster; 

    assign fast_left = (state == `FLASH2) && slower; 
    assign fast_right = (state == `FLASH2) && faster; 


endmodule