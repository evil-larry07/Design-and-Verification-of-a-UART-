module FSMRX(
    input clk,
    input rx,
    output reg Done,
    output [7:0] dataout,
    output tick
);
    wire [7:0] sipo_out;
    wire a, b, c, d, e, f, g, h;
    assign dataout = {a, b, c, d, e, f, g, h };  // LSB first

    BaudGen baudgen(.clk(clk), .tick(tick));
    SIPO sipo(.clk(tick), .data_in(rx), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));

    reg [2:0] state = 0;
    reg [2:0] bit_cnt = 0;

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, DONE_STATE = 4;

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                Done <= 0;
                bit_cnt <= 0;
                if (rx == 0) state <= START;
            end

            START: begin
                if (tick) state <= DATA;  // start bit sampled
            end

            DATA: begin
                if (tick) begin
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 7) state <= STOP;
                end
            end

            STOP: begin
                if (tick) state <= DONE_STATE;
            end

            DONE_STATE: begin
                Done <= 1;
                state <= IDLE;
            end
        endcase
    end
endmodule
