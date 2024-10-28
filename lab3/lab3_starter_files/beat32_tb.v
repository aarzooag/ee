module beat32_tb ();
    reg clk;
    reg reset;
    wire beat;

    // Instantiate the DUT (Device Under Test)
    beat32 dut (
        .clk(clk),
        .reset(reset),
        .beat(beat)
    );

    // Clock generation
    initial begin
        clk = 0; // Initialize clk
        forever begin   
            #5 clk = 1; #5 clk = 0;
        end
    end

    initial begin
        reset = 0; // Start with reset low
        #100 reset = 1; 
        #100 reset = 0; 
    end

    // Monitor signals
    initial begin
        $monitor("reset: %b, clk: %b, beat: %b", reset, clk, beat);
        #300;
        $finish;
    end

endmodule