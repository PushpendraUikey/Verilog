
module CLA_4bit(
    a,
    b,
    cin,
    sum,
    cout
);

input [3:0] a;
input [3:0] b;
input cin;
output [3:0] sum;
output cout;

wire g0, g1, g2, g3;
wire p0, p1, p2, p3;
wire c1, c2, c3;

/// Propagate signals
xor (p0, a[0], b[0]);
xor (p1, a[1], b[1]);
xor (p2, a[2], b[2]);
xor (p3, a[3], b[3]);

//// generate signals;
and (g0, a[0], b[0]);
and (g1, a[1], b[1]);
and (g2, a[2], b[2]);
and (g3, a[3], b[3]);

/// carry signals;
assign c1 = g0 | (p0&cin);
assign c2 = g1 | (p1&g0) | (p1&p0&cin);
assign c3 = g2 | (p2 & g1) | (p2&p1&g0) | (p2&p1&p0&cin);
assign cout = g3 | (p3 & g2) | (p3&p2&g1) | (p3&p2&p1&g0) | (p3&p2&p1&p0&cin);

assign sum[0] = (p0 ^ cin);
assign sum[1] = (p1 ^ c1);
assign sum[2] = (p2 ^ c2);
assign sum[3] = (p3 ^ c3);

endmodule

module CLA_4bit_P_G(
    a,
    b,
    cin,
    sum,
    P,
    G
);

input [3:0] a;
input [3:0] b;
input cin;
output [3:0] sum;
output P, G;

wire g0, g1, g2, g3;
wire p0, p1, p2, p3;
wire c1, c2, c3;

/// Propagate signals
xor (p0, a[0], b[0]);
xor (p1, a[1], b[1]);
xor (p2, a[2], b[2]);
xor (p3, a[3], b[3]);

//// generate signals;
and (g0, a[0], b[0]);
and (g1, a[1], b[1]);
and (g2, a[2], b[2]);
and (g3, a[3], b[3]);

//// carry generation
assign c1 = g0 | (p0&cin);
assign c2 = g1 | (p1&g0) | (p1&p0&cin);
assign c3 = g2 | (p2 & g1) | (p2&p1&g0) | (p2&p1&p0&cin);
// assign cout = g3 | (p3 & g2) | (p3&p2&g1) | (p3&p2&p1&g0) | (p3&p2&p1&p0&cin);

//// final sum
assign sum[0] = (p0 ^ cin);
assign sum[1] = (p1 ^ c1);
assign sum[2] = (p2 ^ c2);
assign sum[3] = (p3 ^ c3);

//// P and G assignment

assign P = (p0 & p1 & p2 & p3);
assign G = g3 | (p3&g2) | (p3&p2&g1) | (p3&p2&p1&g0) ;

endmodule

module lookahead_carry_unit_16_bit( 
    P0, 
    G0, 
    P1, 
    G1, 
    P2, 
    G2, 
    P3, 
    G3, 
    cin, 
    C4, 
    C8, 
    C12, 
    C16, 
    GF, 
    PF
);
input P0, P1, P2, P3;
input G0, G1, G2, G3;
input cin;
output C4, C8, C12, C16;
output PF, GF;

assign C4 = G0 | (P0 & cin);
assign C8 = G1 | (P1 & C4);
assign C12 = G2 | (P2 & C8);
assign C16 = G3 | (P3 & C12);

assign PF = (P0 & P1 & P2 & P3);
assign GF = G3 | (G2 & P3) | (G1 & P3 & P2) | (G0 & P3 & P2 & P1);

endmodule

module CLA_16bit(
    a,
    b,
    cin,
    sum, 
    cout, 
    Pout, 
    Gout
);
input [15:0] a;
input [15:0] b;
input cin;
output cout;
output [15:0] sum;
output Pout, Gout;

wire p0, p1, p2, p3;   
wire g0, g1, g2, g3;

wire c4, c8, c12;    //// for carries;

//// first 4 bit addition
CLA_4bit_P_G temp1(a[3:0], b[3:0], cin, sum[3:0], p0, g0);
// lookahead_carry_unit_16_bit t1(a[3:0], b[3:0], cin, c1);

//// second 4 bit addition
CLA_4bit_P_G temp2(a[7:4], b[7:4], c4, sum[7:4], p1, g1);
// lookahead_carry_unit_16_bit t2(a[3:0], b[3:0], c1, c2);

//// third 4 bit addition
CLA_4bit_P_G temp3(a[11:8], b[11:8], c8, sum[11:8], p2, g2);
// lookahead_carry_unit_16_bit t3(a[11:8], b[11:8], c2, c3);

//// last 4 bit addition
CLA_4bit_P_G temp4(a[15:12], b[15:12], c12, sum[15:12], p3, g3);
// lookahead_carry_unit_16_bit t4(a[15:12], b[15:12], c3, carry);

lookahead_carry_unit_16_bit temp(p0, g0, p1, g1, p2, g2, p3, g3, cin, c4, c8, c12, cout, Pout, Gout);

endmodule


module CLA_32bit(a, b, cin, sum, cout, Pout, Gout);

input [31:0] a;
input [31:0] b;
input cin;
output [31:0] sum;
output cout;
output Pout, Gout;

wire p0, p1, g0, g1;
wire c16;

CLA_16bit cla1(a[15:0], b[15:0], cin, sum[15:0], c16, p0, g0);

CLA_16bit cla2(a[31:16], b[31:16], c16, sum[31:16], cout, p1, g1);

// assign Pout = p0;
// assign Gout = g0;

lookahead_carry_unit_32_bit temp_(p0, g0, p1, g1, Pout, Gout);

endmodule

// module lookahead_carry_unit_32_bit (P0, G0, P1, G1, cin, C16, C32, PF, GF);
module lookahead_carry_unit_32_bit(P0, G0, P1, G1, PF, GF);
    input P0, P1;
    input G0, G1;
    // input cin;
    // output C16, C32;
    output GF, PF;

    // assign C16 = G0 | (P0 & cin);
    // assign C32 = G1 | (P1 & C16);

    assign PF = P0 & P1;
    assign GF = G1 | (G0 & P1);

endmodule
