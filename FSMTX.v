module FSMTX(
    input [7:0]datain,
    input clk,
    output Done,
    output x
);
    reg tx,load;
    wire tick;
    BaudGen instance1(.clk(clk), .tick(tick));
    PISO instance2(.a(datain[7]), .b(datain[6]), .c(datain[5]), .d(datain[4]), .e(datain[3]), .f(datain[2]), .g(datain[1]), .h(datain[0]), .clk(tick), .load(load), .tx(tx), .t20(x));

    parameter idle=3'b000, start=3'b001, data=3'b010, stop=3'b011, done=3'b100;

    reg [2:0] state,nstate;
    integer i;
    always @(*)
    begin
        case(state)
            idle:
            begin
                tx =0;
                nstate<=tx?idle:start;
                
            end
            start:
            begin
                tx = 0;
                nstate<=data;
            end
            data:
            begin

                nstate<=stop;
                tx<=1;
            end
            stop:nstate<=done;
            done:nstate<=idle;
            default:nstate<=idle;
        endcase
    end
always @(posedge clk)
begin
    state<=nstate;
    if(nstate == stop)  
    begin
        for ( i=0 ;i<8 ;i=i+1 ) 
            begin
                load<=0;
            end
            load=1;
    end
end
assign Done = (state==done)? 1 : 0;
endmodule