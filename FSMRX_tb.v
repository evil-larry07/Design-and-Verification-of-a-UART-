`timescale 1ns / 1ps

module FSMRX_tb;

    reg clk, reset;
    reg rx;
    wire [7:0] dataout;
    wire Done;
    wire tick;

    FSMRX uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .dataout(dataout),
        .Done(Done),
        .tick(tick)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Send byte 8'b10110011 over rx (LSB first), with start=0, stop=1
    reg [9:0] frame = 10'b1_10110011_0;  // Stop, Data[7:0], Start
    integer i;

    // For tracking Done rising edge
    reg prev_done;
    reg final_printed;

    initial begin
        // Init
        rx = 1;
        reset = 1;
        prev_done = 0;
        final_printed = 0;

        #20;
        reset = 0;

        // Wait a little before transmission
        repeat (10) @(posedge clk);

        // Transmit all bits in frame (1 baud = 20 clk cycles)
        for (i = 0; i < 10; i = i + 1) begin
            rx = frame[i];
            repeat (20) @(posedge clk);  // 1 baud per bit
        end

        rx = 1; // line idle
        repeat (60) @(posedge clk);  // allow FSM to reach DONE

        $finish;
    end

    // Trace all behavior every posedge clk
    always @(posedge clk) begin
        $display("rx=%b | tick=%b | Done=%b | dataout=%b", rx, tick, Done, dataout);

        // Print final result only once
        if (Done && !prev_done) 
        begin
            $display(" Final Output -> dataout=%b (Done signal went high)", dataout);
            $finish;  //  End simulation right after printing
        end


        prev_done <= Done;
    end

endmodule

//so reception start at rx==0 but each bit is receivd per tick only
