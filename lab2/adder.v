module adder (
    input wire [4:0] a,
    input wire [4:0] b,
    output wire [4:0] sum,
    output wire cout

);
wire cin[4:0];

assign cin[0] = 1'b0;

assign sum[0] = (a[0] ^ b[0]) ^ (cin[0]);
assign cin[1] = ((a[0] ^ b[0]) & cin[0]) | (a[0] & b[0]);

assign sum[1] = (a[1] ^ b[1]) ^ (cin[1]);
assign cin[2] = ((a[1] ^ b[1]) & cin[1]) | (a[1] & b[1]);

assign sum[2] = (a[2] ^ b[2]) ^ (cin[2]);
assign cin[3] = ((a[2] ^ b[2]) & cin[2]) | (a[2] & b[2]);

assign sum[3] = (a[3] ^ b[3]) ^ (cin[3]);
assign cin[4] = ((a[3] ^ b[3]) & cin[3]) | (a[3] & b[3]);

assign sum[4] = (a[4] ^ b[4]) ^ (cin[4]);

assign cout = ((a[4] ^ b[4]) & cin[4]) | (a[4] & b[4]);

endmodule