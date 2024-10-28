module shifter (input wire [4:0] in, 
                input wire [2:0] distance,
                input wire direction,
                output reg [4:0] out
);

always @(*) begin  
    if (direction == 1'b0) begin
        out = in << distance;
    end else begin
        out = in >> distance;
    end
end
endmodule