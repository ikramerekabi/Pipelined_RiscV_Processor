`timescale 1ns / 1ps



module N_BIT_4x1mux#(parameter N = 32)(input[N-1:0] a, input[N-1:0] b,input[N-1:0] c, input[N-1:0] d, input [1:0]sel, output [N-1:0] out );

genvar j;
generate 
for (j=0;j<N;j=j+1) begin : loop2
MUX4x1 MUX4 ( .a(a[j]), .b(b[j]),.c(c[j]), .d(d[j]),.sel(sel), .out(out[j]) );
//MUX2x1 mux2(.newdata(A[j]), .old(B[j]), .sel(sel), .c(C[j]));
end 

endgenerate


endmodule