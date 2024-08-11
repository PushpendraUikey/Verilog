module addbit(  // Module declaration
    a,
    b,
    ci,
    sum,
    co
);

input a, b, ci; // Input declaration
output co, sum; // output declaration

assign {co, sum} = a + b + ci;

endmodule