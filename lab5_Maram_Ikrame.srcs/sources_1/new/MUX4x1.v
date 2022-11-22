`timescale 1ns / 1ps


module MUX4x1  ( input  a, input  b, input  c, input  d,
input [1:0]sel,  output  out );

assign out = sel[1] ? (sel[0] ? d : c ) : (sel[0] ? b:a ) ; 

endmodule
