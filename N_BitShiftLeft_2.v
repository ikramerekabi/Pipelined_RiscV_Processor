`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 07:11:16 PM
// Design Name: 
// Module Name: N_BitShiftLeft_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module N_BitShiftRight_2 #(parameter N=32) (input [N-1:0]A, output [N-1:0]out);

assign out = { 2'b00,  A[N-1:2]};

endmodule

