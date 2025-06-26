module FSMRX(
    input clk,
    input reset,
    input rx,
    output reg [7:0] dataout,
    output reg Done,
    output tick
);

    reg [2:0] state, nstate;
    reg [3:0] bit_cnt;
    reg shift_en;                                       //will shift data only when shift enable ==1

    wire tick_internal;
    wire a, b, c, d, e, f, g, h;

    parameter IDLE = 0, START = 1, DATA = 2, STOP = 3, DONE_STATE = 4;

    assign tick = tick_internal;

    // instanciation of transmitter and baud gen
    BaudGen instance1(.clk(clk), .tick(tick_internal));
    SIPO instance2(.clk(tick_internal), .shift_en(shift_en), .data_in(rx), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .h(h));

   

    // FSM next state logic acc to state diagram basically almost simillar to transmitter fsm only diff is rx is not driven by FSM
    always @(*) begin
        case (state)
            IDLE:      nstate = (rx == 0) ? START : IDLE;
            START:     nstate = DATA;
            DATA:      nstate = (bit_cnt == 8) ? STOP : DATA;
            STOP:      nstate = DONE_STATE;
            DONE_STATE:nstate = IDLE;
            default:   nstate = IDLE;
        endcase
    end

    // FSM sequential logic
    always @(posedge tick_internal or posedge reset) 
    begin
        if (reset) 
            begin
                state <= IDLE;
                bit_cnt <= 0;
                Done <= 0;
                dataout <= 0;
                shift_en <= 0;
            end 
        else 
            begin
                state <= nstate;
                case (state)
                    IDLE: 
                        begin
                            bit_cnt <= 0;
                            Done <= 0;
                            shift_en <= 0;
                        end
                    START: 
                        begin
                            shift_en <= 0;
                            Done <=0;
                        end
                    DATA: 
                        begin
                            shift_en <= 1;                          //now only data will shift
                            bit_cnt <= bit_cnt + 1;
                            Done <=0;
                        end
                    STOP: 
                        begin
                            shift_en <= 0;                          //data shifting stops
                            Done <=0;                  
                        end
                    DONE_STATE: 
                        begin
                            dataout <= {h, g, f, e, d, c, b, a};        // cuz a,b,c,... was have output reversed therfore this is the Correct bit order
                            Done <= 1;
                        end

                endcase

            end
    end
endmodule
