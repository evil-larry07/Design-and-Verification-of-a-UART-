module DFF2rx(
input D,clk,
output reg Q
);

always @(posedge clk)
begin
    Q=D;
end

endmodule