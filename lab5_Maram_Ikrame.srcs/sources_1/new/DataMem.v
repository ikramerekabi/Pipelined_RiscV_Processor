`timescale 1ns / 1ps


module DataMem(input clk, input MemRead, input MemWrite, input [2:0]fn3_store , input [5:0] addr, input [31:0] data_in, 
output reg [31:0] data_out);
 reg [31:0] mem [0:63];
 initial begin
 mem[0]=32'd17;
 mem[1]=32'd9;
 mem[2]=32'd25;
 mem[3]= 32'd1; 
 mem[4]= 32'd0; 
 mem[5]= 32'd22;

 end
 always @(*)
 begin 
 if(MemRead == 1'b1)
  data_out= mem[addr];
  else
   data_out= 32'd0;
 end
 always @(posedge clk)
 begin
  if(MemWrite == 1'b1)
        if(fn3_store==3'b010) // sw 
         mem[addr]= data_in;
        else  if(fn3_store==3'b000) //sb 
         mem[addr]= data_in[7:0];
        else  if(fn3_store==3'b001) //sh
         mem[addr]= data_in[15:0];
 end
 

endmodule
