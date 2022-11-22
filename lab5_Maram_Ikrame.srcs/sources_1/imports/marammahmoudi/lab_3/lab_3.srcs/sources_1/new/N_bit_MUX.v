`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module N_bit_MUX #(parameter n = 32)(input[n-1:0] A, input[n-1:0] B, input sel, output [n-1:0] C );

genvar j;
generate 
for (j=0;j<n;j=j+1) begin : loop2
 MUX2x1 mux2(.newdata(A[j]), .old(B[j]), .sel(sel), .c(C[j]));
end 

endgenerate


endmodule
