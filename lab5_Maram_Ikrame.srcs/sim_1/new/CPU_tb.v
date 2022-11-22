`timescale 1ns / 1ps


module CPU_tb();
reg clk; 
reg rst;

Single_Cycle_CPU inst1( rst,  clk);

initial begin
clk = 1'b0; 
forever begin 
clk =~clk; 
#2; 
end
end

initial begin 
rst = 1; 
#2; 
rst =0; 

end 

endmodule
