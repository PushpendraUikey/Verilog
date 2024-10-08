module fulladd4(sum, c_out, a, b, c_in);

output [3:0] sum;
output c_out;

input [3:0] a, b;
input c_in;

assign {c_out, sum} = a + b + c_in;

endmodule