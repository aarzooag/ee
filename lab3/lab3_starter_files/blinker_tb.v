module blinker_tb ();
    reg clk;
    reg reset;
    reg switch;
    wire out;

    blinker dut(
        .clk(clk),
        .switch(switch),
        .reset(reset),
        .out(out)
    );

    initial begin
        clk = 0; 
        forever begin   
            #2 clk = 1; #2 clk = 0;
        end
    end

    initial begin
        reset = 1;
        switch = 1;
        #4 reset = 0;
        repeat(6) begin
            #6 switch = ~switch;
        end
        #10;
        $finish;
    end
endmodule