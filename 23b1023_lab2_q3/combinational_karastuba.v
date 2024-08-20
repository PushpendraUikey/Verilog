
module mul (
    input [7:0] A,
    input [7:0] B,
    output [15:0] P
);
    assign P = A * B;
endmodule

module adder (
    input [15:0] A,
    input [15:0] B,
    output [15:0] S
);
    assign S = A + B;  
endmodule

module sub (
    input [15:0] A,
    input [15:0] B,
    output [15:0] S
);
    assign S = A - B;  
endmodule

module karatsuba_16 (
    input [15:0] X,
    input [15:0] Y,
    output [31:0] Z
);

    /// halve = 2 ^ 8

    /// X = a * halve + b
    wire [7:0] a = X[15:8];
    wire [7:0] b = X[7:0];

    /// Y = c * halve + d
    wire [7:0] c = Y[15:8];
    wire [7:0] d = Y[7:0];


    wire [15:0] M1, M2, M3, M4;  
    wire [15:0] A1;
    wire [15:0] S;
    
    
    mul temp1 (.A(a), .B(c), .P(M1));       //// ac

    mul temp2 (.A(b), .B(d), .P(M2));       //// bd

    mul temp3 (.A(a+b), .B(c+d), .P(M3));       ////  (a + b) * (c + d)


    // Adders to compute intermediate sums
    adder add1 (.A(M1), .B(M2), .S(A1));    ///// ac + bd
    sub sub1 (.A(M3), .B(A1), .S(S));       //// ad + bc 

    //// result  ac * 2 ^16 + (ad + bc) * 2^8 + bd 

            /// multiply 2^16       multiply 2^8
    assign Z =   (M1 << 16)    +    (S << 8)     +     M2;  // Combine results

endmodule

///// unbale to handle the overflows
