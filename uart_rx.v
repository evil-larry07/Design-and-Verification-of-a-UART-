module SIPO(
    input clk,          //driven by tick!
    input data_in,
    output a, b, c, d, e, f, g, h
);

    wire t1, t2, t3, t4, t5, t6, t7, t8;

    DFF2rx instance1(.D(data_in), .clk(clk), .Q(t1));
    DFF2rx instance2(.D(t1),.clk(clk), .Q(t2));
    DFF2rx instance3(.D(t2),.clk(clk), .Q(t3));
    DFF2rx instance4(.D(t3),.clk(clk), .Q(t4));
    DFF2rx instance5(.D(t4),.clk(clk), .Q(t5));
    DFF2rx instance6(.D(t5),.clk(clk), .Q(t6));
    DFF2rx instance7(.D(t6),.clk(clk), .Q(t7));
    DFF2rx instance8(.D(t7),.clk(clk), .Q(t8));

    assign h = t2; 
    assign g = t3; 
    assign f = t4; 
    assign e = t5;
    assign d = t6; 
    assign c = t7; 
    assign b = t8; 
    assign a = t1;
    
endmodule
