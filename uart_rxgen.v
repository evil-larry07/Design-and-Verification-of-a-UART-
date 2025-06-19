module SIPO(
    input t20,clk,rx,
    output [7:0]a
);
wire [7:0]t21;
wire t29;


assign t29 = clk&~rx;

genvar i;
generate 
    for (i=0;i<8;i++)
    begin:gen
        DFF2rx instance1(.D(t20[i]), .clk(t29[i]), .Q(t21[i]));
            assign a[i] = t21[i];
    end
endgenerate

endmodule