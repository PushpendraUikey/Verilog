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

`include "moduel_eg.v"
module testmux;
reg a, b, s;
wire f;
reg expected;

mux2 uut(.select(s), .in0(a), .in1(b), .out(f));

 initial 
  begin 
         s=0; a=0; b=1; expected=0; 
          #10 a=1; b=0; expected=1; 
          #10 s=1; a=0; b=1; expected=1; 
        end 
   initial 
        $monitor( 
            "select=%b in0=%b in1=%b out=%b, expected out=%b time=%d", 
             s, a, b, f, expected, $time); 
    endmodule // testmux