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

    reg clk, reset;
    reg [7:0] datain;
    wire Done, x, tick;

    FSMTX uut (
        .clk(clk),
        .reset(reset),
        .datain(datain),
        .Done(Done),
        .x(x),
        .tick(tick)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    integer tick_count = 0;
    integer tx_count = 0;

    initial begin
        $display("Starting FSMTX transmission test...");
        datain = 8'b10110011;
        reset = 1; #20; reset = 0;
        $display("Transmission Started for byte: %b", datain);
        $display("Tick\tX\tDone\tTx");

        forever begin
            @(posedge tick);
            tick_count = tick_count + 1;
            $display("%2d\t%b\t%b\t%b", tick_count, x, Done,uut.tx);

            if (Done) begin
                tx_count = tx_count + 1;
                $display("Transmission %0d Done!\n", tx_count);
                if (tx_count == 2) begin
                    $display("✅ Simulation complete after 2 transmissions.");
                    $finish;
                end
                #40;
                datain = (tx_count == 1) ? 8'b11001100 : 8'b00000000; // Only use 2 values
                $display("Starting new transmission for byte: %b", datain);
                reset = 1; #20; reset = 0;
                tick_count = 0;
            end
        end
    end

endmodule

