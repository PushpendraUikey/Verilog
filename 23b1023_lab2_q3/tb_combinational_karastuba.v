`include "combinational_karastuba.v"

module tb_karastuba_16;

reg [15:0] X;
reg [15:0] Y;
wire [31:0] P;

karatsuba_16 uut (.X(X), .Y(Y), .Z(P));

initial begin
    X = 16'b0010001001010;
    Y = 16'b000001000001;
    #10
    X = 16'b0010101011010;
    Y = 16'b0011111100111;
    #10
    $finish;
end

initial begin
    $dumpfile("karatsuba_16.vcd");
    $dumpvars(0, tb_karastuba_16);
    $display("Name: Pushpendra Uikey");
	$display("Roll Number: 23b1023");
	$monitor("X=%b Y=%b P=%b ", X, Y, P);
end

endmodule

//1098 * 65 = 71370
// 2023 * 1370 = 2771510

