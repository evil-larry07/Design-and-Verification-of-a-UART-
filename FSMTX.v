// module FSMTX(
//     input [7:0] datain,
//     input clk, reset, start,
//     output Done,
//     output reg tx,
//     output x
// );

//     reg load;
//     wire tick;

//     BaudGen instance1(.clk(clk), .tick(tick));
//     PISO instance2(
//         .a(datain[7]), .b(datain[6]), .c(datain[5]), .d(datain[4]),
//         .e(datain[3]), .f(datain[2]), .g(datain[1]), .h(datain[0]),
//         .clk(tick), .load(load), .tx(tx), .t20(x)
//     );

//     parameter idle = 3'b000,
//               start_s = 3'b001,
//               data  = 3'b010,
//               stop  = 3'b011,
//               done  = 3'b100;

//     reg [2:0] state, nstate;
//     reg [3:0] bit_cnt;

//     initial 
// 	begin
//                 state <= idle;
//                 nstate=state;
//                 tx <= 1;
//                 load <= 0;
//                 bit_cnt <= 0;
//             end 
//     always @(*) begin
//         case (state)
//             idle:   nstate = (start) ? start_s : idle;
//             start_s:nstate = data;
//             data:   nstate = (bit_cnt == 8) ? stop : data;
//             stop:   nstate = done;
//             done:   nstate = idle;
//             default:nstate = idle;
//         endcase
//     end

    
//     always @(posedge clk or posedge reset) 
//     begin
//         bit_cnt=0;
//         if (reset) 
//             begin
//                 state <= idle;
//                 tx <= 1;
//                 load <= 0;
//                 bit_cnt <= 0;
//             end 
//         else 
//             begin
//                 state <= nstate;

//                 case (nstate)
//                     idle: 
//                         begin
//                             state<=nstate;
//                             load <= 1;
//                             bit_cnt <= 0;
//                             tx <= 1;
//                         end

//                     start_s: 
//                         begin
//                             state<=nstate;
//                             load <= 0;
//                             tx <= 0;
//                         end

//                     data: 
//                         begin
//                             tx <= 0;
//                             if (tick)
//                                 bit_cnt <= bit_cnt + 1;
//                             state<=nstate;
//                         end

//                     stop: 
//                         begin
//                             tx <= 1;
//                             state<=nstate;
//                         end

//                     done: 
//                         begin
//                             tx <= 1;
//                             state<=nstate;
//                         end
//                 endcase
//             end
//     end

//     assign Done = (state == done);

// endmodule

module FSMTX(
    input clk,
    input reset,
    input [7:0] datain,
    output Done,
    output x,
    output tick   // <-- exposed
);
    reg tx, load;
    reg [3:0] bit_cnt;
    reg [2:0] state, nstate;

    parameter IDLE = 0, LOAD = 1, DATA = 2, STOP = 3, DONE = 4;

    // Baud tick generator
    BaudGen instance1(.clk(clk), .tick(tick));

    // Parallel-In Serial-Out
    PISO instance2(
        .a(datain[7]), .b(datain[6]), .c(datain[5]), .d(datain[4]),
        .e(datain[3]), .f(datain[2]), .g(datain[1]), .h(datain[0]),
        .clk(tick), .load(load), .tx(tx), .t20(x)
    );

    // Next state logic
    always @(*) begin
        case(state)
            IDLE:  nstate = LOAD;
            LOAD:  nstate = DATA;
            DATA:  nstate = (bit_cnt == 8) ? STOP : DATA;
            STOP:  nstate = DONE;
            DONE:  nstate = IDLE;
            default: nstate = IDLE;
        endcase
    end

    // State transitions and outputs
    always @(posedge tick or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            tx <= 1;
            load <= 0;
            bit_cnt <= 0;
        end else begin
            state <= nstate;
            case (state)
                IDLE: begin
                    bit_cnt <= 0;
                    load <= 0;
                    tx <= 1;
                end
                LOAD: begin
                    load <= 1;
                    tx <= 1;
                end
                DATA: begin
                    load <= 0;
                    tx <= 0;
                    bit_cnt <= bit_cnt + 1;
                end
                STOP: tx <= 1;
                DONE: tx <= 1;
            endcase
        end
    end

    assign Done = (state == DONE);

endmodule
