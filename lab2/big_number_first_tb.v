module big_number_first_tb ();
    reg[7:0] aIn;
    reg[7:0] bIn;
    wire[7:0] aOut;
    wire[7:0] bOut;
    reg err;

    big_number_first dut (
        .aIn(aIn),
        .bIn(bIn),
        .aOut(aOut),
        .bOut(bOut)
    );

    initial begin
        err = 1'b0;
        aIn = 8'b11101010;
        bIn = 8'b10001010;
        #5
        if (aOut != aIn || bOut != bIn) begin
            err = 1'b1;
        end
        $display ("a expected: %b, a got: %b, b expected: %b, b got: %b", aIn, aOut, bIn, bOut);
    
        aIn = 8'b10001010;
        bIn = 8'b11101010;
       
        #5
        if (aOut != bIn || bOut != aIn) begin
            err = 1'b1;
        end 
        $display ("a expected: %b, a got: %b, b expected: %b, b got: %b", bIn, aOut, aIn, bOut );
    
    
        aIn = 8'b11101010;
        bIn = 8'b11101010;
        #5
        if (aOut != aIn || bOut != bIn) begin
            err = 1'b1;
        end 
        $display ("a expected: %b, a got: %b, b expected: %b, b got: %b", aIn, aIn, bIn, bIn );
        
end


endmodule