module SIPO(
    input t20,clk,rx,
    output a,b,c,d,e,f,g,h
);

wire t21,t22,t23,t24,t25,t26,t27,t28,t29;

assign t29 = clk&~rx;

DFF2rx instance1(.D(t20), .clk(t29), .Q(t21));
DFF2rx instance2(.D(t21), .clk(t29), .Q(t22));
DFF2rx instance3(.D(t22), .clk(t29), .Q(t23));
DFF2rx instance4(.D(t23), .clk(t29), .Q(t24));
DFF2rx instance5(.D(t24), .clk(t29), .Q(t25));
DFF2rx instance6(.D(t25), .clk(t29), .Q(t26));
DFF2rx instance7(.D(t26), .clk(t29), .Q(t27));
DFF2rx instance8(.D(t27), .clk(t29), .Q(t28));

assign a = t21;
assign b = t22;
assign c = t23;
assign d = t24;
assign e = t25;
assign f = t26;
assign g = t27;
assign h = t28;

endmodule