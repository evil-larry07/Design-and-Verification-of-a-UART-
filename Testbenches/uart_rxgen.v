module SIPO(
    input t20, clk, rx,
    output a, b, c, d, e, f, g, h
);

wire t29;
assign t29 = clk & ~rx;

wire [7:0] q;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : shift_register
        if (i == 0)
            DFF2rx dff_inst (.D(t20), .clk(t29), .Q(q[i]));
        else
            DFF2rx dff_inst (.D(q[i-1]), .clk(t29), .Q(q[i]));
    end
endgenerate

// Assign outputs
assign a = q[0];
assign b = q[1];
assign c = q[2];
assign d = q[3];
assign e = q[4];
assign f = q[5];
assign g = q[6];
assign h = q[7];

endmodule
