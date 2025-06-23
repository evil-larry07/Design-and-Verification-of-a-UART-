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

module uart_tb;

    reg [7:0] datain;
    reg clk, reset, start;
    wire Done, tx, x;

    FSMTX uut (
        .datain(datain),
        .clk(clk),
        .reset(reset),
        .start(start),
        .Done(Done),
        .tx(tx),
        .x(x)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting FSMTX Testbench...");

        // Initial values
        clk = 0;
        reset = 1;
        start = 0;
        datain = 8'b10101010;

        #20;
        reset = 0;
        #10;

        start = 1;
        #10;
        start = 0;

        // Monitor key signals
        $monitor("Time=%0t | reset=%b | start=%b | tx=%b | Done=%b | x=%b", 
                  $time, reset, start, tx, Done, x);

        // Run long enough for full transmission
        #5000000;

        $display("Finished transmission.");
        $finish;
    end

endmodule




