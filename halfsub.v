module half_sub(borrow, difference, a, b);

input a, b;
output = borrow , difference;

wire w1;

xor x1(difference, a, b);
not n1(w1, a);
and a1(borrow, w1, b);

endmodule
