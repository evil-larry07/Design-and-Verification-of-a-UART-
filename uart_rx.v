module SIPO(
    input clk,
    input shift_en,
    input data_in,
    output a, b, c, d, e, f, g, h
);

    wire t1, t2, t3, t4, t5, t6, t7, t8;

    wire gated_clk = clk & shift_en;

    DFF2rx d0(.D(data_in), .clk(gated_clk), .Q(t1));
    DFF2rx d1(.D(t1), .clk(gated_clk), .Q(t2));
    DFF2rx d2(.D(t2), .clk(gated_clk), .Q(t3));
    DFF2rx d3(.D(t3), .clk(gated_clk), .Q(t4));
    DFF2rx d4(.D(t4), .clk(gated_clk), .Q(t5));
    DFF2rx d5(.D(t5), .clk(gated_clk), .Q(t6));
    DFF2rx d6(.D(t6), .clk(gated_clk), .Q(t7));
    DFF2rx d7(.D(t7), .clk(gated_clk), .Q(t8));

    assign a = t8;
    assign b = t7;
    assign c = t6;
    assign d = t5;
    assign e = t4;
    assign f = t3;
    assign g = t2;
    assign h = t1;
endmodule
