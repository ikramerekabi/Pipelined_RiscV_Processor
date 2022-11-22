`timescale 1ns / 1ps


module NBit_lAU#(parameter N= 32)(input [N-1:0]a, input [N-1:0]b, input [3:0]sel , output reg  [N-1:0] ALU_output, 
output reg zero_flag); 
 wire [N-1:0] sum_inp; 
 add_sub inst(a, b, sel , sum_inp);
 always @(*)
 begin

     if(sel == 4'b0010)
     begin
     ALU_output= sum_inp;
     end
     else if(sel == 4'b0110)
     begin
     ALU_output= sum_inp;
     end
    
     else if(sel == 4'b0000)
     begin
     ALU_output= a&b;
     end
     
     else if(sel == 4'b0001)
     begin
     ALU_output= a|b;
     end
     else 
     begin 
     ALU_output= 0;
     end

 end

 always @(*)
    begin
    if(ALU_output== 0)
    begin
    zero_flag=1;
    end
    else
    begin
    zero_flag=0;
    end
    
    end


endmodule
