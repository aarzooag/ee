module shifter_tb ();

    reg shift_left;
    reg shift_right;
    reg clk;
    reg reset;
    wire [8:0] out;

    shifter #(5) dut(
        .shift_left(shift_left),
        .shift_right(shift_right),
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    initial begin
        clk = 0;
        forever begin   
            #1 clk = 1; #1 clk = 0; 
        end
    end


    initial begin
  
        reset = 0; 
        shift_left = 0;
        shift_right = 0;

        #5 reset = 1; 
        #5 reset = 0;


        repeat (1) begin
            #2 shift_left = 1;
            #2 shift_left = 0; 
        end
        #5
        repeat (1) begin
            #2 shift_right = 1;
            #2 shift_right = 0; 
        end

        #200; 
        $finish; 
    end
    
endmodule