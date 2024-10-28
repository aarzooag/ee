module programmable_blinker_tb ();
    reg clk, reset, shift_left, shift_right;
    reg [21:0] clk_count;
    reg heartbeat;
    wire blink_out;

    programmable_blinker dut (
        .clk(clk), .reset(reset), .shift_left(shift_left),
         .shift_right(shift_right), .clk_count(clk_count),
          .heartbeat(heartbeat), .blink_out(blink_out)

    );

    initial begin
        clk = 0; // Initialize clk
        forever begin   
            #1 clk = 1; #1 clk = 0;
        end
    end

    initial begin
        #10 reset = 1; 
        shift_left = 0;
        shift_right = 0;
        heartbeat = 1;
        clk_count = 22'd0;
        
        #10 reset = 0; 
        #10 shift_right = 1;
        #200;
        $finish;
    end


endmodule