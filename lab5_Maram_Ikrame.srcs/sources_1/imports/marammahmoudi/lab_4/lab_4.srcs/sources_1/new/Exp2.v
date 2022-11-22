`timescale 1ns / 1ps



module Register_File #(parameter N= 32)(input clk, input rst, input [4:0] readReg1,
 input [4:0]readReg2, input [4:0]writeReg, input [31:0] Write_data, input RegWrite,
 output [31:0]read_data1,output [31:0]read_data2 );
 
 wire [N-1:0] Q[31:0];
 assign Q[0]=0;
 reg [31:0]load; 
 assign read_data1= Q[readReg1]; 
 assign read_data2= Q[readReg2]; 
  
 always @(*)
 begin 
  load= 32'd0; 
  load[writeReg]= RegWrite; 
 end
 
 
genvar i;
generate
   for (i=1; i < N;i=i+1)
   begin: loop1
       N_bit_register inst1( clk, load[i], rst, Write_data, Q[i]);
   end
endgenerate
		
 
endmodule
