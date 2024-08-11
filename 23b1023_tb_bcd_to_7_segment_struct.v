`include "23b1023_bcd_to_7_segment_struct.v"
module assignment_tb;

reg x1, x2, x3, x4;

wire a,b,c,d,e,f,g;

assignment uut(
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .x4(x4),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
);

initial begin
    
    #20 x1=0; x2=0; x3=0; x4=1;

    #20 x1=0; x2=0; x3=1; x4=0;

    #20 x1=0; x2=0; x3=1; x4=1;

    #20 x1=0; x2=1; x3=0; x4=0;

    #20 x1=0; x2=1; x3=0; x4=1;

    #20 x1=0; x2=1; x3=1; x4=0;

    #20 x1=0; x2=1; x3=1; x4=1;

    #20 x1=1; x2=0; x3=0; x4=0;

    #20 x1=1; x2=0; x3=0; x4=1;

    #20 x1=0; x2=0; x3=0; x4=0;
    $finish;
end

initial begin
    $dumpfile("temp.vcd"); 
    $dumpvars(0, assignment_tb);
    $display("Name : Pushpendra Uikey");
    $display("Roll Number : 23b1023");
    $monitor("x1=%b x2=%b x3=%b x4=%b A=%b B=%b C=%b D=%b E=%b F=%b G=%b", x1, x2, x3, x4, a, b, c, d, e, f, g);
end


endmodule


