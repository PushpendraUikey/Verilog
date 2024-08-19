
module half_adder(
	 a,
	 b,
	 S,
	 cout
);

input a, b;
output S, cout;

xor (S, a, b);
and (cout, a, b);

endmodule




module full_adder(
	 a,
	 b, 
	 cin,
	 S,
	 cout
);
input a, b, cin;
output S, cout;

wire s_, c_, c_1;

// instantiating half adder.

half_adder Inst1(a, b, s_, c_); /// it will give s_=a^b and c_ = a.b 

xor (S, s_, cin);
and (c_1, cin, s_);

// Final sum here

or (cout, c_1, c_); // final cout


endmodule





module rca_Nbit #(parameter N = 32) (a, b, cin, S, cout);

input [N-1:0] a;
input [N-1:0] b;
input cin;
output [N-1:0] S;
output cout;
wire [N-1:0] carry;
//wire c_o, c_;
//assign c_ = 0;
// wire c_;
// assign c_=0;

generate 
	genvar i;
	for( i = 0; i < N; i = i+1 ) begin
		if(i==0)begin
			full_adder p(a[i], b[i], cin, S[i], carry[i]);
		end
		else begin
	         full_adder p(a[i], b[i], carry[i-1], S[i], carry[i]);
	 end
	end
endgenerate

assign cout = carry[N-1];

endmodule
