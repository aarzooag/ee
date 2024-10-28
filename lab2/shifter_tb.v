module shifter_tb ();

reg [4:0] in;
reg [2:0] distance;
reg direction;
wire [4:0] out;
reg err;

shifter dut(
    .in(in),
    .distance(distance),
    .direction(direction),
    .out(out)
);

initial begin
        err = 1'b0;
        in = 5'b01010;
        distance= 3'd3;
        direction = 1'b0;
        #5
        if (out !=  5'b01010 << 3) begin
            err = 1'b1;
        end
        $display ("got %b, expected %b", out, 5'b10000 );

        in = 5'b01010;
        distance = 3'd5;
        direction = 1'b0;
        #5
        if (out != 5'b01010 << 5) begin
            err = 1'b1;
        end
        $display ("got %b, expected %b", out, 5'b00000);
        
        in = 5'b01010;
        distance = 3'd5;
        direction = 1'b1;
        #5
        if (out != 5'b01010 >> 5) begin
            err = 1'b1;
        end
        $display ("got %b, expected %b", out, 5'b00000);

        in = 5'b01010;
        distance= 3'd0;
        #5
        if (out != 5'b01010) begin
            err = 1'b1;
        end
        $display ("got %b, expected %b", out, 5'b01010);

        in = 5'b01010;
        distance = 3'd6;
        direction = 1'b1;
        
        #5
        if (out != 5'b00000) begin
            err = 1'b1;
        end
        $display ("got %b, expected %b", out, 5'b00000);
end



endmodule