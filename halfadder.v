module halfadder(a,b,c_in, s, c_out);

input a, b, c_in;
output s, c_out;

assign s = a ^ b ^ c_in;
assign c_out = (a&b) | (c_in&b) | (a&c_in);

endmodule