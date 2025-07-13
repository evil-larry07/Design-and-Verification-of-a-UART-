module FSMRX(
    input clk,
    input rx,
    output reg Done,
    output [7:0] dataout,
    output tick
);
    
    wire a, b, c, d, e, f, g, h;
    assign dataout = {h, g, f, e, d, c, b, a };  // LSB first

    reg [2:0] state = 0;
    reg [2:0] bit_cnt = 0;

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, DONE_STATE = 4;

    BaudGen baudgen(.clk(clk), .tick(tick));
    SIPO sipo(.clk(tick), .data_in(rx), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));

    always @(posedge clk) 
        begin
            case (state)
                IDLE: 
                    begin
                        Done <= 0;
                        bit_cnt <= 0;
                        if (rx == 0) 
                            begin
                                state <= START;
                            end
                    end

                START: 
                    begin
                        if (tick) 
                            begin 
                                state <= DATA;  // start bit sampled
                            end
                    end

                DATA: 
                    begin
                        if (tick) 
                            begin
                                if (bit_cnt == 7) 
                                    begin
                                        state <= STOP;
                                    end
                                else 
                                    begin
                                        bit_cnt <= bit_cnt + 1;
                                    end     
                            end
                    end

                STOP: 
                    begin
                        if (tick) 
                            begin
                                state <= DONE_STATE;
                            end
                    end

                DONE_STATE: 
                    begin
                        Done <= 1;
                        state <= IDLE;
                    end
            endcase
        end
endmodule

