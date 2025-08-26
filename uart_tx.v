module PISO(
    input a, b, c, d, e, f, g, h,
    input clk, load, tx,
    output reg t20
);
    reg [7:0] data;
    reg [2:0] count = 0;

    always @(posedge clk) 
    begin
        if (load) 
            begin
                data <= {a, b, c, d, e, f, g, h};       // at load =1 data in parallely
                count <= 0;
            end 
        else if (~tx) 
            begin
                t20 <= data[count];                     // data transmission from lsb first to msb firstly data[0] then count inc then data[1]
                count <= count + 1;
            end
        else 
            begin
                t20 <= 1'b0;  // therefore at tx==0 output x==0 which is the start bit 
            end
    end
endmodule









// module PISO(
//     input load,a,b,c,d,e,f,g,h,clk,tx,
//     output t20
//     );
    
// wire t1,t2,t3,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19;
// assign t1= ~load;
// assign t2= load;

// assign t3= clk & ~tx;

// DFF1tx instance1(.D(a), .clk(t3), .t7(t7), .in1(t2), .in2(t1), .in3(b) );
// DFF1tx instance2(.D(t7), .clk(t3), .t7(t8), .in1(t2), .in2(t1), .in3(c));
// DFF1tx instance3(.D(t8), .clk(t3), .t7(t10), .in1(t2), .in2(t1), .in3(d));
// DFF1tx instance4(.D(t10), .clk(t3), .t7(t12), .in1(t2), .in2(t1), .in3(e));
// DFF1tx instance5(.D(t12), .clk(t3), .t7(t14), .in1(t2), .in2(t1), .in3(f));
// DFF1tx instance6(.D(t14), .clk(t3), .t7(t16), .in1(t2), .in2(t1), .in3(g));
// DFF1tx instance7(.D(t16), .clk(t3), .t7(t18), .in1(t2), .in2(t1), .in3(h));
// DFF1tx instance8(.D(t18), .clk(t3), .t7(t20), .in1(1'b1), .in2(1'b0), .in3(1'b0));


// endmodule

