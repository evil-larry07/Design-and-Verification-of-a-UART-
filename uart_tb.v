module testb ;
reg t1;
wire t3;
reg t2;
 DFF1 instance1(.D(t1), .clk(t2), .Q(t3));
 initial begin
    t2 = 0;
    #50 $finish;
 end
 always #5 t2=~t2;
 initial
 begin
    $monitor("%t %d %d", $time , t1 , t3);
    #2 t1= 1'b0;
    #7 t1= 1'b1;
 end
endmodule