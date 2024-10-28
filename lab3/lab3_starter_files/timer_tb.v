module timer_tb ();
    reg clk;
    reg reset;
    reg beat_pulse;
    reg [8:0] load_value;
    reg timer_up;
    
    timer dut (.clk(clk),
        .reset(reset), 
        .beat_pulse(beat_pulse), 
        .load_value(load_value),
        .timer_up(timer_up)
     );

     // clock generation
    initial begin
        clk = 0; 
        forever begin   
            #2 clk = 1; #2 clk = 0;
        end
    end

    initial begin
        reset = 1;
        beat_pulse = 0;
        load_value = 9'b000000100;
        timer_up = 0;
        #5
        reset = 0;
        #10
        beat_pulse = 1;
        load_value = load_value >> 1;

        #200;
        $finish;
    end
    

endmodule 