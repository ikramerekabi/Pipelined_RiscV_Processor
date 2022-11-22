`timescale 1ns / 1ps

module N_bit_shiftleft #(parameter N=32)(input [N-1:0]A, output [N-1:0]out);

assign out = {  A[N-2:0], 1'b0};

endmodule
