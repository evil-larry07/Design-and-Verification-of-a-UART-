module BaudGen(
    input clk,
    output reg tick
);
    integer baudrate=5208;      // 50MHz / 9600 (desired Baudrate)   =   5208          target Baudrate for tick
    integer count=0;
    always @(posedge clk)
    begin
        if(count<baudrate)
        begin
            tick=0;
            count++;
        end
        else
            begin
                tick=1;
                count=0;
            end

    end
endmodule

