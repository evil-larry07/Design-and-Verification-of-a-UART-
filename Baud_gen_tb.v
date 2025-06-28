`timescale 1ns/1ps

module BaudGen_tb;

    // Testbench signals
    reg clk;
    wire tick;

    // Instantiate the BaudGen module
    BaudGen uut (
        .clk(clk),
        .tick(tick)
    );

    // Clock generation: 50 MHz (20 ns period)
    always #10 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;

        // Run simulation for a certain duration
        #110000 $finish;
    end

    // Monitor tick
    initial begin
        $monitor("Time: %0dns, Tick: %b    %d", $time, tick,uut.count);
    end

endmodule
