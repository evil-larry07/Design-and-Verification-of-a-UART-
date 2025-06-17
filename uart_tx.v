module PISO(
    input load,a,b,c,d,e,f,g,h,clk,tx
    output Q
    );
    
wire t1,t2,t3,t6,t7;
assign t1= ~load;
assign t2= load;

assign t3= clk & ~tx;

DFF1_instance1(.D(a), .clk(t3), .Q(t6));
DFF1_instance2(.D(t7), .clk(t3), .Q(t8));
DFF1_instance3(.D(t9), .clk(t3), .Q(t10));
DFF1_instance4(.D(t11), .clk(t3), .Q(t12));
DFF1_instance5(.D(t13), .clk(t3), .Q(t14));
DFF1_instance6(.D(t15), .clk(t3), .Q(t16));
DFF1_instance7(.D(t17), .clk(t3), .Q(t18));
DFF1_instance8(.D(t19), .clk(t3), .Q(t20));


endmodule