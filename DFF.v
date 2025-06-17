module DFF1 (
    input D,clk,in1,in2,in3,
    output t7
);
    always @(posedge clk ) begin
        Q=D;
    end

    wire t4,t5;
    assign t4 = Q & in1;
    assign t5 = in2 & in3;
    assign t7 = t4 | t5;   
endmodule