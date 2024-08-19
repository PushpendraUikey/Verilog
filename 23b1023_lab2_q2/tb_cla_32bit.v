`include "cla_Nbit.v"
`timescale 1ns/1ps

module tb_cla_32bit;

parameter N = 32;     /*Change this to 16 if you want to test CLA 16-bit*/

reg [N-1:0] a;
reg [N-1:0] b;

wire [N-1:0] S;

wire cin, cout, Pout, Gout;
assign cin = 0;
// declare your signals as reg or wire

initial begin

// write the stimuli conditions
    a=32'b1010; b = 32'b1001;
	#10

	a=32'b1001001010; b = 32'b100101010;
	#10

    a = 32'b001001; b = 32'b0100101010101;
    #10

    a = 32'b11111111111111111111111111111111;
    b = 32'b00000000000000000000000000000001;
    #10

    a = 32'b00001111000011110000111100001111;
    b = 32'b11110000111100001111000011110000;
    #10

    a = 32'b01111111111111111111111111111111;
    b = 32'b00000000000000000000000000000001;
    #10

    a = 32'b01010101010101010101010101010101;
    b = 32'b10101010101010101010101010101010;
    #10

    a = 32'b11111111111111111111111111111111;
    b = 32'b11111111111111111111111111111111;
    #10

    a = 32'b01111111111111111111111111111111;
    b = 32'b00000000000000000000000000000001;
    #10

	$finish;

end

CLA_32bit uut (.a(a), .b(b), .cin(cin), .sum(S), .cout(cout), .Pout(Pout), .Gout(Gout));


initial begin
    $dumpfile("cla_32bit.vcd");
    $dumpvars(0, tb_cla_32bit);
    $display("Name: Pushpendra Uikey");
	$display("Roll Number: 23b1023");
	$monitor("a=%b b=%b sum=%b cout=%b Pout=%b Gout=%b", a, b, S, cout, Pout, Gout);
end

endmodule