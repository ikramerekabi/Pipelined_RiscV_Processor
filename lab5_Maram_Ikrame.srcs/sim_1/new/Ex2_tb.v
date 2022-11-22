`timescale 1ns / 1ps


module Ex2_tb( );
reg [5:0] addr; 
reg [31:0] datin; 
reg MemWrite;
reg MemRead;
reg clk; 
wire [31:0] data_out;

DataMem  inst1( clk,  MemRead, MemWrite,  addr,  datin, data_out);
initial begin
clk = 1'b0; 
forever begin 
clk =~clk; 
#2; 
end
end

initial begin 
addr = 6'b000001;
datin = 32'd9;
MemWrite = 1'b0; 
MemRead = 1'b1;
#10; 
addr = 6'b000010;
datin = 32'd16;
MemWrite = 1'b1; 
MemRead = 1'b0;
#10; 
addr = 6'b000001;
datin = 32'd11;
MemWrite = 1'b1; 
MemRead = 1'b1;
#10; 
end 

endmodule
