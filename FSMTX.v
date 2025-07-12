module FSMTX(
    input clk,
    input reset,                                        //for idle state to stay at idle
    input [7:0] datain,
    output Done,
    output wire x,                                      //  x a wire now it can be reset to x previously it was reg that's why my ,ine 26 was not able to assign x==x it has to be continous for that
    output tick                                         // Baud tick 
);

    reg tx, load;
    reg [3:0] bit_cnt;                                  //for data bit to incremennt 1 bit by bit
    reg [2:0] state, nstate;

    parameter IDLE = 0, LOAD = 1, DATA = 2, STOP = 3, DONE = 4, CLEANUP = 5;

    // Internal wire to receive output from PISO
    wire t20_internal;                                  //cuz we can assign wire to 1 after transmission is stoped


    // instanciation of transmitter and baud gen
    BaudGen instance1(.clk(clk), .tick(tick));
    PISO instance2(.a(datain[7]), .b(datain[6]), .c(datain[5]), .d(datain[4]), .e(datain[3]), .f(datain[2]), .g(datain[1]), .h(datain[0]), .clk(tick), .load(load), .tx(tx), .t20(t20_internal));
    

    // Assign x = '1' when tx = 1 (idle); 
    assign x = (tx == 1'b1) ? 1'b1 : t20_internal;      //this stops data transmission after the stop bit

    // Next state logic acc to stat diagram
    always @(*)
    begin
        case (state)
            IDLE:nstate = LOAD;
            LOAD:nstate = DATA;
            DATA:nstate = (bit_cnt == 8) ? STOP : DATA;
            STOP:nstate = DONE;
            DONE:nstate = CLEANUP;
            CLEANUP: nstate = IDLE;                     //just stops data transmission after the stop bit that's why cleanup state is used
            default: nstate = IDLE;
        endcase
    end

    // conditions for the state to change there state
    always @(posedge tick or posedge reset) 
        begin
            if (reset) 
                begin                                       //reset==1 is used for idle state to stay at ideal state
                    state <= IDLE;
                    tx <= 1;
                    load <= 0;
                    bit_cnt <= 0;
                end 
            else 
                begin
                    state <= nstate;
                    case (state)
                        IDLE: 
                            begin
                                tx <= 1;
                                load <= 0;                  //parallel data loads into register
                                bit_cnt <= 0;
                            end
                        
                        LOAD: 
                            begin
                                tx <= 1;                    //still data transmission not started
                                load <= 1;                  //start shifting data serially
                            end

                        DATA: 
                            begin
                                tx <= 0;                    // at data stage data transmission starts
                                load <= 0;
                                bit_cnt <= bit_cnt + 1;     //data will transmit til bitcnt==8 bits then next stage
                            end

                        STOP: 
                            begin
                                tx <= 1;                    // tx==1 so data transmission stops
                            end

                        DONE: 
                            begin
                                tx <= 1;                    //same here
                            end

                        CLEANUP: 
                            begin                           //just to stop further transmission of wrong bits
                                tx <= 1;
                                load <= 0;                  
                                bit_cnt <= 0;               // bit count reset
                            end
                    endcase
                end
        end

    assign Done = (state == DONE);                      // will print outpt ==1 when transmisson is done 

endmodule
