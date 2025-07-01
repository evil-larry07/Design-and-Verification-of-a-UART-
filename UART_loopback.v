`timescale 1ns/1ps

module uart_loopback_tb;

    // Clock and Reset
    reg clk = 0;
    reg reset;

    // TX-side inputs
    reg [7:0] tx_data;
    wire tx_done;
    wire tx_line;

    // RX-side outputs
    wire [7:0] rx_data;
    wire rx_done;

    // Clock generation: 50MHz = 20ns period
    always #10 clk = ~clk;

    // Instantiate Transmitter
    FSMTX tx_inst (
        .clk(clk),
        .reset(reset),
        .datain(tx_data),
        .Done(tx_done),
        .x(tx_line),      // Serial output
        .tick()           // Optional: leave unconnected
    );

    // Instantiate Receiver
    FSMRX rx_inst (
        .clk(clk),
        .reset(reset),
        .rx(tx_line),     // Serial input from TX
        .dataout(rx_data),
        .Done(rx_done),
        .tick()           // Optional: leave unconnected
    );

    // Test logic
    initial begin
        $display("\n=== UART LOOPBACK TESTBENCH START ===\n");

        // Initialize
        reset = 1;
        tx_data = 8'b0;
        #100;

        reset = 0;
        #100;

        // Send 1st byte
        tx_data = 8'b10101011;  // You can change this
        $display("Sending Byte: %b", tx_data);

        // Wait for TX done
        wait (tx_done);
        $display("TX Done");

        // Wait for RX done
        wait (rx_done);
        $display("RX Done");

        // Check result
        if (rx_data == tx_data) begin
            $display("✅ SUCCESS: Data correctly echoed: %b", rx_data);
        end else begin
            $display("❌ ERROR: Mismatch! Sent: %b, Received: %b", tx_data, rx_data);
        end

        // Finish
        $display("\n=== UART LOOPBACK TEST COMPLETE ===\n");
        $finish;
    end

endmodule
