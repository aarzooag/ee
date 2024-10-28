module float_add (
    input wire [7:0] aIn,
    input wire [7:0] bIn,
    output reg [7:0] result
);

//wire delclarations

wire [7:0] aOut;
wire [7:0] bOut;
wire [2:0] distance;
wire [4:0] b_shifted;
wire [4:0] sum;
wire cout;
wire [2:0] new_exp;

big_number_first get_big(.aIn(aIn), .bIn(bIn), .aOut(aOut), .bOut(bOut));

assign distance = aOut[7:5] - bOut[7:5];
assign new_exp = aOut[7:5] + 3'd1;

shifter shift(.in(bOut[4:0]), .distance(distance), .direction(1'b1), .out(b_shifted));

adder add_atob(.a(aOut[4:0]), .b(b_shifted), .sum(sum), .cout(cout));

always @(*) begin   
    //if we have overflow check for saturation
    if (cout == 1) begin   
        if (aOut[7:5] == 3'b111) begin
            result = 8'b11111111;
        end else begin  
            result = {new_exp, cout, sum[4:1]};
        end
    end else begin
        result = {aOut[7:5], sum};
    end
end

endmodule