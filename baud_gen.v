module BaudGen(
    input clk,
    output reg tick
);

    reg [4:0] count = 0;                       //cuz 20 requiers 5 bit in binary 

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
                 
