module circuit(f,a,b,c,d);

input a, b, c, d;
output f;
wire w1, w2, w3;

and a1(w1, a, b);
xor x1(w2, w1, w3);
or o1(w3, c, d);
and a2(f,w2, w3);

endmodule

module reg_ex1(input wire clk); 
reg Q; wire D; 
always @(posedge clk) Q=D; 
endmodule

module assignments; 
     reg R; 
     initial R<=#20 3; 
     initial begin 
         R=5; R=#35 2; 
     end 
     initial begin 
         R<=#100 1; 
         #15 R=4; 
         #220; 
         R=0; 
      end 
     endmodule
