`timescale 1ns / 1ps

module N_bit_register #(parameter N=32)(input clk, input load, input rst, 
input [N-1:0] D, output [N-1:0] Q);
genvar i; 
wire [N-1:0] DF_input ;
generate 
  for (i= 0; i<N; i= i+1) begin: loop1
   MUX2x1 mux1(.newdata(D[i]), .old(Q[i]),  .sel(load), .c(DF_input[i]));
  DFlip_flop d_ff( .clk(clk), .rst(rst), .D(DF_input[i]), .Q(Q[i]));
   
  
  end
 
endgenerate
endmodule
