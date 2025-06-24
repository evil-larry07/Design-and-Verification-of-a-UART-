// module BaudGen(
//     input clk,
//     output reg tick
// );
//     reg [7:0] count = 0;
//     always @(posedge clk) begin
//         if (count == 5208) begin
//             count <= 0;
//             tick <= 1;
//         end else begin
//             count <= count + 1;
//             tick <= 0;
//         end
//     end
// endmodule

module BaudGen(
    input clk,
    output reg tick
);
    reg [7:0] count = 0;

    always @(posedge clk) begin
        if (count >= 19) begin  // 20-cycle period
            count <= 0;
            tick <= 1;
        end else begin
            count <= count + 1;
            tick <= 0;
        end
    end
endmodule
