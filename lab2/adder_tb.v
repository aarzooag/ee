module adder_tb (
);

reg [4:0] a;
reg [4:0] b;
wire [4:0] sum;
wire cout;
reg [4:0] expected_sum;

adder dut(
    .a(a),
    .b(b),
    .sum(sum),
    .cout(cout)
);

initial begin
   
    a = 5'b01000; 
    b = 5'b00011;
    expected_sum = 5'b01011;
    #5
    $display ("a = %b, b = %b. expected sum and cout: %b %b. got sum and cout: %b %b", a, b, expected_sum, 1'b0, sum, cout);

    
    a = 5'b10001; 
    b = 5'b01100;
    expected_sum = 5'b11101;
    #5
    $display ("a = %b, b = %b. expected sum and cout: %b %b. got sum and cout: %b %b", a, b, expected_sum, 1'b0, sum, cout);
    
    
    a = 5'b11111; 
    b = 5'b11111;
    expected_sum = 5'b11110;
    #5
    $display ("a = %b, b = %b. expected sum and cout: %b %b. got sum and cout: %b %b", a, b, expected_sum, 1'b1, sum, cout);

    a = 5'b11010; 
    b = 5'b11100;
    expected_sum = 5'b10110;
    #5
    $display ("a = %b, b = %b. expected sum and cout: %b %b. got sum and cout: %b %b", a, b, expected_sum, 1'b1, sum, cout);
end



endmodule