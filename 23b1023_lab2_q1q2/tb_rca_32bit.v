`include "rca_Nbit.v"

module rca_checker;

reg [31:0] a, b;
wire [31:0] c;


rca_Nbit uut(
	.a(a),
	.b(b),
	.c(c)
);

initial begin
	a=32'b1010; b = 32'b1001;
	#10
	a=32'b1001001010; b = 32'b100101010;
	#10
	$finish;
end

initial begin
	$dumpfile("temp.vcd");
	$dumpvars(0, rca_checker);
	$display("Name: Pushpendra Uikey");
	$display("Roll Number: 23b1023");
	$monitor("a=%b b=%b c=%b", a, b, c);
end

endmodule
