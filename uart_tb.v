// module testb ;
// reg t1;
// wire t3;
// reg t2;
//  DFF1 instance1(.D(t1), .clk(t2), .Q(t3));
//  initial begin
//     t2 = 0;
//     #50 $finish;
//  end
//  always #5 t2=~t2;
//  initial
//  begin
//     $monitor("%t %d %d", $time , t1 , t3);
//     #2 t1= 1'b0;
//     #7 t1= 1'b1;
//  end
// endmodule

`timescale 1ns / 1ps

module FSMTX_tb;

    // Inputs
    reg clk;
    wire x;
    reg [7:0] datain;

    // Outputs
    wire Done;

    // Instantiate the FSMTX module
    FSMTX uut (
        .datain(datain),
        .clk(clk),
        .Done(Done),
        .x(x)
    );

    // Generate a clock with 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        datain = 8'b10101010;  // Example UART data byte (LSB first)

        // Display simulation start
        $display("Starting FSMTX simulation...");
        $monitor("Time = %0t | Data = %b | Done = %b |  %d ", $time, datain, Done,x);

        // Wait 1000 ns to allow FSM to complete full transmission
        #1000;

        // Change input to test another transmission
        datain = 8'b11001100;

        #1000;

        $display("Simulation complete.");
        $finish;
    end

endmodule

