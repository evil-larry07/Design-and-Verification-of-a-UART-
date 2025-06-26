module BaudGen(
    input clk,
    output reg tick
);

    reg [12:0] count = 0;           //cuz 5208 requiers 13 bit in binary 

    always @(posedge clk) 
    begin                   
        if(count >= 19)                        // 20 clock cycles per baud cuz easy for simmulation purpose
            begin
                count <= 0;
                tick <= 1;
            end 
        else 
            begin
                count <= count + 1;
                tick <= 0;
            end
    end

endmodule
                 
