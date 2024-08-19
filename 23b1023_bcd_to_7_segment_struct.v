module assignment(x1,x2,x3,x4,a,b,c,d,e,f,g);
input x1,x2,x3,x4;
output a,b,c,d,e,f,g;
wire k1, k2, k3, k4;



not (k1, x1);
not (k2, x2);
not (k3, x3);
not (k4, x4);


//// output   a 
wire t1_a, t2_a, t3_a;
and (t1_a, x2, x4);
and (t2_a, x2, k3);
and (t3_a, k2, k4);

or (a, k1, t1_a, t2_a, t3_a);


////// output  b
wire t1_b, t2_b;
and (t1_b, k3, k4);
and (t2_b, x3, x4);

or (b, k1, x2, t1_b, t2_b);


//// output c
or (c, k1, k2, x3, k4);

//// output d
wire t1_d, t2_d, t3_d, t4_d;
and (t1_d, k2, k3, k4);
and (t2_d, k1, k2, x3);
and (t3_d, k1, x2, x3, k4);
and (t4_d, k1, x2, k3, x4);

or (d, t1_d, t2_d, t3_d, t4_d);


//// output e
wire t1_e, t2_e;
and (t1_e, k1, x3, k4);
and (t2_e, k2, k3, k4);

or (e, t1_e, t2_e);

//// output f
wire t1_f, t2_f, t3_f, t4_f;
and (t1_f, k1, k3, k4);
and (t2_f, x1, k2, k3);
and (t3_f, k1, x2, k3, x4);
and (t4_f, k1, x2, x3, k4);

or (f, t1_f, t2_f, t3_f, t4_f);


///// output g 
wire t1_g, t2_g, t3_g, t4_g;
and (t1_g, x1, k2, k3);
and (t2_g, k1, x2, k3);
and (t3_g, k1, k2, x3);
and (t4_g, k1, x2, x3, k4);

or (g, t1_g, t2_g, t3_g, t4_g);

endmodule
