`timescale 1ns / 1ps

module FSMRX_tb;

    reg clk = 0;
    reg rx = 1;
    wire Done;
    wire [7:0] dataout;
    wire tick;

    FSMRX uut (
        .clk(clk),
        .rx(rx),
        .Done(Done),
        .dataout(dataout),
        .tick(tick)
    );

    // Clock generation
    always #1 clk = ~clk;  // 500MHz for 20ns baud tick

    task send_byte;
        input [7:0] data;
        integer i;
        begin
            // Start bit
            rx = 0; repeat (20) @(posedge clk);
            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                repeat (20) @(posedge clk);
            end
            // Stop bit
            rx = 1; repeat (20) @(posedge clk);
        end
    endtask

    initial begin
        $dumpfile("FSMRX_tb.vcd");
        $dumpvars(0, FSMRX_tb);

        $display("Starting FSMRX test...");

        @(posedge clk);
        $display("Sending first byte: 00011001");
        send_byte(8'b00011001);
        wait (Done); #5;
        $display("Received: %b", dataout);

        

        $display("FSMRX test complete.");
        $finish;
    end
endmodule
