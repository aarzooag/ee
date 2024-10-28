module big_number_first (input wire[7:0] aIn,
                            input wire[7:0] bIn,
                            output reg[7:0] aOut,
                            output reg[7:0] bOut
);

wire[2:0] aE;
wire[2:0] bE;

assign aE = aIn[7:5];
assign bE = bIn[7:5];

always @(*) begin
    if (bE > aE) begin
        bOut = aIn;
        aOut = bIn;
    end else begin
        bOut = bIn;
        aOut = aIn;
    end
end

endmodule