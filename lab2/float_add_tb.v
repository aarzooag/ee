module float_add_tb (
);

reg [7:0] aIn;
reg [7:0] bIn;
wire [7:0] result;
reg [7:0] expected;

float_add dut(
    .aIn(aIn),
    .bIn(bIn),
    .result(result)
);

initial begin
    aIn = 8'b00001000;
    bIn = 8'b00000011;
    expected = 8'b00001011;
    #5
    $display("a = %b b= %b. expected = %b. got = %b", aIn, bIn, expected, result);

    aIn = 8'b00110001;
    bIn = 8'b00001100;
    expected = 8'b00110111;
    #5
    $display("a = %b b= %b. expected = %b. got = %b", aIn, bIn, expected, result);

    aIn = 8'b10010010;
    bIn = 8'b01011111;
    expected = 8'b10011001;
    #5
    $display("a = %b b= %b. expected = %b. got = %b", aIn, bIn, expected, result);

    aIn = 8'b11111110;
    bIn = 8'b11111000;
    expected = 8'b11111111;
    #5
    $display("a = %b b= %b. expected = %b. got = %b", aIn, bIn, expected, result);
    
    aIn = {3'b110, 5'b11110};
    bIn = {3'b000, 5'b11111};
    expected = 8'b11011110;
    #5
    $display("a = %b b= %b. expected = %b. got = %b", aIn, bIn, expected, result);

    aIn = {3'b011, 5'b11111};
    bIn = {3'b000, 5'b11111};
    expected = {3'b100, 5'b10001};
    #5
    $display("a = %b b= %b. expected = %b. got = %b", aIn, bIn, expected, result);
    
end



endmodule