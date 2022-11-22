`timescale 1ns / 1ps

module add_sub #(parameter N= 32)(input [N-1:0]a, input [N-1:0]b, input [3:0]sel , output  [N-1:0] sum); 

//wire [N-1:0] mux_out; 
//wire cout;
//N_bit_MUX inst(b, !b,  sel[2],mux_out );


//(input [N-1:0]a, input [N-1:0]b, output [N-1:0]sum,input carryin, output cout);

assign sum = sel[2]? (a+ (~b+1)) : a+b;

endmodule
