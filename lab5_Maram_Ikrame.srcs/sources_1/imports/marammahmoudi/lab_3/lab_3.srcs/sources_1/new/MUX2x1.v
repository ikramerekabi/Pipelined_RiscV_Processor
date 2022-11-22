`timescale 1ns / 1ps


module MUX2x1(input newdata, input old, input sel, output c);

assign c = sel ? newdata : old;

endmodule
