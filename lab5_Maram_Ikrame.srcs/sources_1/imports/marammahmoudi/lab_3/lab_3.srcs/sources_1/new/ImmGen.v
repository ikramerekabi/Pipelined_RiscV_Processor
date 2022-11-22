`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 07:41:44 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(input [31:0]inst, output reg [31:0] gen_out );
 wire opcode5;
 wire opcode6;
 reg [11:0] imm; 
 assign opcode5 = inst[5];
 assign opcode6 = inst[6];
always @(*)
begin 
    if(opcode6==1)
    begin 
    //beq
     imm= {inst[31], inst[7], inst[30:25], inst[11:8]};
     if(imm[11]==1)begin
        gen_out = {20'hfffff,imm[11:0]};
     end
     else
     begin
        gen_out = {20'h00000,imm[11:0]};
     end
    end
else 
begin 
//load word
    if(opcode5==0)
        begin 
        if(inst[31]==1)begin
         gen_out = {20'hfffff,inst[31:20]};
        end
        else
        begin
         gen_out = {20'h00000,inst[31:20]};
        end
    end 
    else begin
      imm = {inst[31:25],inst[11:7]};
     //sw
      if(imm[11]==1)begin
         gen_out = {20'hfffff,imm[11:0]};
        end
        else
        begin
         gen_out = {20'h00000,imm[11:0]};
        end
    end



end 





end




endmodule
