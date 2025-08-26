`timescale 1ns/1ps

module UART_TB();

    reg clk;
    reg reset;
    reg [7:0] datain;
    wire DoneTX, DoneRX;
    wire tx_line, tick_tx, tick_rx;
    wire [7:0] dataout;

    // Instantiate Transmitter
    FSMTX transmitter(
        .clk(clk),
        .reset(reset),
        .datain(datain),
        .Done(DoneTX),
        .x(tx_line),       // tx_line connected to receiver input
        .tick(tick_tx)
    );

    // Instantiate Receiver
    FSMRX receiver(
        .clk(clk),
        .rx(tx_line),      // Connected to transmitter output
        .Done(DoneRX),
        .dataout(dataout),
        .tick(tick_rx)
    );

    // Clock generation (50MHz simulation style)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 20ns period (50 MHz)
    end

    // Test stimulus
    initial begin
        $dumpfile("uart_tb.vcd");
        $dumpvars(0, UART_TB);

        reset = 1;
        datain = 8'b00110011; // Example data to transmit
        #50 reset = 0;

        // Wait until transmitter is Done
        wait(DoneTX);
        $display("Transmitter finished sending data: %b", datain);

        // Wait until receiver is Done
        wait(DoneRX);
        $display("Receiver received data: %b", dataout);

        // Check if transmission is successful
        if(dataout == datain)
            $display("TEST PASSED: Data correctly transmitted and received!");
        else
            $display("TEST FAILED: Mismatch in transmitted and received data!");

        #100 $finish;
    end

endmodule
